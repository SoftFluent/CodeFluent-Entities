using System.Runtime.Serialization;

namespace SoftFluent.Json.NET.Aspects
{
    using System;
    using System.CodeDom;
    using System.Collections;
    using System.Xml;
    using System.Xml.Serialization;
    using CodeFluent.Model;
    using CodeFluent.Producers.CodeDom;

    namespace SoftFluent.Samples.Aspects
    {
        public class JsonNetSerializableAspect : IProjectTemplate
        {
            private const ImportStep Step = ImportStep.End;
            private static readonly XmlDocument _descriptor;
            private CodeDomProducer _codeDomProducer;
            public const string NamespaceUri = "http://www.softfluent.com/samples/aspects/json-net-serializable";
            public Project Project { get; set; }

            static JsonNetSerializableAspect()
            {
                _descriptor = new XmlDocument();
                _descriptor.LoadXml(
                    @"
<cf:project xmlns:cf='http://www.softfluent.com/codefluent/2005/1' defaultNamespace='JsonNetSerializable'>
  <cf:pattern name='JsonNetSerializableAspect' namespaceUri='" + NamespaceUri + @"' preferredPrefix='_jns' step='" + Step + @"'>
    <cf:message class='_doc'>
      Json Net Serializable Aspect
      Version 1.0.0.0 - 2015/02/23
    </cf:message>
    <cf:descriptor name=""enabled"" targets=""Entity, Property"" defaultValue=""true"" displayName=""Create JsonAttribute"" typeName=""boolean"" description="""" category=""Json.NET Serializable"" />
    <cf:descriptor name=""enabledForNonModelProperties"" targets=""Entity"" defaultValue=""true"" displayName=""Create JsonAttribute for non-model properties"" typeName=""boolean"" description="""" category=""Json.NET Serializable"" />
    <cf:descriptor name=""optMode"" targets=""Entity"" defaultValue=""OptIn"" displayName=""Member Serialization"" typeName=""enum:OptIn,OptOut,Fields"" description=""Specifies the member serialization options for the JsonSerializer"" category=""Json.NET Serializable"" />
    <cf:descriptor name=""includeInSerialization"" targets=""Property"" defaultValue=""true"" displayName=""Include in Serialization"" typeName=""boolean"" description="""" category=""Json.NET Serializable"" />
  </cf:pattern>
</cf:project>
");
            }

            public XmlDocument Run(IDictionary context)
            {
                if (context == null || !context.Contains("Project"))
                {
                    // we are probably called for meta data inspection, so we send back the descriptor xml
                    return _descriptor;
                }

                Project = (Project)context["Project"];

                _codeDomProducer = Project.Producers.GetProducerInstance<CodeDomProducer>();
                if (_codeDomProducer != null)
                {
                    _codeDomProducer.CodeDomProduction += CodeDomProducer_CodeDomProduction;
                }

                return _descriptor;
            }

            private void CodeDomProducer_CodeDomProduction(object sender, CodeDomProductionEventArgs e)
            {
                if (e.EventType == CodeDomProductionEventType.UnitsProducing)
                {
                    if (e.Argument == null)
                        return;

                    foreach (var entity in Project.Entities)
                    {
                        if (!entity.GetAttributeValue("enabled", NamespaceUri, true))
                            continue;

                        CodeTypeDeclaration typeDeclaration = _codeDomProducer.GetType(entity);
                        if (typeDeclaration == null)
                            continue;

                        // Class
                        var jsonObjectAttribute = new CodeAttributeDeclaration("Newtonsoft.Json.JsonObjectAttribute");
                        string optMode = entity.GetAttributeValue("optMode", NamespaceUri, "OptIn");
                        if (optMode != null)
                        {
                            var memberSerialization = new CodeFieldReferenceExpression(new CodeTypeReferenceExpression("Newtonsoft.Json.MemberSerialization"), optMode);
                            jsonObjectAttribute.Arguments.Add(new CodeAttributeArgument("MemberSerialization", memberSerialization));
                        }
                        CodeDomUtilities.EnsureAttribute(typeDeclaration, jsonObjectAttribute, true);

                        // Properties
                        foreach (CodeTypeMember member in typeDeclaration.Members)
                        {
                            PropertyDefinition propertyDefinition = null;

                            CodeMemberProperty memberProperty = member as CodeMemberProperty;
                            if (memberProperty != null)
                            {
                                propertyDefinition = UserData.GetPropertyDefinition(memberProperty);
                            }

                            Property property = null;
                            if (propertyDefinition != null && propertyDefinition.Property != null)
                            {
                                property = propertyDefinition.Property;
                                if (!property.GetAttributeValue("enabled", NamespaceUri, true))
                                    continue;
                            }
                            else
                            {
                                if (!entity.GetAttributeValue("enabledForNonModelProperties", NamespaceUri, true))
                                    continue;
                            }

                            bool? serialized = null;
                            if (property != null)
                            {
                                serialized = property.GetAttributeValue("includeInSerialization", NamespaceUri, (bool?)null);
                            }

                            if (serialized == null)
                            {
                                //[System.NonSerializedAttribute()] => false
                                //[System.Xml.Serialization.XmlIgnoreAttribute()] => false
                                //[System.Runtime.Serialization.DataMemberAttribute()] => true

                                if (CodeDomUtilities.GetAttribute(member, typeof(NonSerializedAttribute)) != null)
                                {
                                    serialized = false;
                                }
                                else if (CodeDomUtilities.GetAttribute(member, typeof(XmlIgnoreAttribute)) != null)
                                {
                                    serialized = false;
                                }
                                else if (CodeDomUtilities.GetAttribute(member, typeof(DataMemberAttribute)) != null)
                                {
                                    serialized = true;
                                }
                                else if (CodeDomUtilities.GetAttribute(member, typeof(XmlAttribute)) != null)
                                {
                                    serialized = true;
                                }
                                else if (CodeDomUtilities.GetAttribute(member, typeof(XmlElementAttribute)) != null)
                                {
                                    serialized = true;
                                }
                                else if (property != null)
                                {
                                    serialized = property.IsIncludedInSerialization;
                                }
                            }

                            // [JsonIgnore] or [JsonProperty]
                            if (serialized != null)
                            {
                                var jsonPropertyAttribute = new CodeAttributeDeclaration();
                                jsonPropertyAttribute.Name = serialized == true ? "Newtonsoft.Json.JsonPropertyAttribute" : "Newtonsoft.Json.JsonIgnoreAttribute";
                                CodeDomUtilities.EnsureAttribute(member, jsonPropertyAttribute, true);
                            }

                        }
                    }
                }
            }
        }
    }

}
