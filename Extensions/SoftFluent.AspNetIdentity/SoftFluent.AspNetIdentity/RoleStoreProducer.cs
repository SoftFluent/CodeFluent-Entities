using System;
using System.CodeDom;
using System.Collections.Generic;
using System.Linq;
using CodeFluent.Producers.CodeDom;

namespace SoftFluent.AspNetIdentity
{
    public class RoleStoreProducer : AspNetIdentityCodeUnitProducer
    {
        private readonly AspNetIdentityProducer _aspNetIdentityProducer;

        public RoleStoreProducer(AspNetIdentityProducer aspNetIdentityProducer, CodeDomBaseProducer codeDomBaseProducer, IdentityRole identityRole, IdentityRoleClaim identityRoleClaim)
            : base(aspNetIdentityProducer, codeDomBaseProducer)
        {
            if (aspNetIdentityProducer == null) throw new ArgumentNullException("aspNetIdentityProducer");
            if (identityRole == null) throw new ArgumentNullException("identityRole");

            _aspNetIdentityProducer = aspNetIdentityProducer;
            IdentityRoleClaim = identityRoleClaim;
            IdentityRole = identityRole;
        }

        public IdentityRole IdentityRole { get; private set; }

        public IdentityRoleClaim IdentityRoleClaim { get; private set; }

        protected override string DefaultTypeName
        {
            get { return "RoleStore"; }
        }

        public bool CanImplementRoleStore
        {
            get
            {
                return IdentityRole != null && IdentityRole.NameProperty != null;
            }
        }

        public bool CanImplementQueryableRoleStore
        {
            get { return _aspNetIdentityProducer.TargetVersion == AspNetIdentityVersion.Version2 && _aspNetIdentityProducer.MustImplementQueryableRoleStore && CanImplementRoleStore; }
        }
        public bool CanImplementRoleClaimStore
        {
            get { return _aspNetIdentityProducer.TargetVersion == AspNetIdentityVersion.Version3 && IdentityRoleClaim != null && CanImplementRoleStore; }
        }

        public bool CanImplementGenericInterfaces
        {
            get { return _aspNetIdentityProducer.TargetVersion == AspNetIdentityVersion.Version2 && !IdentityRole.IsStringId; }
        }

        public override CodeCompileUnit CreateCodeCompileUnit()
        {
            if (!CanImplementRoleStore)
                return null;

            var unit = new CodeCompileUnit();

            var ns = new CodeNamespace(Namespace);
            var type = new CodeTypeDeclaration(TypeName);
            type.IsPartial = true;
            CodeDomProducer.AddSignature(type);
            Helpers.AddGeneratedCodeAttribute(type, CodeDomProducer.ProductionFlags);
            ns.Types.Add(type);
            unit.Namespaces.Add(ns);

            ImplementIRoleStore(type);
            ImplementIRoleClaimStore(type);
            ImplementIQueryableRoleStore(type);
            ImplementIDisposableInterface(type);
            FinalizeMethods(type);

            return unit;
        }

        private CodeTypeReference GetGenericInterfaceType(string interfaceFullTypeName, bool generic)
        {
            if (generic)
                return GetGenericInterfaceType(interfaceFullTypeName, IdentityRole.KeyTypeName);

            return GetGenericInterfaceType(interfaceFullTypeName, null);
        }

        private CodeTypeReference GetGenericInterfaceType(string interfaceFullTypeName, string genericType)
        {
            CodeTypeReference typeReference;
            if (genericType != null)
            {
                typeReference = CodeDomUtilities.GetGenericType(interfaceFullTypeName, IdentityRole.ClrFullTypeName, genericType);
            }
            else
            {
                typeReference = CodeDomUtilities.GetGenericType(interfaceFullTypeName, IdentityRole.ClrFullTypeName);
            }

            CodeDomUtilities.SetInterface(typeReference);
            return typeReference;
        }

        private void ImplementIRoleStore(CodeTypeDeclaration type)
        {
            if (!CanImplementRoleStore)
                return;

            type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IRoleStore", false));
            if (CanImplementGenericInterfaces)
            {
                type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IRoleStore", true));
            }

            CreateCreateRoleMethod(type);
            CreateUpdateRoleMethod(type);
            CreateDeleteRoleMethod(type);
            CreateFindByIdMethod(type);
            CreateFindByIdGenericMethod(type);
            CreateFindByNameMethod(type);

            if (IdentityProducer.TargetVersion == AspNetIdentityVersion.Version3)
            {
                CreateGetRoleIdMethod(type);
                CreateGetRoleNameMethod(type);
                CreateSetRoleNameMethod(type);
            }
        }

