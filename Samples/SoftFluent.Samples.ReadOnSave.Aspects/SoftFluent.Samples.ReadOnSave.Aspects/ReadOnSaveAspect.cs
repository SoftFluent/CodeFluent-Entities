using CodeFluent.Model;
using CodeFluent.Model.Persistence;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Xml;

namespace SoftFluent.Samples.ReadOnSave
{
    public class ReadOnSaveAspect : IProjectTemplate
    {
        public static readonly XmlDocument Descriptor;
        public const string Namespace = "http://www.softfluent.com/aspects/samples/read-on-save";
        public Project Project { get; set; }

        static ReadOnSaveAspect()
        {
            Descriptor = new XmlDocument();
            Descriptor.LoadXml(
@"<cf:project xmlns:cf='http://www.softfluent.com/codefluent/2005/1' defaultNamespace='ReadOnSaveAspect'>
    <cf:pattern name='Read On Save Aspect' namespaceUri='" + Namespace + @"' preferredPrefix='ca' step='Categories'>
       <cf:message class='_doc'> CodeFluent Sample ReadOnSave Aspect Version 1.0.0.0 - 2014/06/18 This aspect modifies Save procedures in order to select ReadOnSave columns after inserting or updating.</cf:message>
       <cf:descriptor name='expression'
            typeName='string'
            category='Read on Save Aspect'
            targets='Property'
            defaultValue=''
            displayName='Expression' />
    </cf:pattern>
  </cf:project>");
        }

        public XmlDocument Run(IDictionary context)
        {
            if (context == null || !context.Contains("Project"))
            {
                // we are probably called for meta data inspection, so we send back the descriptor xml
                return Descriptor;
            }

            // the dictionary contains at least these two entries
            Project = (Project)context["Project"];

            // Edit save procedures
            foreach (var procedure in Project.Database.Procedures.Where(procedure => procedure.ProcedureType == CodeFluent.Model.Persistence.ProcedureType.SaveEntity))
            {
                UpdateProcedure(procedure);
            }


            // we have no specific Xml to send back, but aspect description
            return Descriptor;
        }

        private string GetSelectExpression(Property property)
        {
            return property.GetAttributeValue("expression", Namespace, (string)null) ?? property.PersistenceName;
        }

        private void UpdateProcedure(CodeFluent.Model.Persistence.Procedure procedure)
        {
            if (procedure.Table == null || procedure.Table.Entity == null)
                return;

            // Find columns to add to SELECT
            // RowVersion and Identity columns are already part of the SELECT
            var columns = procedure.Table.Entity.Properties
                .Where(property => property.MustReadOnSave && !property.IsPersistenceIdentity)
                .SelectMany(property => property.Columns)
                .Where(column => column != null && !column.IsRowVersion)
                .ToList();

            var properties = procedure.Table.Entity.Properties
                .Where(property => property.MustReadOnSave && !property.IsPersistenceIdentity && property.Columns.Count == 0)
                .ToList();

            if (columns.Count == 0 && properties.Count == 0)
                return;

            // Visit the body of the procedure
            procedure.Body.Visit<ProcedureStatement>(statement =>
            {
                // We need to find a block statement (a list of statements) that looks like
                // INSERT OR UPDATE statement
                // statement (generally IfStatement)
                // SELECT ...
                
                /*
                 * 
                -- Statement 1 : ProcedureBlockStatement which contains UPDATE & if(@error)
                UPDATE [Login] SET
                 [Login].[Login_ProviderName] = @Login_ProviderName,
                 [Login].[_trackLastWriteTime] = GETDATE()
                    WHERE (([Login].[Login_Id] = @Login_Id) AND ([Login].[_rowVersion] = @_rowVersion))
                
                SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
                IF(@error != 0)
                BEGIN
                    IF @tran = 1 ROLLBACK TRANSACTION
                    RETURN
                END
                
                -- Statement 2 : ProcedureIfStatement
                IF(@rowcount = 0)
                BEGIN
                    IF @tran = 1 ROLLBACK TRANSACTION
                    RAISERROR (50001, 16, 1, 'Login_Save')
                    RETURN
                END
                
                -- Statement 3 : ProcedureSelectStatement
                SELECT DISTINCT [Login].[_rowVersion] 
                    FROM [Login]
                    WHERE ([Login].[Login_Id] = @Login_Id)
                
                */
                

                var blockStatement = statement as ProcedureBlockStatement;
                if (blockStatement == null)
                    return;

                bool insertOrUpdate = false;

                foreach (var s in blockStatement.Statements)
                {
                    if (IsInsertOrUpdateStatement(s)) 
                    {
                        insertOrUpdate = true;
                    }

                    var selectStatement = s as ProcedureSelectStatement;
                    if (insertOrUpdate && selectStatement != null) // SELECT statement after INSERT or UPDATE statement
                    {
                        if (IsReadIdentityStatement(selectStatement)) // SELECT DISTINCT @Id = SCOPE_IDENTITY() 
                            continue;

                        foreach (var column in columns)
                        {
                            var setStatment = new ProcedureSetStatement(selectStatement, new TableRefColumn(column));
                            selectStatement.Set.Add(setStatment);
                        }

                        foreach (var property in properties) // not persistent : select expression AS 'persistent name'
                        {
                            ProcedureExpressionStatement literalExpression = new ProcedureExpressionStatement(selectStatement, ProcedureExpressionStatement.CreateLiteral(GetSelectExpression(property)));
                            var setStatment = new ProcedureSetStatement(selectStatement, literalExpression, (ProcedureExpressionStatement)null, new ProcedureExpressionStatement(selectStatement, property.PersistenceName));
                            selectStatement.Set.Add(setStatment);
                        }
                    }
                }
            });
        }

        private bool IsReadIdentityStatement(ProcedureSelectStatement selectStatement)
        {
            if (selectStatement == null)
                return false;

            foreach (ProcedureStatement statement in selectStatement.Set)
            {
                var setStatement = statement as ProcedureSetStatement;
                if (setStatement == null)
                    continue;

                if (setStatement.RightExpression == null)
                    continue;

                if (setStatement.RightExpression.Function == ProcedureFunctionType.Identity)
                    return true;
            }

            return false;
        }

        private bool IsInsertOrUpdateStatement(ProcedureStatement statement)
        {
            if (statement == null)
                return false;

            var blockStatement = statement as ProcedureBlockStatement;
            if (blockStatement != null)
            {
                if (blockStatement.Statements.Count == 0)
                    return false;

                return blockStatement.Statements[0] is ProcedureInsertStatement || blockStatement.Statements[0] is ProcedureUpdateStatement;
            }

            return statement is ProcedureInsertStatement || statement is ProcedureUpdateStatement;
        }
    }
}
