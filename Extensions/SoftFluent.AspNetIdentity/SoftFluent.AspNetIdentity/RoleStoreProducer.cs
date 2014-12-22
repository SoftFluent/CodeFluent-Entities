using System;
using System.CodeDom;
using System.Linq;
using System.Threading.Tasks;
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
        }

        private void CreateCreateRoleMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = new CodeTypeReference(typeof(Task));
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
            method.ReturnType = new CodeTypeReference(typeof(Task));
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
            method.ReturnType = new CodeTypeReference(typeof(Task));
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
            method.ReturnType = CodeDomUtilities.GetGenericType(typeof(Task), IdentityRole.ClrFullTypeName);
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
            method.ReturnType = CodeDomUtilities.GetGenericType(typeof(Task), IdentityRole.ClrFullTypeName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "FindByIdAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityRole.KeyTypeName, "roleId"));
            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IRoleStore", true));

            if (IdentityRole.LoadByKeyMethod != null)
            {
                method.Statements.Add(
                    CreateTaskResult(CreateMethodInvokeExpression(IdentityRole.LoadByKeyMethod,
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
            method.ReturnType = CodeDomUtilities.GetGenericType(typeof(Task), IdentityRole.ClrFullTypeName);
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
                    CreateTaskResult(CreateMethodInvokeExpression(IdentityRole.LoadByNameMethod,
                        new CodeArgumentReferenceExpression("roleName"))));
            }
            else
            {
                method.Statements.Add(CreateThrowInvalidOperationException());
            }

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
                            CreateMethodInvokeExpression(IdentityRole.LoadAllMethod))));
            }
            else
            {
                property.GetStatements.Add(CreateThrowInvalidOperationException());
            }

            type.Members.Add(property);
        }

    }
}