using System.Collections;
using System.ComponentModel;
using System.Linq;
using System.Xml;
using CodeFluent.Model;
using CodeFluent.Model.Code;
using CodeFluent.Model.Persistence;
using System.IO;
using System;

namespace CodeFluent.Aspects.Encrypt
{
    public class EncryptAspect : IProjectTemplate
    {
        public static readonly XmlDocument Descriptor;
        public const string Namespace = "http://www.softfluent.com/aspects/samples/encrypt";

        private const string PassPhraseToken = "PassPhrase";

        static EncryptAspect()
        {
            Descriptor = new XmlDocument();
            Descriptor.LoadXml(
@"<cf:project xmlns:cf='http://www.softfluent.com/codefluent/2005/1' defaultNamespace='EncryptAspect'>
    <cf:pattern name='Encrypt Aspect' namespaceUri='" + Namespace + @"' preferredPrefix='ea' step='Start'>
        <cf:message class='_doc'> CodeFluent Sample Encrypt Aspect Version 1.0.0.1 - 2013/09/20 This aspect modifies Save and Load* procedures in order to call Sql Server ENCRYPTBYPASSPHRASE / DECRYPTBYPASSPHRASE functions.</cf:message>
        <cf:descriptor name='encrypt'
            typeName='boolean'
            category='Encrypt Aspect'
            targets='Property'
            defaultValue='false'
            displayName='Encrypt the property'
            description='Determines if the property must be encrypted when saving to the database.' />
    </cf:pattern>
</cf:project>");
        }

        public Project Project { get; set; }

        public XmlDocument Run(IDictionary context)
        {
            if (context == null || !context.Contains("Project"))
            {
                // we are probably called for meta data inspection, so we send back the descriptor xml
                return Descriptor;
            }

            // the dictionary contains at least these two entries
            Project = (Project)context["Project"];

            // hook on new base entities, and hook on new properties
            Project.Entities.ListChanged += (sender, e) =>
            {
                if (e.ListChangedType != ListChangedType.ItemAdded)
                    return;

                var entity = Project.Entities[e.NewIndex];
                if (!entity.IsPersistent)
                    return;

                if (!entity.IsProjectDerived)
                {
                    entity.Properties.ListChanged += OnPropertiesListChanged;
                }
            };

            Project.StepChanging += (sender, e) =>
            {
                if (e.Step != ImportStep.Categories)
                    return;

                foreach (var procedure in Project.Database.Procedures.Where(procedure => procedure.Parameters[PassPhraseToken] != null))
                {
                    UpdateProcedure(procedure);
                }
            };

            // we have no specific Xml to send back, but aspect description
            return Descriptor;
        }

        private void OnPropertiesListChanged(object sender, ListChangedEventArgs e)
        {
            if (e.ListChangedType != ListChangedType.ItemAdded)
                return;

            var property = ((PropertyCollection)sender)[e.NewIndex];

            if (!MustEncrypt(property))
                return;

            property.DbType = System.Data.DbType.Binary;
            property.MaxLength = 8000;

            if (property.Entity.AmbientParameters[PassPhraseToken] != null)
                return;

            // create one pass phrase ambient parameter for each entity that has at least one crypt property
            var passPhraseParameter = new MethodParameter
            {
                Name = PassPhraseToken,
                ClrFullTypeName = "string",
                Nullable = CodeFluent.Model.Code.Nullable.False,
                Options = MethodParameterOptions.Ambient |
                            MethodParameterOptions.Inherits |
                            MethodParameterOptions.UsedForLoad |
                            MethodParameterOptions.UsedForSearch |
                            MethodParameterOptions.UsedForCount |
                            MethodParameterOptions.UsedForRaw |
                            MethodParameterOptions.UsedForSave,
                ModelName = "[" + Project.DefaultNamespace + ".PassPhrase.GetPassPhrase()]",
                AmbientExpression = "(1=1)"
            };

            property.Entity.AmbientParameters.Add(passPhraseParameter);
        }

        private static void UpdateProcedure(Procedure procedure)
        {
            procedure.Parameters[PassPhraseToken].DefaultValue = null; // passphrase must be provided

            if (procedure.ProcedureType == ProcedureType.SaveEntity)
            {
                procedure.Body.Visit<ProcedureStatement>(s =>
                {
                    var statement = s as ProcedureSetStatement;
                    if (statement == null || statement.LeftExpression == null || statement.RightExpression == null || !MustEncrypt(statement.LeftExpression.RefColumn))
                        return;

                    string parameterName = statement.RightExpression.Parameter.Name;
                    statement.RightExpression.Literal = ProcedureExpressionStatement.CreateLiteral(string.Format("ENCRYPTBYPASSPHRASE(@{0}, @{1})", PassPhraseToken, parameterName));
                    statement.RightExpression.Parameter = null;

                    // Column is of type varbinary but parameter must be of type string
                    var parameter = procedure.Parameters[parameterName];
                    if (parameter != null)
                    {
                        parameter.DbType = System.Data.DbType.String;
                    }
                });
                return;
            }

            procedure.Body.Visit<ProcedureStatement>(s =>
            {
                var statement = s as ProcedureSetStatement;
                if (statement == null || statement.LeftExpression == null || !MustEncrypt(statement.LeftExpression.RefColumn))
                    return;

                statement.As = new ProcedureExpressionStatement(statement, ProcedureExpressionStatement.CreateLiteral(statement.LeftExpression.RefColumn.Column.Name));
                statement.LeftExpression.Literal = ProcedureExpressionStatement.CreateLiteral(string.Format("CONVERT(nvarchar, DECRYPTBYPASSPHRASE(@{0}, {1}))", PassPhraseToken, statement.LeftExpression.RefColumn.Column.Name));
                statement.LeftExpression.RefColumn = null;
            });
        }



        private static bool MustEncrypt(TableRefColumn refColumn)
        {
            return refColumn != null && MustEncrypt(refColumn.Column);
        }

        private static bool MustEncrypt(Column column)
        {
            return column != null && MustEncrypt(column.Property);
        }

        private static bool MustEncrypt(Property property)
        {
            return property != null && property.IsPersistent && property.GetAttributeValue("encrypt", Namespace, false);
        }
    }
}
