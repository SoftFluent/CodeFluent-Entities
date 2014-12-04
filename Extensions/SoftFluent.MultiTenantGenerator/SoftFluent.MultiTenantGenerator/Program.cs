using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Reflection;
using CodeFluent.Model;
using CodeFluent.Producers.Database;
using CodeFluent.Producers.SqlServer;
using CodeFluent.Runtime.Utilities;

namespace SoftFluent.MultiTenantGenerator
{
    class Program
    {
        private static readonly HashSet<IProducer> _producers = new HashSet<IProducer>();
        private static string _schema;
        private static string _projectPath;
        private static bool _changeTargetDirectory;
        private static bool _disableNonPersistenceProducers;

        static void Main()
        {
            _projectPath = CommandLineUtilities.GetArgument("path", (string)null) ?? CommandLineUtilities.GetArgument(0, (string)null);
            _schema = ConvertUtilities.Nullify(CommandLineUtilities.GetArgument("schema", (string)null) ?? CommandLineUtilities.GetArgument(1, (string)null), true);
            _changeTargetDirectory = CommandLineUtilities.GetArgument("changeTargetDirectory", true);
            _disableNonPersistenceProducers = CommandLineUtilities.GetArgument("disableNonPersistenceProducers", true);

            // Load the model
            Project project = new Project();
            project.Entities.ListChanged += Entities_ListChanged; // Change schema as soon as the entity is loaded
            project.Load(_projectPath, ProjectLoadOptions.Default);

            // Update producer target directory
            if (!string.IsNullOrEmpty(_schema) && _changeTargetDirectory)
            {
                foreach (var producer in project.Producers)
                {
                    var sqlServerProducer = producer.Instance as SqlServerProducer;
                    if (sqlServerProducer != null)
                    {
                        sqlServerProducer.Production += SqlServerProducer_Production;
                    }

                    var databaseProducer = producer.Instance as DatabaseProducer;
                    if (databaseProducer != null)
                    {
                        databaseProducer.Production += DatabaseProducer_Production;
                    }
                }
            }

            // Generate code
            project.Producing += OnProjectProduction;
            ProductionOptions productionOptions = BuildProductionOptions(project);
            project.Produce(productionOptions);
            Console.WriteLine();
        }

        private static bool _inline;
        private static void OnProjectProduction(object sender, ProductionEventArgs e)
        {

            if ((e.EventType == ProductionEventType.ProducerStart) ||
                (e.EventType == ProductionEventType.SubProducerInitialize) ||
                (e.EventType == ProductionEventType.ModelLoad) ||
                (e.EventType == ProductionEventType.Warning) ||
                ((e.EventType & ProductionEventType.AlwaysDisplay) == ProductionEventType.AlwaysDisplay))
            {
                string message = null;

                if (e.EventType == ProductionEventType.Warning)
                {
                    message = e.Dictionary["message"] as string;
                }

                if ((message != null) && (message.Trim().Length == 0))
                {
                    Console.Write(".");
                    _inline = true;
                }
                else
                {
                    if (_inline)
                    {
                        Console.WriteLine();
                    }
                    if (e.EventType == ProductionEventType.Warning)
                    {
                        CodeFluent.Model.Common.ConsoleControl.SetStandardOutputCharacterAttributes(CodeFluent.Model.Common.ConsoleCharacterAttributes.ForegroundGreen | CodeFluent.Model.Common.ConsoleCharacterAttributes.ForegroundRed | CodeFluent.Model.Common.ConsoleCharacterAttributes.ForegroundIntensity);
                    }
                    Console.WriteLine(e.GetDisplayName(sender, false));
                    if (e.EventType == ProductionEventType.Warning)
                    {
                        CodeFluent.Model.Common.ConsoleControl.SetStandardOutputCharacterAttributes(CodeFluent.Model.Common.ConsoleCharacterAttributes.ForegroundWhite);
                    }
                    _inline = false;
                }
            }
            else
            {
                Console.Write(".");
                _inline = true;
            }

        }



