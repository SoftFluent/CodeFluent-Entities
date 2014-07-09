using CodeFluent.Model;
using CodeFluent.Model.Persistence;
using CodeFluent.Producers.SqlServer;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;

namespace SoftFluent.SqlServerInMemory.Aspects
{
    public class SqlServerInMemoryAspect : IProjectTemplate
    {
        public static readonly XmlDocument Descriptor;
        public const string Namespace = "http://www.softfluent.com/aspects/samples/sql-server-in-memory";
        public Project Project { get; set; }

        static SqlServerInMemoryAspect()
        {
            Descriptor = new XmlDocument();
            Descriptor.LoadXml(
@"<cf:project xmlns:cf='http://www.softfluent.com/codefluent/2005/1' defaultNamespace='SqlServerInMemoryAspect'>
    <cf:pattern name='Sql Server In Memory Aspect' namespaceUri='" + Namespace + @"' preferredPrefix='sim' step='Start'>
       <cf:message class='_doc'> CodeFluent Sample Sql Server In Memory Aspect Version 1.0.0.0 - 2014/07/08 This aspect modifies the model to make the generated table compatible with Sql Server 2014 In Memory.</cf:message>

       <cf:descriptor name='defaultEnabled'
            typeName='boolean'
            category='Sql Server In Memory Aspect'
            targets='Project'
            defaultValue='false'
            displayName='Default is enabled' />

        <cf:descriptor name='enabled'
            typeName='boolean'
            category='Sql Server In Memory Aspect'
            targets='Entity'
            defaultValue='false'
            displayName='Is enabled' />
    </cf:pattern>
  </cf:project>");
        }

        public XmlDocument Run(IDictionary context)
        {
            if (context == null || !context.Contains("Project"))
                return Descriptor;

            Project = (Project)context["Project"];
            Project.StepChanging += Project_StepChanging;
            return Descriptor;
        }

        void Project_StepChanging(object sender, StepChangeEventArgs e)
        {
            switch (e.Step)
            {
                case ImportStep.Categories:
                    foreach (var entity in Project.Entities)
                    {
                        if (!IsEnabled(entity))
                            continue;

                        Table table = entity.Table;
                        RemoveForeignKey(table);
                        UpdateProcedure(table, entity.SaveProcedure);
                        UpdateDefaultValues(table);
                    }
                    break;

                case ImportStep.Tables:
                    foreach (var entity in Project.Entities)
                    {
                        if (!IsEnabled(entity))
                            continue;

                        RemoveRowVersion(entity);
                    }
                    break;
                case ImportStep.End:
                    foreach (var entity in Project.Entities)
                    {
                        if (!IsEnabled(entity))
                            continue;

                        var producer = Project.Producers.GetProducerInstance<SqlServerProducer>();
                        if (producer != null)
                        {
                            producer.Production += (psender, pe) =>
                            {
                                if (producer.MustUseLocalTransactions)
                                {
                                    producer.MustUseLocalTransactions = false;
                                }
                            };

                        }

                        break;
                    }

                    break;
            }
        }

        private void RemoveRowVersion(Entity entity)
        {
            entity.ConcurrencyMode = ConcurrencyMode.None;
        }

        private void RemoveForeignKey(Table table)
        {
            for (int i = 0; i < table.Constraints.Count; i++)
            {
                Constraint constraint = table.Constraints[i];
                if (constraint.ConstraintType != ConstraintType.ForeignKey)
                    continue;

                table.Constraints.RemoveAt(i);
                i--;
            }
        }

        private void UpdateDefaultValues(Table table)
        {
            foreach (var column in table.Columns)
            {
                column.DefaultValue = null;
            }
        }

        private void UpdateProcedure(Table table, Procedure procedure)
        {
            procedure.Body.Visit<ProcedureStatement>(statement =>
            {
                ProcedureInsertStatement insertStatement = statement as ProcedureInsertStatement;
                if (insertStatement != null)
                {
                    foreach (var column in table.Columns)
                    {
                        if (column.DefaultValue == null)
                            continue;

                        if (IsInSet(insertStatement.Set, column))
                            continue;

                        insertStatement.Set.Add(CreateSetStatement(insertStatement, column));
                        column.DefaultValue = null;
                    }
                }

                ProcedureUpdateStatement updateStatement = statement as ProcedureUpdateStatement;
                if (updateStatement != null)
                {
                    foreach (var column in table.Columns)
                    {
                        if (column == table.TrackCreationTimeColumn || column.DefaultValue == null)
                            continue;

                        if (IsInSet(updateStatement.Set, column))
                            continue;

                        updateStatement.Set.Add(CreateSetStatement(updateStatement, column));
                        column.DefaultValue = null;
                    }
                }
            });
        }

        private bool IsInSet(ProcedureStatementCollection statements, Column column)
        {
            foreach (var statement in statements)
            {
                var setStatement = statement as ProcedureSetStatement;
                if (setStatement == null)
                    continue;

                if (setStatement.RefColumn != null)
                {
                    if (setStatement.RefColumn.Column == column)
                        return true;
                }

                if (setStatement.LeftExpression != null)
                {
                    if (setStatement.LeftExpression.RefColumn != null)
                    {
                        if (setStatement.LeftExpression.RefColumn.Column == column)
                            return true;
                    }
                }
            }

            return false;
        }

        private ProcedureSetStatement CreateSetStatement(ProcedureStatement statement, Column column)
        {
            ProcedureExpressionStatement rightExpression = new ProcedureExpressionStatement(statement, column.DefaultValue);
            rightExpression.Function = ProcedureFunctionType.Snippet; // Value will be written as is

            var setStatement = new ProcedureSetStatement(statement, new TableRefColumn(column));
            setStatement.RightExpression = rightExpression;

            return setStatement;
        }

        private bool IsEnabled(Entity entity)
        {
            if (entity == null)
                return false;

            if (entity.SaveProcedure == null)
                return false;

            if (entity.Table == null)
                return false;

            bool defaultValue = entity.Project.GetAttributeValue("defaultEnabled", Namespace, false);
            return entity.GetAttributeValue("enabled", Namespace, defaultValue);
        }

        private bool HasTrackingTimeColumns(Table table)
        {
            return ((table.TrackCreationTimeColumn == null || table.TrackCreationTimeColumn.DefaultValue == null)
                && (table.TrackLastWriteTimeColumn == null || table.TrackLastWriteTimeColumn.DefaultValue == null));
        }

    }
}
