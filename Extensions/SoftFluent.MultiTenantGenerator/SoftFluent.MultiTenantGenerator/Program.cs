using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using CodeFluent.Model;
using CodeFluent.Producers.Database;
using CodeFluent.Producers.SqlServer;
using CodeFluent.Runtime.Utilities;

namespace SoftFluent.MultiTenantGenerator
{
class Program
{
    private static string _schema;
    private static string _projectPath;
    private static bool _changeTargetDirectory;

    static void Main()
    {
        _projectPath = CommandLineUtilities.GetArgument("path", (string)null) ?? CommandLineUtilities.GetArgument(0, (string)null);
        _schema = ConvertUtilities.Nullify(CommandLineUtilities.GetArgument("schema", (string)null) ?? CommandLineUtilities.GetArgument(1, (string)null), true);
        _changeTargetDirectory = CommandLineUtilities.GetArgument("changeTargetDirectory", true);

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
        project.Produce();
    }

    private static readonly HashSet<IProducer> _producers = new HashSet<IProducer>();

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
}
}
