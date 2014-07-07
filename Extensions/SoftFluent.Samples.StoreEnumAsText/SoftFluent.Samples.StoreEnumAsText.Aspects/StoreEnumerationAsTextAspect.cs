using CodeFluent.Model;
using CodeFluent.Model.Code;
using CodeFluent.Model.Persistence;
using CodeFluent.Producers.CodeDom;
using System;
using System.CodeDom;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;

namespace SoftFluent.Samples.StoreEnumAsText.Aspects
{
    public class StoreEnumerationAsTextAspect : IProjectTemplate
    {
        public static readonly XmlDocument Descriptor;
        public const string Namespace = "http://www.softfluent.com/aspects/samples/StoreEnumAsText";
        public Project Project { get; set; }

        static StoreEnumerationAsTextAspect()
        {
            Descriptor = new XmlDocument();
            Descriptor.LoadXml(
@"<cf:project xmlns:cf='http://www.softfluent.com/codefluent/2005/1' defaultNamespace='StoreEnumerationAsTextAspect'>
    <cf:pattern name='Store Enumeration As String Aspect' namespaceUri='" + Namespace + @"' preferredPrefix='enat' step='Methods'>
       <cf:message class='_doc'> CodeFluent Sample StoreEnumerationAsText Aspect Version 1.0.0.0 - 2014/06/24 
           This aspect allows to store enum as string
       </cf:message>

       <cf:descriptor name='storeAsText'
            typeName='boolean'
            category='Store Enumeration As Text Aspect'
            targets='Property'
            defaultValue='false'
            displayName='Store Enumeration As Text' />

       <cf:descriptor name='defaultStoreAsText'
            typeName='boolean'
            category='Store Enumeration As Text Aspect'
            targets='Project, Enumeration'
            defaultValue='false'
            displayName='Store Enumeration As Text' />

       <cf:descriptor name='columnSize'
            typeName='int'
            category='Store Enumeration As Text Aspect'
            targets='Property'
            defaultValue='-1'
            displayName='Column Size' />

       <cf:descriptor name='defaultColumnSize'
            typeName='int'
            category='Store Enumeration As Text Aspect'
            targets='Enumeration'
            defaultValue='-1'
            displayName='Default Column Size' />

    </cf:pattern>
  </cf:project>");
        }

        public XmlDocument Run(IDictionary context)
        {
            if (context == null || !context.Contains("Project"))
            {
                return Descriptor;
            }

            Project = (Project)context["Project"];

            foreach (var table in Project.Database.Tables)
            {
                foreach (var column in table.Columns)
                {
                    if (column.Property == null || !MustStoreAsText(column))
                        continue;

                    var property = column.Property;
                    column.DbType = System.Data.DbType.String;
                    column.Size = GetColumnSize(property);


                    // Change BaseSave method
                    // Example: persistence.AddParameterAsText("@Customer_Gender", this.Gender, SoftFluent.Samples.Gender.Male);
                    property.SetAttributeValue(Constants.ModelProducerNamespacePrefix, "addParameterMethodName", Constants.ModelProducerNamespaceUri, "AddParameterAsText");

                    // Change ReadRecord method
                    // Example: this._gender = CodeFluentPersistence.GetReaderValue(reader, "Customer_Gender", Gender.Male);
                    var readerExpression = string.Format("CodeFluentPersistence.GetReaderValue(reader, \"{1}\", {2})", property.ClrFullTypeName, property.Column.Name, property.DefaultValue);
                    column.Property.SetAttributeValue(Constants.ModelProducerNamespacePrefix, "readValueExpression", Constants.ModelProducerNamespaceUri, readerExpression);
                }
            }

            return Descriptor;
        }

        private int ComputeMaxLength(Enumeration enumeration)
        {
            if (enumeration == null || enumeration.Values.Count == 0)
                return Project.DefaultMaxLength;

            if (enumeration.IsFlags)
            {
                const int separatorLength = 2; // separator ", "
                int maxLength = -separatorLength;
                foreach (var value in enumeration.Values)
                {
                    maxLength += value.Name.Length + separatorLength;
                }

                return maxLength;
            }
            else
            {
                int maxLength = -1;
                foreach (var value in enumeration.Values)
                {
                    if (value.Name.Length > maxLength)
                    {
                        maxLength = value.Name.Length;
                    }
                }

                return maxLength;
            }
        }

        private int GetColumnSize(Enumeration enumeration)
        {
            if (enumeration == null)
                return Project.DefaultMaxLength;

            return enumeration.GetAttributeValue("defaultColumnSize", Namespace, -1);
        }

        private int GetColumnSize(Property property)
        {
            if (property == null)
                return Project.DefaultMaxLength;

            int defaultValue = GetColumnSize(property.ProjectEnumeration);
            var columnSize = property.GetAttributeValue("columnSize", Namespace, defaultValue);
            return columnSize <= 0 ? ComputeMaxLength(property.ProjectEnumeration) : columnSize;
        }

        private bool MustStoreAsText(Project project)
        {
            if (project == null)
                return false;

            return project.GetAttributeValue("defaultStoreAsText", Namespace, false);
        }

        private bool MustStoreAsText(Enumeration enumeration)
        {
            if (enumeration == null)
                return false;

            bool defaultValue = MustStoreAsText(enumeration.Project);
            return enumeration.GetAttributeValue("defaultStoreAsText", Namespace, defaultValue);
        }

        private bool MustStoreAsText(Property property)
        {
            if (!property.IsEnumeration)
                return false;

            bool defaultValue = MustStoreAsText(property.ProjectEnumeration);
            return property.GetAttributeValue("storeAsText", Namespace, defaultValue);
        }

        private bool MustStoreAsText(Column column)
        {
            if (column.Property == null)
                return false;

            return MustStoreAsText(column.Property);
        }
    }
}