        private static void DatabaseProducer_Production(object sender, ProductionEventArgs e)
        {
            DatabaseProducer databaseProducer = sender as DatabaseProducer;
            if (databaseProducer == null)
                return;

            if (_producers.Contains(databaseProducer))
                return;

            databaseProducer.EditorTargetDirectory = Path.Combine(databaseProducer.EditorTargetDirectory, _schema);
            _producers.Add(databaseProducer);
        }

        private static void SqlServerProducer_Production(object sender, ProductionEventArgs e)
        {
            SqlServerProducer sqlServerProducer = sender as SqlServerProducer;
            if (sqlServerProducer == null)
                return;

            if (_producers.Contains(sqlServerProducer))
                return;

            sqlServerProducer.EditorTargetDirectory = Path.Combine(sqlServerProducer.EditorTargetDirectory, _schema);
            _producers.Add(sqlServerProducer);
        }

        private static void Entities_ListChanged(object sender, ListChangedEventArgs e)
        {
            if (e.ListChangedType != ListChangedType.ItemAdded)
                return;

            var entityCollection = sender as EntityCollection;
            if (entityCollection == null || e.NewIndex < 0 || e.NewIndex >= entityCollection.Count)
                return;

            Entity entity = entityCollection[e.NewIndex];
            if (entity == null)
                return;

            Console.WriteLine("Changing schema of entity '{0}' from '{1}' to '{2}'", entity.ClrFullTypeName, entity.Schema, _schema);
            entity.Schema = _schema;
        }

        private static ProductionOptions BuildProductionOptions(Project project)
        {
            ProductionOptions options = _disableNonPersistenceProducers ? new DatabaseProducerOnlyProductionOptions() : new ProductionOptions();
            options.Flags = CommandLineUtilities.GetArgument("opf", ProductionOptionsFlags.None);

            foreach (KeyValuePair<string, bool> kvp in new NameValueCollectionCollection(CommandLineUtilities.GetArgument<string>("ena", null),
                '!', '"', '=', true, true, false, false
                ).ToDictionary<bool>())
            {
                Producer producer = project.GetProducer(kvp.Key);
                if (producer != null)
                {
                    options.Enable(producer, kvp.Value);
                }
                else
                {
                    CodeFluent.Model.SubProducer sp = project.GetSubProducer(kvp.Key);
                    if (sp != null)
                    {
                        options.Enable(sp, kvp.Value);
                    }
                    else
                    {
                        Guid guid = ConvertUtilities.ChangeType(kvp.Key, Guid.Empty);
                        if (guid != Guid.Empty)
                        {
                            Node node = project.GetNode(guid);
                            if (node != null)
                            {
                                options.Enable(node, kvp.Value);
                            }
                        }
                    }
                }
            }
            return options;
        }
    }

    internal class DatabaseProducerOnlyProductionOptions : ProductionOptions
    {
        public override bool IsEnabled(Producer producer)
        {
            var sqlServerProducer = producer.Instance as SqlServerProducer;
            if (sqlServerProducer != null)
            {
                return base.IsEnabled(producer);
            }

            var databaseProducer = producer.Instance as DatabaseProducer;
            if (databaseProducer != null)
            {
                return base.IsEnabled(producer);
            }

            var sqlPivotScriptProducer = producer.Instance as SqlPivotScriptProducer;
            if (sqlPivotScriptProducer != null)
            {
                return base.IsEnabled(producer);
            }

            var categoryAttribute = producer.Instance.GetType().GetCustomAttribute<CategoryAttribute>();
            if (categoryAttribute != null &&
                string.Equals(categoryAttribute.Category, "Persistence Layer Producers", StringComparison.OrdinalIgnoreCase))
            {
                return base.IsEnabled(producer);
            }

            return false;
        }
    }
}