        private void CreateCreateRoleMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "CreateAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityRole.ClrFullTypeName, "role"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IRoleStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IRoleStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("role"));
            method.Statements.Add(new CodeMethodInvokeExpression(new CodeArgumentReferenceExpression("role"), "Save"));
            method.Statements.Add(CreateEmptyTaskResult());

            type.Members.Add(method);
        }

        private void CreateUpdateRoleMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "UpdateAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityRole.ClrFullTypeName, "role"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IRoleStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IRoleStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("role"));
            method.Statements.Add(new CodeMethodInvokeExpression(new CodeArgumentReferenceExpression("role"), "Save"));
            method.Statements.Add(CreateEmptyTaskResult());

            type.Members.Add(method);
        }

        private void CreateDeleteRoleMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "DeleteAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityRole.ClrFullTypeName, "role"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IRoleStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IRoleStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("role"));
            method.Statements.Add(new CodeMethodInvokeExpression(new CodeArgumentReferenceExpression("role"), "Delete"));
            method.Statements.Add(CreateEmptyTaskResult());

            type.Members.Add(method);
        }

        private void CreateFindByIdMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, IdentityRole.ClrFullTypeName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "FindByIdAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(string), "roleId"));
            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IRoleStore", false));

            method.Statements.Add(CreateTaskResult(new CodeMethodInvokeExpression(new CodeTypeReferenceExpression(IdentityRole.ClrFullTypeName), "LoadByEntityKey", new CodeArgumentReferenceExpression("roleId"))));

            type.Members.Add(method);
        }

        private void CreateFindByIdGenericMethod(CodeTypeDeclaration type)
        {
            if (!CanImplementGenericInterfaces)
                return;

            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, IdentityRole.ClrFullTypeName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "FindByIdAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityRole.KeyTypeName, "roleId"));
            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IRoleStore", true));

            if (IdentityRole.LoadByKeyMethod != null)
            {
                method.Statements.Add(
                    CreateTaskResult(CreateMethodInvokeExpression(IdentityRole.Entity, IdentityRole.LoadByKeyMethod,
                        new CodeArgumentReferenceExpression("roleId"))));
            }
            else
            {
                method.Statements.Add(
                    CreateTaskResult(CreateMethodInvokeExpression(IdentityRole.Entity, IdentityRole.LoadByKeyMethodName,
                        CreateStringFormatExpression(new CodeArgumentReferenceExpression("roleId")))));
            }

            type.Members.Add(method);
        }

        private void CreateFindByNameMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, IdentityRole.ClrFullTypeName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "FindByNameAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(string), "roleName"));
            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IRoleStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IRoleStore", true));
            }

            if (IdentityRole.LoadByNameMethod != null)
            {
                method.Statements.Add(
                    CreateTaskResult(CreateMethodInvokeExpression(IdentityRole.Entity, IdentityRole.LoadByNameMethod,
                        new CodeArgumentReferenceExpression("roleName"))));
            }
            else
            {
                method.Statements.Add(CreateThrowInvalidOperationException());
            }

            type.Members.Add(method);
        }

        private void CreateGetRoleIdMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, typeof(string).FullName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "GetRoleIdAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityRole.ClrFullTypeName, "role"));
            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IRoleStore", false));

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("role"));
            method.Statements.Add(CreateTaskResult(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("role"), IdentityRole.StringKeyPropertyName)));

            type.Members.Add(method);
        }

        private void CreateGetRoleNameMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, typeof(string).FullName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "GetRoleNameAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityRole.ClrFullTypeName, "role"));
            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IRoleStore", false));

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("role"));

            method.Statements.Add(CreateTaskResult(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("role"), IdentityRole.NameProperty.Name)));

            type.Members.Add(method);
        }

        private void CreateSetRoleNameMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "SetRoleNameAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityRole.ClrFullTypeName, "role"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(string), "roleName"));
            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IRoleStore", false));

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("role"));

            method.Statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("role"), IdentityRole.NameProperty.Name), new CodeArgumentReferenceExpression("roleName")));
            method.Statements.Add(CreateEmptyTaskResult());

            type.Members.Add(method);
        }

        private void ImplementIRoleClaimStore(CodeTypeDeclaration type)
        {
            if (!CanImplementRoleClaimStore)
                return;

            type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IRoleClaimStore", false));

            CreateAddClaimMethod(type);
            CreateRemoveClaimMethod(type);
            CreateGetClaimsMethod(type);
        }

        private void CreateAddClaimMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "AddClaimAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityRole.ClrFullTypeName, "role"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(ClaimFullTypeName, "claim"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IRoleClaimStore", false));

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("role"));
            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("claim"));

            method.Statements.Add(new CodeVariableDeclarationStatement(new CodeTypeReference(IdentityRoleClaim.ClrFullTypeName), "roleClaim", new CodeObjectCreateExpression(IdentityRoleClaim.ClrFullTypeName)));
            method.Statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("roleClaim"), IdentityRoleClaim.RoleProperty.Name),
                new CodeArgumentReferenceExpression("role")));

            method.Statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("roleClaim"), IdentityRoleClaim.TypeProperty.Name),
                new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("claim"), "Type")));

            method.Statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("roleClaim"), IdentityRoleClaim.ValueProperty.Name),
                new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("claim"), "Value")));

            if (IdentityRoleClaim.IssuerProperty != null)
            {
                method.Statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("roleClaim"), IdentityRoleClaim.IssuerProperty.Name),
                    new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("claim"), "Issuer")));
            }
            if (IdentityRoleClaim.OriginalIssuerProperty != null)
            {
                method.Statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("roleClaim"), IdentityRoleClaim.OriginalIssuerProperty.Name),
                    new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("claim"), "OriginalIssuer")));
            }
            if (IdentityRoleClaim.ValueTypeProperty != null)
            {
                method.Statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("roleClaim"), IdentityRoleClaim.ValueTypeProperty.Name),
                    new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("claim"), "ValueType")));
            }

            method.Statements.Add(new CodeMethodInvokeExpression(new CodeVariableReferenceExpression("roleClaim"), "Save"));
            method.Statements.Add(new CodeMethodInvokeExpression(
                new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("role"), IdentityRole.ClaimsProperty.Name), "Add", new CodeVariableReferenceExpression("roleClaim")));

            method.Statements.Add(CreateEmptyTaskResult());
            type.Members.Add(method);
        }

        private void CreateRemoveClaimMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "RemoveClaimAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityRole.ClrFullTypeName, "role"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(ClaimFullTypeName, "claim"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IRoleClaimStore", false));

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("role"));
            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("claim"));

            /*
            List<RoleClaim> toDelete = new List<RoleClaim>();
            foreach (var roleClaim in role.Claims)
            {
                if (roleClaim.Equals(claim))
                {
                    toDelete.Add(roleClaim);
                }
            }*/
            method.Statements.Add(new CodeVariableDeclarationStatement(CodeDomUtilities.GetGenericType(typeof(IList<>), IdentityRoleClaim.ClrFullTypeName), "toDelete", new CodeObjectCreateExpression(CodeDomUtilities.GetGenericType(typeof(List<>), IdentityRoleClaim.ClrFullTypeName))));

            var roleClaimsEnumerator = CodeDomUtilities.GetUniqueVariable(method, CodeDomUtilities.GetGenericType(typeof(IEnumerator<>), IdentityRoleClaim.ClrFullTypeName), "enumerator");
            roleClaimsEnumerator.InitExpression = new CodeMethodInvokeExpression(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("role"), IdentityRole.ClaimsProperty.Name), "GetEnumerator");

            var roleClaimsIteration = new CodeIterationStatement();
            roleClaimsIteration.InitStatement = roleClaimsEnumerator;
            roleClaimsIteration.TestExpression = new CodeMethodInvokeExpression(new CodeVariableReferenceExpression(roleClaimsEnumerator.Name), "MoveNext");
            roleClaimsIteration.IncrementStatement = new CodeSnippetStatement("");
            method.Statements.Add(roleClaimsIteration);

            roleClaimsIteration.Statements.Add(new CodeVariableDeclarationStatement(IdentityRoleClaim.ClrFullTypeName, "roleClaim", new CodePropertyReferenceExpression(new CodeVariableReferenceExpression(roleClaimsEnumerator.Name), "Current")));
            CodeConditionStatement claimsEqual = new CodeConditionStatement();
            roleClaimsIteration.Statements.Add(claimsEqual);
            claimsEqual.Condition = CreateStringEqualsExpression(StringComparison.OrdinalIgnoreCase,
                    new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("roleClaim"), IdentityRoleClaim.TypeProperty.Name),
                    new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("claim"), "Type"));

            if (IdentityRoleClaim.ValueProperty.GetAttributeValue("isComparer", Constants.NamespaceUri, true))
            {
                claimsEqual.Condition = new CodeBinaryOperatorExpression(claimsEqual.Condition, CodeBinaryOperatorType.BooleanAnd,
                    CreateStringEqualsExpression(StringComparison.OrdinalIgnoreCase,
                        new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("roleClaim"), IdentityRoleClaim.TypeProperty.Name),
                        new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("claim"), "Type")));
            }

            if (IdentityRoleClaim.ValueTypeProperty != null && IdentityRoleClaim.ValueTypeProperty.GetAttributeValue("isComparer", Constants.NamespaceUri, false))
            {
                claimsEqual.Condition = new CodeBinaryOperatorExpression(claimsEqual.Condition, CodeBinaryOperatorType.BooleanAnd,
                    CreateStringEqualsExpression(StringComparison.OrdinalIgnoreCase,
                        new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("roleClaim"), IdentityRoleClaim.ValueTypeProperty.Name),
                        new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("claim"), "ValueType")));
            }

            if (IdentityRoleClaim.IssuerProperty != null && IdentityRoleClaim.IssuerProperty.GetAttributeValue("isComparer", Constants.NamespaceUri, false))
            {
                claimsEqual.Condition = new CodeBinaryOperatorExpression(claimsEqual.Condition, CodeBinaryOperatorType.BooleanAnd,
                    CreateStringEqualsExpression(StringComparison.OrdinalIgnoreCase,
                        new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("roleClaim"), IdentityRoleClaim.IssuerProperty.Name),
                        new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("claim"), "Issuer")));
            }

            if (IdentityRoleClaim.OriginalIssuerProperty != null && IdentityRoleClaim.OriginalIssuerProperty.GetAttributeValue("isComparer", Constants.NamespaceUri, false))
            {
                claimsEqual.Condition = new CodeBinaryOperatorExpression(claimsEqual.Condition, CodeBinaryOperatorType.BooleanAnd,
                    CreateStringEqualsExpression(StringComparison.OrdinalIgnoreCase,
                        new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("roleClaim"), IdentityRoleClaim.OriginalIssuerProperty.Name),
                        new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("claim"), "OriginalIssuer")));
            }

            claimsEqual.TrueStatements.Add(new CodeMethodInvokeExpression(new CodeVariableReferenceExpression("toDelete"), "Add", new CodeVariableReferenceExpression("roleClaim")));

            /*
            foreach (var roleClaim in toDelete)
            {
                roleClaim.Delete();
                role.Claims.Remove(roleClaim);
            }
            */

            var toDeleteEnumerator = CodeDomUtilities.GetUniqueVariable(method, CodeDomUtilities.GetGenericType(typeof(IEnumerator<>), IdentityRoleClaim.ClrFullTypeName), "enumerator");
            toDeleteEnumerator.InitExpression = new CodeMethodInvokeExpression(new CodeVariableReferenceExpression("toDelete"), "GetEnumerator");

            var toDeleteIteration = new CodeIterationStatement();
            toDeleteIteration.InitStatement = toDeleteEnumerator;
            toDeleteIteration.TestExpression = new CodeMethodInvokeExpression(new CodeVariableReferenceExpression(toDeleteEnumerator.Name), "MoveNext");
            toDeleteIteration.IncrementStatement = new CodeSnippetStatement("");
            method.Statements.Add(toDeleteIteration);

            toDeleteIteration.Statements.Add(new CodeVariableDeclarationStatement(IdentityRoleClaim.ClrFullTypeName, "roleClaim", new CodePropertyReferenceExpression(new CodeVariableReferenceExpression(toDeleteEnumerator.Name), "Current")));
            toDeleteIteration.Statements.Add(new CodeMethodInvokeExpression(new CodeVariableReferenceExpression("roleClaim"), "Delete"));
            toDeleteIteration.Statements.Add(new CodeMethodInvokeExpression(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("role"), IdentityRole.ClaimsProperty.Name), "Remove", new CodeVariableReferenceExpression("roleClaim")));

            method.Statements.Add(CreateEmptyTaskResult());
            type.Members.Add(method);
        }

        private void CreateGetClaimsMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            CodeTypeReference returnType = CreateTaskTypeReference();
            returnType.TypeArguments.Add(CodeDomUtilities.GetGenericType(typeof(IList<>), ClaimFullTypeName));
            method.ReturnType = returnType;
            method.Attributes = MemberAttributes.Public;
            method.Name = "GetClaimsAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityRole.ClrFullTypeName, "role"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IRoleClaimStore", false));

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("role"));

            method.Statements.Add(new CodeVariableDeclarationStatement(CodeDomUtilities.GetGenericType(typeof(IList<>), ClaimFullTypeName), "result", new CodeObjectCreateExpression(CodeDomUtilities.GetGenericType(typeof(List<>), ClaimFullTypeName))));

            var enumerator = new CodeVariableDeclarationStatement(CodeDomUtilities.GetGenericType(typeof(IEnumerator<>), IdentityRoleClaim.ClrFullTypeName), "enumerator");
            enumerator.InitExpression = new CodeMethodInvokeExpression(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("role"), IdentityRole.ClaimsProperty.Name), "GetEnumerator");

            var iteration = new CodeIterationStatement();
            iteration.InitStatement = enumerator;
            iteration.TestExpression = new CodeMethodInvokeExpression(new CodeVariableReferenceExpression("enumerator"), "MoveNext");
            iteration.IncrementStatement = new CodeSnippetStatement("");

            iteration.Statements.Add(new CodeVariableDeclarationStatement(IdentityRoleClaim.ClrFullTypeName, "roleClaim", new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("enumerator"), "Current")));
            var createExpression = new CodeObjectCreateExpression(ClaimFullTypeName);

            if (IdentityRoleClaim.OriginalIssuerProperty != null)
            {
                createExpression.Parameters.Insert(0, new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("roleClaim"), IdentityRoleClaim.OriginalIssuerProperty.Name));
            }

            if (IdentityRoleClaim.IssuerProperty != null)
            {
                createExpression.Parameters.Insert(0, new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("roleClaim"), IdentityRoleClaim.IssuerProperty.Name));
            }
            else if (createExpression.Parameters.Count > 0)
            {
                createExpression.Parameters.Insert(0, createExpression.Parameters[0]); // OriginalIssuer
            }

            if (IdentityRoleClaim.ValueTypeProperty != null)
            {
                createExpression.Parameters.Insert(0, new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("roleClaim"), IdentityRoleClaim.ValueTypeProperty.Name));
            }
            else if (createExpression.Parameters.Count > 0)
            {
                createExpression.Parameters.Insert(0, new CodeFieldReferenceExpression(new CodeTypeReferenceExpression(ClaimValueTypesFullTypeName), "String"));
            }

            createExpression.Parameters.Insert(0, new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("roleClaim"), IdentityRoleClaim.ValueProperty.Name));
            createExpression.Parameters.Insert(0, new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("roleClaim"), IdentityRoleClaim.TypeProperty.Name));

            iteration.Statements.Add(
                new CodeMethodInvokeExpression(
                    new CodeVariableReferenceExpression("result"), "Add",
                    createExpression));
            method.Statements.Add(iteration);

            method.Statements.Add(CreateTaskResult(new CodeVariableReferenceExpression("result")));
            type.Members.Add(method);
        }

        private void ImplementIQueryableRoleStore(CodeTypeDeclaration type)
        {
            if (!CanImplementQueryableRoleStore)
                return;

            type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IQueryableRoleStore", false));
            if (CanImplementGenericInterfaces)
            {
                type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IQueryableRoleStore", true));
            }

            CreateRolesProperty(type);
        }

        private void CreateRolesProperty(CodeTypeDeclaration type)
        {
            CodeMemberProperty property = new CodeMemberProperty();
            property.Type = CodeDomUtilities.GetGenericType(typeof(IQueryable), IdentityRole.ClrFullTypeName);
            property.Attributes = MemberAttributes.Public;
            property.Name = "Roles";
            property.HasSet = false;
            property.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IQueryableRoleStore", false));
            property.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IQueryableRoleStore", true));

            if (IdentityRole.LoadAllMethod != null)
            {
                property.GetStatements.Add(
                    new CodeMethodReturnStatement(
                        new CodeMethodInvokeExpression(new CodeTypeReferenceExpression(typeof(Queryable)), "AsQueryable",
                            CreateMethodInvokeExpression(IdentityRole.Entity, IdentityRole.LoadAllMethod))));
            }
            else
            {
                property.GetStatements.Add(CreateThrowInvalidOperationException());
            }

            type.Members.Add(property);
        }

    }
}