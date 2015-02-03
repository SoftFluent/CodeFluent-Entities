using System.Data;
using CodeFluent.Model;
using CodeFluent.Model.Code;
using CodeFluent.Model.Persistence;
using System;
using System.Collections;
using System.Linq;
using System.Xml;
using CodeFluent.Runtime.Utilities;
using Nullable = CodeFluent.Model.Code.Nullable;
using System.Diagnostics;

namespace SoftFluent.Samples.ExtendedSearch.Aspects
{
    public class ExtendedSearchAspect : IProjectTemplate
    {
        public static readonly XmlDocument Descriptor;
        public const string NamespaceUri = "http://www.softfluent.com/samples/aspects/extendedsearch/";
        public const string PreferredPrefix = "exse";
        private const string DefaultParameterNameFormat = "{0}FilterFunction";
        private const FilterFunctions DefaultFilterFunctions = FilterFunctions.AllExceptFullText;
        public Project Project { get; private set; }
        public Enumeration FilterFunctionsEnumeration { get; private set; }

        static ExtendedSearchAspect()
        {
            var values = ConvertUtilities.EnumEnumerateValues<FilterFunctions>();
            string filterFunctionEditorTypeName = "enum:";
            foreach (var value in values)
            {
                filterFunctionEditorTypeName += string.Format("{0}={1},", value, (int)value);
            }

            filterFunctionEditorTypeName = filterFunctionEditorTypeName.TrimEnd(';');
            string multiValueFilterFunctionEditorTypeName = "mv" + filterFunctionEditorTypeName;

            Descriptor = new XmlDocument();
            Descriptor.LoadXml(
                @"<cf:project xmlns:cf='http://www.softfluent.com/codefluent/2005/1' defaultNamespace='ExtendedSearchAspect'>
                    <cf:pattern name='Extended Search Aspect' namespaceUri='" + NamespaceUri + @"' preferredPrefix='" + PreferredPrefix + @"' step='Start'>
                        <cf:message class='_doc'>
                        SoftFluent Samples - Extended Search Aspect
                        This aspect is used to customize Search methods. It modifies methods (BOM and SQL) to support dynamic filter functions (Equals, StartsWith, EndsWith, Contains, FreeText, ...)
                        </cf:message>

                        <cf:descriptor name='defaultEnabled' 
                                targets='Project, Entity' 
                                defaultValue='false' 
                                displayName='Default is Enabled' 
                                typeName='boolean' 
                                category='Extended Search Aspect' />
                        
                        <cf:descriptor name='enabled' 
                                targets='Method, Parameter' 
                                defaultValue='false' 
                                displayName='Is Enabled' 
                                typeName='boolean' 
                                category='Extended Search Aspect' />

                        <cf:descriptor name='defaultParameterNameFormat' 
                                targets='Project, Entity, Method' 
                                defaultValue='" + DefaultParameterNameFormat + @"' 
                                displayName='Default Parameter Name Format' 
                                typeName='string' 
                                category='Extended Search Aspect' />
                        
                        <cf:descriptor name='parameterNameFormat' 
                                targets='Parameter' 
                                defaultValue='" + DefaultParameterNameFormat + @"' 
                                displayName='Parameter Name Format' 
                                typeName='string' 
                                category='Extended Search Aspect' />

                        <cf:descriptor name='defaultFilterFunctions' 
                                targets='Project, Entity, Method' 
                                defaultValue='" + DefaultFilterFunctions.ToString() + @"' 
                                displayName='Default Filter Functions' 
                                editorTypeName='" + multiValueFilterFunctionEditorTypeName + @"' 
                                category='Extended Search Aspect' />

                        <cf:descriptor name='filterFunctions' 
                                targets='Parameter' 
                                defaultValue='" + DefaultFilterFunctions.ToString() + @"' 
                                displayName='Filter Functions' 
                                editorTypeName='" + multiValueFilterFunctionEditorTypeName + @"' 
                                category='Extended Search Aspect' />

                        <cf:descriptor name='isFilterFunctionsEnumeration' 
                                targets='Enumeration' 
                                defaultValue='false' 
                                displayName='Is Filter Functions Enumeration' 
                                typeName='boolean' 
                                category='Extended Search Aspect' />

                        <cf:descriptor name='filterFunction' 
                                targets='EnumerationValue' 
                                defaultValue='None' 
                                displayName='Filter Function' 
                                editorTypeName='" + filterFunctionEditorTypeName + @"' 
                                category='Extended Search Aspect' />

                        <cf:descriptor name='createMultiValuedEnumeration' 
                                targets='Project' 
                                defaultValue='true' 
                                displayName='Create multi-valued enumeration' 
                                typeName='boolean' 
                                category='Extended Search Aspect' />
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
            Project.StepChanging += Project_StepChanging;

            return Descriptor;
        }

        private void Project_StepChanging(object sender, StepChangeEventArgs e)
        {
            switch (e.Step)
            {
                //case ImportStep.Start:
                //    break;
                //case ImportStep.Hints:
                //    break;
                //case ImportStep.UserTypes:
                //    break;
                //case ImportStep.ProjectTypes:
                //    break;
                //case ImportStep.Tables:
                //    break;
                //case ImportStep.Methods:
                //    break;
                case ImportStep.PersistenceViews:
                    FilterFunctionsEnumeration = FindOrCreateFilterFunctionsEnumeration();
                    UpdateMethods();
                    break;
                //case ImportStep.Procedures:
                //    break;
                case ImportStep.Categories:
                    UpdateProcedures();
                    break;
                //case ImportStep.Messages:
                //    break;
                //case ImportStep.UI:
                //    break;
                //case ImportStep.End:
                //    break;
                //case ImportStep.ProjectTypesInference:
                //    break;
            }
        }

        private void UpdateMethods()
        {
            // Add arguments Search method
            //    SEARCH(FirstName, LastName) 
            // => SEARCH(FirstName, FirstNameFilterFunction, LastName, LastNameFilterFunction)
            foreach (var entity in Project.Entities)
            {
                foreach (var method in entity.Methods)
                {
                    if (!IsEnabled(method))
                        continue;

                    int newParameterCount = 0;
                    foreach (var parameter in method.Parameters.Clone())
                    {
                        if (!IsEnabled(parameter))
                            continue;

                        newParameterCount += 1;
                        MethodParameter newParameter = new MethodParameter();
                        newParameter.Name = GetMethodParameterName(parameter);
                        newParameter.ClrFullTypeName = FilterFunctionsEnumeration.ClrFullTypeName;
                        newParameter.DbType = FilterFunctionsEnumeration.EnumDbType;
                        newParameter.MustUsePersistenceDefaultValue = false;
                        newParameter.Nullable = Nullable.False;
                        newParameter.ModelNullable = Nullable.False;
                        method.Parameters.Insert(parameter.Index + newParameterCount, newParameter);

                        newParameter.Data[NamespaceUri + ":parameter"] = parameter; // Save the original parameter to retrieve it when updating the procedure
                    }
                }
            }
        }

        private void UpdateProcedures()
        {
            foreach (var procedure in Project.Database.Procedures)
            {
                ProcedureSelectStatement selectStatement = null;
                foreach (var enumParameter in procedure.Parameters)
                {
                    // Find the original parameter
                    var methodParameter = enumParameter.MethodParameter;
                    if (methodParameter == null)
                        continue;

                    var originalMethodParameter = methodParameter.GetData(NamespaceUri + ":parameter", (MethodParameter)null);
                    if (originalMethodParameter == null)
                        continue;

                    var valueParameter = procedure.Parameters.FirstOrDefault(_ => _.MethodParameter == originalMethodParameter);
                    if (valueParameter == null || valueParameter.Column == null)
                        continue;

                    if (selectStatement == null)
                    {
                        // Get the select statement of the procedure
                        // The procedure should contains only one Select statement
                        selectStatement = procedure.Body.Statements.OfType<ProcedureSelectStatement>().FirstOrDefault();
                        if (selectStatement == null)
                            return;
                    }

                    ProcedureExpressionStatement whereStatement = null;
                    foreach (var enumValue in FilterFunctionsEnumeration.Values)
                    {
                        FilterFunctions op = GetFilterFunction(enumValue);
                        if (!IsSupported(op, procedure, valueParameter))
                            continue;

                        ProcedureExpressionStatement testEnumValueStatement = CreateEnumerationEqualsStatement(selectStatement, enumParameter, enumValue);
                        ProcedureExpressionStatement testValueStatement = CreateParameterTestStatement(selectStatement, valueParameter, op);
                        if (testValueStatement == null)
                            continue;

                        var paramWhereStatement = new ProcedureExpressionStatement(
                            selectStatement,
                            ProcedureOperationType.And,
                            testEnumValueStatement,
                            testValueStatement);

                        if (whereStatement == null)
                        {
                            whereStatement = paramWhereStatement;
                        }
                        else
                        {
                            whereStatement = new ProcedureExpressionStatement(selectStatement, ProcedureOperationType.Or, whereStatement, paramWhereStatement);
                        }
                    }

                    // Declare the statement as a search expression
                    // Search expression is used by SEARCH method to identify dynamic parts of the body
                    whereStatement.Visit<ProcedureStatement>(statement =>
                    {
                        ProcedureExpressionStatement s = statement as ProcedureExpressionStatement;
                        if (s != null)
                        {
                            procedure.MarkSearchExpression(s, valueParameter);
                            if (!s.IsLiteral)
                            {
                                s.SearchExpressionParameter = valueParameter;
                            }
                        }
                    });

                    selectStatement.AddExpressionToWhere(whereStatement, ProcedureOperationType.And);

                }
            }
        }

        private FilterFunctions GetFilterFunction(EnumerationValue enumValue)
        {
            var op = enumValue.GetAttributeValue("filterFunction", NamespaceUri, FilterFunctions.None);
            if (op == FilterFunctions.None)
            {
                op = ConvertUtilities.ChangeType(enumValue.Name, FilterFunctions.None);
            }

            return op;
        }

        private ProcedureExpressionStatement CreateParameterTestStatement(ProcedureStatement parent, Parameter parameter, FilterFunctions op)
        {
            ProcedureExpressionStatement result = null;
            TableRefColumn refColumn = new TableRefColumn(parameter.Column);
            switch (op)
            {
                case FilterFunctions.None:
                    result = new ProcedureExpressionStatement(parent, ProcedureOperationType.Equals, new ProcedureExpressionStatement(parent, 1), new ProcedureExpressionStatement(parent, 1));
                    break;

                case FilterFunctions.Equals:
                    result = new ProcedureExpressionStatement(parent, ProcedureOperationType.Equals, refColumn, parameter);
                    break;

                case FilterFunctions.NotEquals:
                    result = new ProcedureExpressionStatement(parent, ProcedureOperationType.NotEquals, refColumn, parameter);
                    break;

                case FilterFunctions.IsLessThan:
                    result = new ProcedureExpressionStatement(parent, ProcedureOperationType.IsLesserThan, refColumn, parameter);
                    break;

                case FilterFunctions.IsLessThanOrEqualTo:
                    result = new ProcedureExpressionStatement(parent, ProcedureOperationType.IsLesserThanOrEqualTo, refColumn, parameter);
                    break;

                case FilterFunctions.IsGreaterThan:
                    result = new ProcedureExpressionStatement(parent, ProcedureOperationType.IsGreaterThan, refColumn, parameter);
                    break;

                case FilterFunctions.IsGreaterThanOrEqualTo:
                    result = new ProcedureExpressionStatement(parent, ProcedureOperationType.IsGreaterThanOrEqualTo, refColumn, parameter);
                    break;

                case FilterFunctions.FullTextContains:
                case FilterFunctions.NotFullTextContains:
                    result = new ProcedureExpressionStatement(parent, ProcedureOperationType.Contains, refColumn, parameter);
                    break;

                case FilterFunctions.FreeText:
                case FilterFunctions.NotFreeText:
                    result = new ProcedureExpressionStatement(parent, ProcedureOperationType.FreeText, refColumn, parameter);
                    break;

                case FilterFunctions.StartsWith:
                    result = new ProcedureExpressionStatement(
                                      parent,
                                      ProcedureOperationType.Like,
                                      new ProcedureExpressionStatement(parent, refColumn),
                                      CreateConcatStatement(parent, parameter, "%"));
                    break;

                case FilterFunctions.EndsWith:
                    result = new ProcedureExpressionStatement(
                                      parent,
                                      ProcedureOperationType.Like,
                                      new ProcedureExpressionStatement(parent, refColumn),
                                      CreateConcatStatement(parent, "%", parameter));
                    break;

                case FilterFunctions.Contains:
                case FilterFunctions.NotContains:
                    result = new ProcedureExpressionStatement(
                                      parent,
                                      ProcedureOperationType.Like,
                                      new ProcedureExpressionStatement(parent, refColumn),
                                      CreateConcatStatement(parent, "%", parameter, "%"));
                    break;

            }

            // Negate statement if needed
            switch (op)
            {
                case FilterFunctions.NotContains:
                case FilterFunctions.NotFullTextContains:
                case FilterFunctions.NotFreeText:
                    result = new ProcedureExpressionStatement(parent, ProcedureOperationType.Not, result, null);
                    break;
            }

            return result;
        }

        private ProcedureExpressionStatement CreateConcatStatement(ProcedureStatement parent, string prefix, Parameter parameter)
        {
            return new ProcedureExpressionStatement(
                parent,
                ProcedureOperationType.Add,
                new ProcedureExpressionStatement(parent, prefix),
                new ProcedureExpressionStatement(parent, parameter));
        }

        private ProcedureExpressionStatement CreateConcatStatement(ProcedureStatement parent, Parameter parameter, string suffix)
        {
            return new ProcedureExpressionStatement(
                parent,
                ProcedureOperationType.Add,
                new ProcedureExpressionStatement(parent, parameter),
                new ProcedureExpressionStatement(parent, suffix));
        }

        private ProcedureExpressionStatement CreateConcatStatement(ProcedureStatement parent, string prefix, Parameter parameter, string suffix)
        {
            return new ProcedureExpressionStatement(
                parent,
                ProcedureOperationType.Add,
                CreateConcatStatement(parent, "%", parameter),
                new ProcedureExpressionStatement(parent, suffix));
        }

        private ProcedureExpressionStatement CreateEnumerationEqualsStatement(ProcedureStatement parent, Parameter enumParameter, EnumerationValue enumValue)
        {
            bool isZero = ConvertUtilities.ChangeType<int>(enumValue) == 0;
            if (!isZero && FilterFunctionsEnumeration.IsFlags)
            {
                // Sample: (@FilterFunctions & FilterFunctions.Equals) = FilterFunctions.Equals
                return new ProcedureExpressionStatement(
                        parent,
                        ProcedureOperationType.Equals,
                        new ProcedureExpressionStatement(parent, ProcedureOperationType.BitwiseAnd, new ProcedureExpressionStatement(parent, enumParameter), new ProcedureExpressionStatement(parent, enumValue.TypedValue)),
                        new ProcedureExpressionStatement(parent, enumValue.TypedValue));

            }
            else
            {
                // Sample: @FilterFunctions = FilterFunctions.Equals
                return new ProcedureExpressionStatement(
                        parent,
                        ProcedureOperationType.Equals,
                        new ProcedureExpressionStatement(parent, enumParameter),
                        new ProcedureExpressionStatement(parent, enumValue.TypedValue));
            }
        }

        private bool IsFullTextCompatible(DbType type)
        {
            // char, varchar, nchar, nvarchar, text, ntext, image, xml, varbinary, or varbinary(max).
            DbType[] types =
            {
                DbType.AnsiString,
                DbType.AnsiStringFixedLength,
                DbType.String,
                DbType.StringFixedLength,
                DbType.Xml,
                DbType.Binary,
                DbType.Object,
            };

            return types.Contains(type);
        }

        private bool IsLikeCompatible(DbType type)
        {
            DbType[] types =
            {
                DbType.AnsiString,
                DbType.AnsiStringFixedLength,
                DbType.String,
                DbType.StringFixedLength,
            };

            return types.Contains(type);
        }

        private bool IsSupported(FilterFunctions op, Procedure procedure, Parameter parameter)
        {
            if (op == FilterFunctions.None)
                return true;

            var fullTextFunctions = new[] { 
                FilterFunctions.FullTextContains, 
                FilterFunctions.NotFullTextContains,
                FilterFunctions.FreeText,
                FilterFunctions.NotFreeText
            };

            var likeFunctions = new[] { 
                FilterFunctions.StartsWith, 
                FilterFunctions.EndsWith,
                FilterFunctions.Contains,
                FilterFunctions.NotContains
            };

            var parameterFunctions = GetFilterFunctions(parameter);
            if ((parameterFunctions & op) != op)
                return false;

            if (fullTextFunctions.Contains(op))
            {
                if (!IsFullTextCompatible(parameter.DbType))
                    return false;
            }

            if (likeFunctions.Contains(op))
            {
                if (!IsLikeCompatible(parameter.DbType))
                    return false;
            }

            return true;
        }

        private Enumeration FindOrCreateFilterFunctionsEnumeration()
        {
            foreach (var enumeration in Project.Enumerations)
            {
                if (enumeration.GetAttributeValue("isFilterFunctionsEnumeration", NamespaceUri, false))
                {
                    return enumeration;
                }
            }

            Enumeration e = Project.Enumerations.FirstOrDefault(_ => string.Equals(_.Name, "FilterFunction", StringComparison.OrdinalIgnoreCase) || string.Equals(_.Name, "FilterFunctions", StringComparison.OrdinalIgnoreCase));
            if (e != null)
                return e;

            e = new Enumeration();
            e.Name = typeof(FilterFunctions).Name;
            e.Namespace = Project.DefaultNamespace;
            e.IsFlags = Project.GetAttributeValue("createMultiValuedEnumeration", NamespaceUri, true);
            e.SetAttributeValue(PreferredPrefix, "isFilterFunctionsEnumeration", NamespaceUri, true);
            Project.Enumerations.Add(e);

            foreach (FilterFunctions value in ConvertUtilities.EnumEnumerateValues<FilterFunctions>())
            {
                EnumerationValue enumerationValue = new EnumerationValue();
                enumerationValue.Name = value.ToString();
                enumerationValue.SetAttributeValue(PreferredPrefix, "filterFunction", NamespaceUri, value);
                e.Values.Add(enumerationValue);
            }

            return e;
        }

        private string GetMethodParameterName(MethodParameter parameter)
        {
            string name = parameter.GetAttributeValue("parameterNameFormat", NamespaceUri, (string)null);
            if (!string.IsNullOrEmpty(name))
                return name;

            string format = GetMethodParameterNameFormat(parameter.Method);
            return string.Format(format, parameter.Name);
        }

        private string GetMethodParameterNameFormat(Method method)
        {
            if (method == null)
                return DefaultParameterNameFormat;

            var defaultValue = GetMethodParameterNameFormat(method.Entity);
            return method.GetAttributeValue("defaultParameterNameFormat", NamespaceUri, defaultValue);

        }

        private string GetMethodParameterNameFormat(Entity entity)
        {
            if (entity == null)
                return DefaultParameterNameFormat;

            var defaultValue = GetMethodParameterNameFormat(entity.Project);
            return entity.GetAttributeValue("defaultParameterNameFormat", NamespaceUri, defaultValue);
        }

        private string GetMethodParameterNameFormat(Project project)
        {
            if (project == null)
                return DefaultParameterNameFormat;

            return project.GetAttributeValue("defaultParameterNameFormat", NamespaceUri, DefaultParameterNameFormat);
        }

        private bool IsEnabled(Project project)
        {
            if (project == null)
                return false;

            return project.GetAttributeValue("defaultEnabled", NamespaceUri, false);
        }

        private bool IsEnabled(Entity entity)
        {
            if (entity == null)
                return false;

            bool defaultValue = IsEnabled(entity.Project);
            return entity.GetAttributeValue("defaultEnabled", NamespaceUri, defaultValue);
        }

        private bool IsEnabled(Method method)
        {
            if (method == null)
                return false;

            bool defaultValue = false;
            if (method.MethodType == MethodType.Search)
            {
                defaultValue = IsEnabled(method.Entity);
            }

            if (!method.GetAttributeValue("enabled", NamespaceUri, defaultValue))
                return false;

            return method.Parameters.Any(IsEnabled);
        }

        private bool IsEnabled(MethodParameter parameter)
        {
            if (parameter.IsPagingParameter)
                return false;

            return parameter.GetAttributeValue("enabled", NamespaceUri, true);
        }

        private FilterFunctions GetDefaultFilterFunctions(Project project)
        {
            if (project == null)
                return DefaultFilterFunctions;

            return project.GetAttributeValue("defaultFilterFunctions", NamespaceUri, DefaultFilterFunctions);
        }

        private FilterFunctions GetDefaultFilterFunctions(Entity entity)
        {
            if (entity == null)
                return DefaultFilterFunctions;

            FilterFunctions defaultValue = GetDefaultFilterFunctions(entity.Project);
            return entity.GetAttributeValue("defaultFilterFunctions", NamespaceUri, defaultValue);
        }

        private FilterFunctions GetDefaultFilterFunctions(Method method)
        {
            if (method == null)
                return DefaultFilterFunctions;

            FilterFunctions defaultValue = GetDefaultFilterFunctions(method.Entity);
            return method.GetAttributeValue("defaultFilterFunctions", NamespaceUri, defaultValue);
        }

        private FilterFunctions GetDefaultFilterFunctions(Procedure procedure)
        {
            if (procedure == null)
                return DefaultFilterFunctions;

            return GetDefaultFilterFunctions(procedure.Method);
        }

        private FilterFunctions GetFilterFunctions(MethodParameter parameter)
        {
            if (parameter == null)
                return DefaultFilterFunctions;

            FilterFunctions defaultValue = GetDefaultFilterFunctions(parameter.Method);
            return parameter.GetAttributeValue("filterFunctions", NamespaceUri, defaultValue);
        }

        private FilterFunctions GetFilterFunctions(Parameter parameter)
        {
            if (parameter == null)
                return DefaultFilterFunctions;

            return GetFilterFunctions(parameter.MethodParameter);
        }
    }
}
