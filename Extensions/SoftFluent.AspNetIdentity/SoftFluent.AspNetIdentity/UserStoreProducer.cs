using System;
using System.CodeDom;
using System.Collections.Generic;
using System.Linq;
using CodeFluent.Model;
using CodeFluent.Producers.CodeDom;

namespace SoftFluent.AspNetIdentity
{
    public class UserStoreProducer : AspNetIdentityCodeUnitProducer
    {
        private readonly ProjectMessages _projectMessages;
        private readonly IdentityUser _identityUser;
        private readonly IdentityRole _identityRole;
        private readonly IdentityUserLogin _identityUserLogin;
        private readonly IdentityUserClaim _identityUserClaim;

        public UserStoreProducer(
            AspNetIdentityProducer aspNetIdentityProducer,
            CodeDomBaseProducer codeDomBaseProducer,
            ProjectMessages projectMessages,
            IdentityUser identityUser,
            IdentityRole identityRole,
            IdentityUserLogin identityUserLogin,
            IdentityUserClaim identityUserClaim)
            : base(aspNetIdentityProducer, codeDomBaseProducer)
        {
            _projectMessages = projectMessages;
            _identityUser = identityUser;
            _identityRole = identityRole;
            _identityUserLogin = identityUserLogin;
            _identityUserClaim = identityUserClaim;
        }

        public ProjectMessages ProjectMessages
        {
            get { return _projectMessages; }
        }

        public IdentityUserLogin IdentityUserLogin
        {
            get { return _identityUserLogin; }
        }

        public IdentityUserClaim IdentityUserClaim
        {
            get { return _identityUserClaim; }
        }

        public IdentityRole IdentityRole
        {
            get { return _identityRole; }
        }

        public IdentityUser IdentityUser
        {
            get { return _identityUser; }
        }

        protected override string DefaultTypeName
        {
            get { return "UserStore"; }
        }

        public bool CanImplementUserStore
        {
            get
            {
                return IdentityUser != null && IdentityUser.UserNameProperty != null;
            }
        }

        public bool CanImplementPasswordStore
        {
            get
            {
                return IdentityUser != null && IdentityUser.PasswordProperty != null;
            }
        }

        public bool CanImplementSecurityStampStore
        {
            get
            {
                return IdentityUser != null && IdentityUser.SecurityStampProperty != null;
            }
        }

        public bool CanImplementLockoutStore
        {
            get
            {
                return IdentityProducer.TargetVersion == AspNetIdentityVersion.Version2 && IdentityUser != null && IdentityUser.LockoutEndDateProperty != null;
            }
        }

        public bool CanImplementEmailStore
        {
            get
            {
                return IdentityProducer.TargetVersion == AspNetIdentityVersion.Version2 && IdentityUser != null && IdentityUser.EmailProperty != null;
            }
        }

        public bool CanImplementUserPhoneNumberStore
        {
            get
            {
                return IdentityProducer.TargetVersion == AspNetIdentityVersion.Version2 && IdentityUser != null && IdentityUser.PhoneNumberProperty != null;
            }
        }

        public bool CanImplementTwoFactorStore
        {
            get
            {
                return IdentityProducer.TargetVersion == AspNetIdentityVersion.Version2 && IdentityUser != null && IdentityUser.TwoFactorEnabledProperty != null;
            }
        }

        public bool CanImplementUserRoleStore
        {
            get
            {
                return IdentityUser != null && IdentityUser.RolesProperty != null && IdentityRole != null;
            }
        }

        public bool CanImplementUserLoginStore
        {
            get
            {
                return IdentityUser != null && IdentityUser.LoginsProperty != null && IdentityUserLogin != null && IdentityUserLogin.ProviderKeyProperty != null;
            }
        }

        public bool CanImplementUserClaimsStore
        {
            get
            {
                return IdentityUserClaim != null && IdentityUser != null && IdentityUser.ClaimsProperty != null;
            }
        }

        public bool CanImplementQueryableUserStore
        {
            get { return IdentityProducer.TargetVersion == AspNetIdentityVersion.Version2 && IdentityProducer.MustImplementQueryableUserStore && CanImplementUserStore; }
        }

        public bool CanImplementGenericInterfaces
        {
            get { return !IdentityUser.IsStringId && IdentityProducer.TargetVersion == AspNetIdentityVersion.Version2; }
        }

        private CodeTypeReference GetGenericInterfaceType(string interfaceFullTypeName, bool generic)
        {
            if (generic)
                return GetGenericInterfaceType(interfaceFullTypeName, IdentityUser.KeyTypeName);

            return GetGenericInterfaceType(interfaceFullTypeName, (string)null);
        }

        private CodeTypeReference GetGenericInterfaceType(string interfaceFullTypeName, Type genericType)
        {
            return GetGenericInterfaceType(interfaceFullTypeName, genericType.FullName);
        }

        private CodeTypeReference GetGenericInterfaceType(string interfaceFullTypeName, string genericType)
        {
            CodeTypeReference typeReference;
            if (genericType != null)
            {
                typeReference = CodeDomUtilities.GetGenericType(interfaceFullTypeName, IdentityUser.ClrFullTypeName, genericType);
            }
            else
            {
                typeReference = CodeDomUtilities.GetGenericType(interfaceFullTypeName, IdentityUser.ClrFullTypeName);
            }

            CodeDomUtilities.SetInterface(typeReference);
            return typeReference;
        }

        public override CodeCompileUnit CreateCodeCompileUnit()
        {
            if (!CanImplementUserStore)
                return null;

            var unit = new CodeCompileUnit();

            var ns = new CodeNamespace(Namespace);
            var type = new CodeTypeDeclaration(TypeName);
            type.IsPartial = true;
            CodeDomProducer.AddSignature(type);
            Helpers.AddGeneratedCodeAttribute(type, CodeDomProducer.ProductionFlags);
            ns.Types.Add(type);
            unit.Namespaces.Add(ns);

            ImplementUserStore(type);
            ImplementUserPasswordStore(type);
            ImplementUserSecurityStampStore(type);
            ImplementUserLockoutStore(type);
            ImplementUserPhoneNumberStore(type);
            ImplementUserTwoFactorStore(type);
            ImplementUserEmailStore(type);
            ImplementUserRoleStore(type);
            ImplementUserLoginStore(type);
            ImplementUserClaimStore(type);
            ImplementIQueryableUserStore(type);
            ImplementIDisposableInterface(type);

            FinalizeMethods(type);
            return unit;
        }

        private void ImplementUserStore(CodeTypeDeclaration type)
        {
            if (!CanImplementUserStore)
                return;

            type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserStore", false));
            if (CanImplementGenericInterfaces)
            {
                type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserStore", true));
            }

            CreateCreateUserMethod(type);
            CreateUpdateUserMethod(type);
            CreateDeleteUserMethod(type);
            CreateFindByIdMethod(type);
            CreateFindByIdGenericMethod(type);
            CreateFindByNameMethod(type);

            if (IdentityProducer.TargetVersion == AspNetIdentityVersion.Version3)
            {
                CreateGetUserIdMethod(type);
                CreateGetUserNameMethod(type);
                CreateSetUserNameMethod(type);
                CreateGetNormalizedUserNameMethod(type);
                CreateSetNormalizedUserNameMethod(type);
            }
        }

        private void CreateCreateUserMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "CreateAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));

            if (IdentityUser.CreationDateProperty != null)
            {
                method.Statements.Add(new CodeAssignStatement(
                        new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.CreationDateProperty.Name),
                        new CodePropertyReferenceExpression(new CodeTypeReferenceExpression(typeof(DateTime)), "UtcNow")));
            }

            method.Statements.Add(new CodeMethodInvokeExpression(new CodeArgumentReferenceExpression("user"), "Save"));
            method.Statements.Add(CreateEmptyTaskResult());

            type.Members.Add(method);
        }

        private void CreateUpdateUserMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "UpdateAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));

            if (IdentityUser.LastProfileUpdateDateProperty != null)
            {
                method.Statements.Add(new CodeAssignStatement(
                        new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.LastProfileUpdateDateProperty.Name),
                        new CodePropertyReferenceExpression(new CodeTypeReferenceExpression(typeof(DateTime)), "UtcNow")));
            }

            method.Statements.Add(new CodeMethodInvokeExpression(new CodeArgumentReferenceExpression("user"), "Save"));
            method.Statements.Add(CreateEmptyTaskResult());

            type.Members.Add(method);
        }

        private void CreateDeleteUserMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "DeleteAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            method.Statements.Add(new CodeMethodInvokeExpression(new CodeArgumentReferenceExpression("user"), "Delete"));
            method.Statements.Add(CreateEmptyTaskResult());

            type.Members.Add(method);
        }

        private void CreateFindByIdMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, IdentityUser.ClrFullTypeName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "FindByIdAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(string), "userId"));
            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserStore", false));

            method.Statements.Add(CreateTaskResult(new CodeMethodInvokeExpression(new CodeTypeReferenceExpression(IdentityUser.ClrFullTypeName), "LoadByEntityKey", new CodeArgumentReferenceExpression("userId"))));

            type.Members.Add(method);
        }

        private void CreateFindByIdGenericMethod(CodeTypeDeclaration type)
        {
            if (!CanImplementGenericInterfaces)
                return;

            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, IdentityUser.ClrFullTypeName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "FindByIdAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.KeyTypeName, "userId"));
            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserStore", true));

            if (IdentityUser.LoadByKeyMethod != null)
            {
                method.Statements.Add(
                    CreateTaskResult(CreateMethodInvokeExpression(IdentityUser.Entity, IdentityUser.LoadByKeyMethod,
                        new CodeArgumentReferenceExpression("userId"))));
            }
            else
            {
                method.Statements.Add(
                    CreateTaskResult(CreateMethodInvokeExpression(IdentityUser.Entity, IdentityUser.LoadByKeyMethodName,
                        CreateStringFormatExpression(new CodeArgumentReferenceExpression("userId")))));
            }

            type.Members.Add(method);
        }

        private void CreateFindByNameMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, IdentityUser.ClrFullTypeName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "FindByNameAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(string), "userName"));
            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserStore", true));
            }

            if (IdentityUser.LoadByUserNameMethod != null)
            {
                method.Statements.Add(
                    CreateTaskResult(CreateMethodInvokeExpression(IdentityUser.Entity, IdentityUser.LoadByUserNameMethod,
                        new CodeArgumentReferenceExpression("userName"))));
            }
            else
            {
                method.Statements.Add(CreateThrowInvalidOperationException());
            }

            type.Members.Add(method);
        }

        private void CreateGetUserIdMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, typeof(string).FullName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "GetUserIdAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserStore", false));

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            method.Statements.Add(CreateTaskResult(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.StringKeyPropertyName)));

            type.Members.Add(method);
        }

        private void CreateGetUserNameMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, typeof(string).FullName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "GetUserNameAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserStore", false));

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));

            method.Statements.Add(CreateTaskResult(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.UserNameProperty.Name)));

            type.Members.Add(method);
        }

        private void CreateSetUserNameMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "SetUserNameAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(string), "userName"));
            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserStore", false));

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));

            method.Statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.UserNameProperty.Name), new CodeArgumentReferenceExpression("userName")));
            method.Statements.Add(CreateEmptyTaskResult());

            type.Members.Add(method);
        }

        private void CreateGetNormalizedUserNameMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, typeof(string).FullName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "GetNormalizedUserNameAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserStore", false));

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));

            if (IdentityUser.NormalizedUserNameProperty != null)
            {
                method.Statements.Add(CreateTaskResult(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.NormalizedUserNameProperty.Name)));
            }
            else
            {
                method.Statements.Add(CreateTaskResult(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.UserNameProperty.Name)));
            }

            type.Members.Add(method);
        }

        private void CreateSetNormalizedUserNameMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "SetNormalizedUserNameAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(string), "userName"));
            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserStore", false));

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            if (IdentityUser.NormalizedUserNameProperty != null)
            {
                method.Statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.NormalizedUserNameProperty.Name), new CodeArgumentReferenceExpression("userName")));
            }
            else
            {
                method.Statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.UserNameProperty.Name), new CodeArgumentReferenceExpression("userName")));
            }

            method.Statements.Add(CreateEmptyTaskResult());

            type.Members.Add(method);
        }

        private void ImplementUserPasswordStore(CodeTypeDeclaration type)
        {
            if (!CanImplementPasswordStore)
                return;

            type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserPasswordStore", false));
            if (CanImplementGenericInterfaces)
            {
                type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserPasswordStore", true));
            }

            CreateHasPasswordMethod(type);
            CreateGetPasswordHashMethod(type);
            CreateSetPasswordHashMethod(type);
        }

        private void CreateHasPasswordMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, typeof(bool).FullName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "HasPasswordAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserPasswordStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserPasswordStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            method.Statements.Add(CreateTaskResult(CodeDomUtilities.CreateIfNotNull(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.PasswordProperty.Name))));

            type.Members.Add(method);
        }

        private void CreateGetPasswordHashMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, typeof(string).FullName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "GetPasswordHashAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserPasswordStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserPasswordStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            method.Statements.Add(CreateTaskResult(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.PasswordProperty.Name)));

            type.Members.Add(method);
        }

        private void CreateSetPasswordHashMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "SetPasswordHashAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(string), "passwordHash"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserPasswordStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserPasswordStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            method.Statements.Add(new CodeAssignStatement(
                new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.PasswordProperty.Name),
                new CodeArgumentReferenceExpression("passwordHash")));

            if (IdentityUser.LastPasswordChangeDateProperty != null)
            {
                method.Statements.Add(new CodeAssignStatement(
                        new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.LastPasswordChangeDateProperty.Name),
                        new CodePropertyReferenceExpression(new CodeTypeReferenceExpression(typeof(DateTime)), "UtcNow")));
            }

            method.Statements.Add(CreateEmptyTaskResult());
            type.Members.Add(method);
        }

        private void ImplementUserSecurityStampStore(CodeTypeDeclaration type)
        {
            if (!CanImplementSecurityStampStore)
                return;

            type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserSecurityStampStore", false));
            if (CanImplementGenericInterfaces)
            {
                type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserSecurityStampStore", true));
            }

            CreateGetSecurityStampMethod(type);
            CreateSetSecurityStampMethod(type);
        }

        private void CreateGetSecurityStampMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, typeof(string).FullName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "GetSecurityStampAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserSecurityStampStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserSecurityStampStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            method.Statements.Add(CreateTaskResult(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.SecurityStampProperty.Name)));

            type.Members.Add(method);
        }

        private void CreateSetSecurityStampMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "SetSecurityStampAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(string), "stamp"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserSecurityStampStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserSecurityStampStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            method.Statements.Add(new CodeAssignStatement(
                new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.SecurityStampProperty.Name),
                new CodeArgumentReferenceExpression("stamp")));
            method.Statements.Add(CreateEmptyTaskResult());
            type.Members.Add(method);
        }

        private void ImplementUserLockoutStore(CodeTypeDeclaration type)
        {
            if (!CanImplementLockoutStore)
                return;

            type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLockoutStore", typeof(string)));
            if (CanImplementGenericInterfaces)
            {
                type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLockoutStore", true));
            }

            CreateGetLockoutEndDateMethod(type);
            CreateSetLockoutEndDateMethod(type);
            CreateIncrementAccessFailedCountMethod(type);
            CreateResetAccessFailedCountMethod(type);
            CreateGetAccessFailedCountMethod(type);
            CreateGetLockoutEnabledMethod(type);
            CreateSetLockoutEnabledMethod(type);
        }

        private void CreateGetLockoutEndDateMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, typeof(DateTimeOffset).FullName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "GetLockoutEndDateAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLockoutStore", typeof(string)));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLockoutStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));

            if (IdentityUser.LockoutEndDateProperty.ClrFullTypeName == typeof(DateTimeOffset).FullName)
            {
                if (IdentityUser.LockoutEndDateProperty.IsModelNullable)
                {
                    var conditionStatement = new CodeConditionStatement(CreateHasValueExpression(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.LockoutEndDateProperty.Name)));
                    conditionStatement.TrueStatements.Add(CreateTaskResult(new CodePropertyReferenceExpression(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.LockoutEndDateProperty.Name), "Value")));
                    conditionStatement.FalseStatements.Add(CreateTaskResult(new CodeObjectCreateExpression(typeof(DateTimeOffset))));
                    method.Statements.Add(conditionStatement);
                }
                else
                {
                    method.Statements.Add(CreateTaskResult(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.LockoutEndDateProperty.Name)));
                }
            }
            else if (IdentityUser.LockoutEndDateProperty.ClrFullTypeName == typeof(DateTime).FullName)
            {
                if (IdentityUser.LockoutEndDateProperty.IsModelNullable)
                {
                    var conditionStatement = new CodeConditionStatement(CreateHasValueExpression(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.LockoutEndDateProperty.Name)));
                    conditionStatement.TrueStatements.Add(CreateTaskResult(
                        new CodeObjectCreateExpression(
                            typeof(DateTimeOffset),
                            new CodeMethodInvokeExpression(
                                new CodeTypeReferenceExpression(typeof(DateTime)),
                                "SpecifyKind",
                                new CodePropertyReferenceExpression(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.LockoutEndDateProperty.Name), "Value"),
                                new CodeFieldReferenceExpression(new CodeTypeReferenceExpression(typeof(DateTimeKind)), "Utc")))));
                    conditionStatement.FalseStatements.Add(CreateTaskResult(new CodeObjectCreateExpression(typeof(DateTimeOffset))));
                    method.Statements.Add(conditionStatement);
                }
                else
                {
                    method.Statements.Add(CreateTaskResult(new CodeObjectCreateExpression(typeof(DateTimeOffset),
                        new CodeMethodInvokeExpression(
                            new CodeTypeReferenceExpression(typeof(DateTime)),
                            "SpecifyKind",
                            new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.LockoutEndDateProperty.Name),
                            new CodeFieldReferenceExpression(new CodeTypeReferenceExpression(typeof(DateTimeKind)), "Utc")))));
                }
            }
            else
            {
                method.Statements.Add(CreateThrowInvalidOperationException());
            }

            type.Members.Add(method);
        }

        private void CreateSetLockoutEndDateMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "SetLockoutEndDateAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(DateTimeOffset), "lockoutEnd"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLockoutStore", typeof(string)));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLockoutStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));

            if (IdentityUser.LockoutEndDateProperty.ClrFullTypeName == typeof(DateTimeOffset).FullName)
            {
                method.Statements.Add(new CodeAssignStatement(
                    new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.LockoutEndDateProperty.Name),
                    new CodeArgumentReferenceExpression("lockoutEnd")));
            }
            else if (IdentityUser.LockoutEndDateProperty.ClrFullTypeName == typeof(DateTime).FullName)
            {
                method.Statements.Add(new CodeAssignStatement(
                    new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.LockoutEndDateProperty.Name),
                    new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("lockoutEnd"), "UtcDateTime")));
            }
            else
            {
                method.Statements.Add(CreateThrowInvalidOperationException());
            }

            method.Statements.Add(CreateEmptyTaskResult());
            type.Members.Add(method);
        }

        private void CreateIncrementAccessFailedCountMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, typeof(int).FullName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "IncrementAccessFailedCountAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLockoutStore", typeof(string)));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLockoutStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));

            if (IdentityUser.FailedPasswordAttemptCountProperty != null)
            {
                CodeConditionStatement lessZeroCondition = new CodeConditionStatement();
                lessZeroCondition.Condition = new CodeBinaryOperatorExpression(
                    new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.FailedPasswordAttemptCountProperty.Name),
                    CodeBinaryOperatorType.LessThanOrEqual,
                    new CodePrimitiveExpression(0));

                lessZeroCondition.TrueStatements.Add(new CodeAssignStatement(
                    new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.FailedPasswordAttemptCountProperty.Name),
                    new CodePrimitiveExpression(1)));

                lessZeroCondition.FalseStatements.Add(new CodeAssignStatement(
                    new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.FailedPasswordAttemptCountProperty.Name),
                    new CodeBinaryOperatorExpression(
                        new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.FailedPasswordAttemptCountProperty.Name),
                        CodeBinaryOperatorType.Add,
                        new CodePrimitiveExpression(1))));

                method.Statements.Add(lessZeroCondition);

                if (IdentityUser.FailedPasswordAttemptWindowStartProperty != null)
                {
                    var condition = new CodeConditionStatement(
                        new CodeBinaryOperatorExpression(
                            new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.FailedPasswordAttemptCountProperty.Name),
                            CodeBinaryOperatorType.ValueEquality,
                            new CodePrimitiveExpression(1)));

                    condition.TrueStatements.Add(new CodeAssignStatement(
                        new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.FailedPasswordAttemptWindowStartProperty.Name),
                        new CodePropertyReferenceExpression(new CodeTypeReferenceExpression(typeof(DateTime)), "UtcNow")));

                    method.Statements.Add(condition);
                }

                method.Statements.Add(CreateTaskResult(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.FailedPasswordAttemptCountProperty.Name)));
            }
            else
            {
                method.Statements.Add(CreateThrowInvalidOperationException());
            }

            type.Members.Add(method);
        }

        private void CreateResetAccessFailedCountMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "ResetAccessFailedCountAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLockoutStore", typeof(string)));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLockoutStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));

            if (IdentityUser.FailedPasswordAttemptCountProperty != null)
            {
                method.Statements.Add(new CodeAssignStatement(
                    new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.FailedPasswordAttemptCountProperty.Name),
                    new CodePrimitiveExpression(0)));

                method.Statements.Add(CreateTaskResult(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.FailedPasswordAttemptCountProperty.Name)));
            }
            else
            {
                method.Statements.Add(CreateThrowInvalidOperationException());
            }

            type.Members.Add(method);
        }

        private void CreateGetAccessFailedCountMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, typeof(int).FullName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "GetAccessFailedCountAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLockoutStore", typeof(string)));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLockoutStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));

            if (IdentityUser.FailedPasswordAttemptCountProperty != null)
            {
                method.Statements.Add(CreateTaskResult(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.FailedPasswordAttemptCountProperty.Name)));
            }
            else
            {
                method.Statements.Add(CreateThrowInvalidOperationException());
            }

            type.Members.Add(method);
        }

        private void CreateGetLockoutEnabledMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, typeof(bool).FullName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "GetLockoutEnabledAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLockoutStore", typeof(string)));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLockoutStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));

            if (IdentityUser.LockoutEnabledProperty != null)
            {
                method.Statements.Add(CreateTaskResult(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.LockoutEnabledProperty.Name)));
            }
            else
            {
                method.Statements.Add(CreateTaskResult(new CodePrimitiveExpression(true)));
            }

            type.Members.Add(method);
        }

        private void CreateSetLockoutEnabledMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "SetLockoutEnabledAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(bool), "enabled"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLockoutStore", typeof(string)));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLockoutStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));

            if (IdentityUser.LockoutEnabledProperty != null)
            {
                method.Statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.LockoutEnabledProperty.Name), new CodeArgumentReferenceExpression("enabled")));
            }

            method.Statements.Add(CreateEmptyTaskResult());
            type.Members.Add(method);
        }

        private void ImplementUserPhoneNumberStore(CodeTypeDeclaration type)
        {
            if (!CanImplementUserPhoneNumberStore)
                return;

            type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserPhoneNumberStore", false));
            if (CanImplementGenericInterfaces)
            {
                type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserPhoneNumberStore", true));
            }

            CreateGetPhoneNumberConfirmedMethod(type);
            CreateSetPhoneNumberConfirmedMethod(type);
            CreateGetPhoneNumberMethod(type);
            CreateSetPhoneNumberMethod(type);
        }

        private void CreateGetPhoneNumberConfirmedMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, typeof(bool).FullName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "GetPhoneNumberConfirmedAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserPhoneNumberStore", typeof(string)));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserPhoneNumberStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));

            if (IdentityUser.PhoneNumberConfirmedProperty != null)
            {
                method.Statements.Add(CreateTaskResult(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.PhoneNumberConfirmedProperty.Name)));
            }
            else
            {
                method.Statements.Add(CreateTaskResult(new CodePrimitiveExpression(true)));
            }

            type.Members.Add(method);
        }

        private void CreateSetPhoneNumberConfirmedMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "SetPhoneNumberConfirmedAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(bool), "confirmed"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserPhoneNumberStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserPhoneNumberStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));

            if (IdentityUser.PhoneNumberConfirmedProperty != null)
            {
                method.Statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.PhoneNumberConfirmedProperty.Name), new CodeArgumentReferenceExpression("confirmed")));
            }

            method.Statements.Add(CreateEmptyTaskResult());
            type.Members.Add(method);
        }

        private void CreateGetPhoneNumberMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, typeof(string).FullName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "GetPhoneNumberAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserPhoneNumberStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserPhoneNumberStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            method.Statements.Add(CreateTaskResult(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.PhoneNumberProperty.Name)));

            type.Members.Add(method);
        }

        private void CreateSetPhoneNumberMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "SetPhoneNumberAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(string), "phoneNumber"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserPhoneNumberStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserPhoneNumberStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            method.Statements.Add(new CodeAssignStatement(
                new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.PhoneNumberProperty.Name),
                new CodeArgumentReferenceExpression("phoneNumber")));
            method.Statements.Add(CreateEmptyTaskResult());
            type.Members.Add(method);
        }

        private void ImplementUserTwoFactorStore(CodeTypeDeclaration type)
        {
            if (!CanImplementTwoFactorStore)
                return;

            type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserTwoFactorStore", typeof(string)));
            if (CanImplementGenericInterfaces)
            {
                type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserTwoFactorStore", true));
            }

            CreateGetTwoFactorEnabledMethod(type);
            CreateSetTwoFactorEnabledMethod(type);
        }

        private void CreateGetTwoFactorEnabledMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, typeof(bool).FullName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "GetTwoFactorEnabledAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserTwoFactorStore", typeof(string)));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserTwoFactorStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));

            if (IdentityUser.TwoFactorEnabledProperty != null)
            {
                method.Statements.Add(CreateTaskResult(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.TwoFactorEnabledProperty.Name)));
            }
            else
            {
                method.Statements.Add(CreateTaskResult(new CodePrimitiveExpression(false)));
            }

            type.Members.Add(method);
        }

        private void CreateSetTwoFactorEnabledMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "SetTwoFactorEnabledAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(bool), "enabled"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserTwoFactorStore", typeof(string)));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserTwoFactorStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));

            if (IdentityUser.TwoFactorEnabledProperty != null)
            {
                method.Statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.TwoFactorEnabledProperty.Name), new CodeArgumentReferenceExpression("enabled")));
            }

            method.Statements.Add(CreateEmptyTaskResult());
            type.Members.Add(method);
        }

        private void ImplementUserEmailStore(CodeTypeDeclaration type)
        {
            if (!CanImplementEmailStore)
                return;

            type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserEmailStore", false));
            if (CanImplementGenericInterfaces)
            {
                type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserEmailStore", true));
            }

            CreateGetEmailMethod(type);
            CreateSetEmailMethod(type);
            CreateGetEmailConfirmedMethod(type);
            CreateSetEmailConfirmedMethod(type);
            CreateFindByEmailMethod(type);
        }

        private void CreateGetEmailConfirmedMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, typeof(bool).FullName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "GetEmailConfirmedAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserEmailStore", typeof(string)));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserEmailStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));

            if (IdentityUser.EmailConfirmedProperty != null)
            {
                method.Statements.Add(CreateTaskResult(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.EmailConfirmedProperty.Name)));
            }
            else
            {
                method.Statements.Add(CreateTaskResult(new CodePrimitiveExpression(true)));
            }

            type.Members.Add(method);
        }

        private void CreateSetEmailConfirmedMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "SetEmailConfirmedAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(bool), "confirmed"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserEmailStore", typeof(string)));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserEmailStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));

            if (IdentityUser.EmailConfirmedProperty != null)
            {
                method.Statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.EmailConfirmedProperty.Name), new CodeArgumentReferenceExpression("confirmed")));
            }

            method.Statements.Add(CreateEmptyTaskResult());
            type.Members.Add(method);
        }

        private void CreateGetEmailMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, typeof(string).FullName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "GetEmailAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserEmailStore", typeof(string)));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserEmailStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            method.Statements.Add(CreateTaskResult(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.EmailProperty.Name)));

            type.Members.Add(method);
        }

        private void CreateSetEmailMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "SetEmailAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(string), "email"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserEmailStore", typeof(string)));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserEmailStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            method.Statements.Add(new CodeAssignStatement(
                new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.EmailProperty.Name),
                new CodeArgumentReferenceExpression("email")));
            method.Statements.Add(CreateEmptyTaskResult());
            type.Members.Add(method);
        }

        private void CreateFindByEmailMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, IdentityUser.ClrFullTypeName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "FindByEmailAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(string), "email"));
            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserEmailStore", typeof(string)));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserEmailStore", true));
            }

            if (IdentityUser.LoadByEmailMethod != null)
            {
                method.Statements.Add(
                    CreateTaskResult(CreateMethodInvokeExpression(IdentityUser.Entity, IdentityUser.LoadByEmailMethod,
                        new CodeArgumentReferenceExpression("email"))));
            }
            else
            {
                method.Statements.Add(CreateThrowInvalidOperationException());
            }

            type.Members.Add(method);
        }

        private void ImplementUserRoleStore(CodeTypeDeclaration type)
        {
            if (!CanImplementUserRoleStore)
                return;

            type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserRoleStore", false));
            if (CanImplementGenericInterfaces)
            {
                type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserRoleStore", true));
            }

            CreateAddToRoleMethod(type);
            CreateRemoveToRoleMethod(type);
            CreateGetRolesMethod(type);
            CreateIsInRoleMethod(type);
        }

        private CodeExpression CreateRoleNotFoundMessage(CodeStatementCollection statements, Message message, CodeExpression roleName)
        {
            if (message == null)
            {
                return new CodeMethodInvokeExpression(new CodeTypeReferenceExpression(typeof(string)), "Format", new CodePrimitiveExpression(IdentityRole.RoleNotFoundMessage), roleName);
            }
            else
            {
                statements.Add(new CodeVariableDeclarationStatement(typeof(object).MakeArrayType(), "args",
                    new CodeArrayCreateExpression(typeof(object).MakeArrayType(), 1)));

                statements.Add(
                    new CodeAssignStatement(
                        new CodeArrayIndexerExpression(new CodeVariableReferenceExpression("args"), new CodePrimitiveExpression(0)), roleName));

                return new CodeMethodInvokeExpression(
                    new CodeTypeReferenceExpression(message.Project.DefaultNamespace + ".Resources.Manager"),
                    "GetStringWithDefault",
                    new CodePrimitiveExpression(message.Name),
                    new CodePrimitiveExpression(message.Value),
                    new CodeVariableReferenceExpression("args"));
            }
        }

        private void AddRoleLoadByRoleName(CodeMemberMethod method)
        {
            method.Statements.Add(new CodeVariableDeclarationStatement(IdentityRole.ClrFullTypeName, "role",
                CreateMethodInvokeExpression(IdentityRole.Entity, IdentityRole.LoadByNameMethod, new CodeArgumentReferenceExpression("roleName"))));
            CodeConditionStatement ifRoleNull = new CodeConditionStatement(CodeDomUtilities.CreateIfNull(new CodeVariableReferenceExpression("role")));
            ifRoleNull.TrueStatements.Add(new CodeThrowExceptionStatement(new CodeObjectCreateExpression(typeof(ArgumentException), CreateRoleNotFoundMessage(ifRoleNull.TrueStatements, ProjectMessages.RoleNotFoundMessage, new CodeArgumentReferenceExpression("roleName")))));
            method.Statements.Add(ifRoleNull);
        }

        private void CreateAddToRoleMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "AddToRoleAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(string), "roleName"));
            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserRoleStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserRoleStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            AddRoleLoadByRoleName(method);

            //role.Users.Add(user);
            method.Statements.Add(
                new CodeMethodInvokeExpression(
                    new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.RolesProperty.Name), "Add",
                    new CodeVariableReferenceExpression("role")));

            // user.SaveRolesRelations();
            method.Statements.Add(
                new CodeMethodInvokeExpression(
                    new CodeArgumentReferenceExpression("user"),
                    "Save" + IdentityUser.RolesProperty.Name + "Relations"));

            method.Statements.Add(CreateEmptyTaskResult());
            type.Members.Add(method);
        }

        private void CreateRemoveToRoleMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "RemoveFromRoleAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(string), "roleName"));
            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserRoleStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserRoleStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            AddRoleLoadByRoleName(method);

            //role.Users.Add(user);
            method.Statements.Add(
                new CodeMethodInvokeExpression(
                    new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.RolesProperty.Name), "Remove",
                    new CodeVariableReferenceExpression("role")));

            // user.SaveRolesRelations();
            method.Statements.Add(
                new CodeMethodInvokeExpression(
                    new CodeArgumentReferenceExpression("user"),
                    "Save" + IdentityUser.RolesProperty.Name + "Relations"));

            method.Statements.Add(CreateEmptyTaskResult());
            type.Members.Add(method);
        }

        private void CreateGetRolesMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            CodeTypeReference returnType = CreateTaskTypeReference();
            returnType.TypeArguments.Add(CodeDomUtilities.GetGenericType(typeof(IList<>), typeof(string)));
            method.ReturnType = returnType;
            method.Attributes = MemberAttributes.Public;
            method.Name = "GetRolesAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserRoleStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserRoleStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));

            method.Statements.Add(new CodeVariableDeclarationStatement(typeof(IList<>).MakeGenericType(typeof(string)), "roleNames", new CodeObjectCreateExpression(typeof(List<>).MakeGenericType(typeof(string)))));

            var enumerator = new CodeVariableDeclarationStatement(CodeDomUtilities.GetGenericType(typeof(IEnumerator<>), IdentityRole.ClrFullTypeName), "enumerator");
            enumerator.InitExpression = new CodeMethodInvokeExpression(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.RolesProperty.Name), "GetEnumerator");

            var iteration = new CodeIterationStatement();
            iteration.InitStatement = enumerator;
            iteration.TestExpression = new CodeMethodInvokeExpression(new CodeVariableReferenceExpression("enumerator"), "MoveNext");
            iteration.IncrementStatement = new CodeSnippetStatement("");

            iteration.Statements.Add(
                new CodeMethodInvokeExpression(
                    new CodeVariableReferenceExpression("roleNames"), "Add",
                    new CodePropertyReferenceExpression(new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("enumerator"), "Current"), IdentityRole.NameProperty.Name)));
            method.Statements.Add(iteration);

            method.Statements.Add(CreateTaskResult(new CodeVariableReferenceExpression("roleNames")));
            type.Members.Add(method);
        }

        private void CreateIsInRoleMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, typeof(bool).FullName);
            method.Attributes = MemberAttributes.Public;
            method.Name = "IsInRoleAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(string), "roleName"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserRoleStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserRoleStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            AddRoleLoadByRoleName(method);

            // return System.Threading.Tasks.Task.FromResult(user.Roles.Contains(role));
            method.Statements.Add(new CodeVariableDeclarationStatement(typeof(bool), "result",
                new CodeMethodInvokeExpression(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.RolesProperty.Name), "Contains",
                    new CodeVariableReferenceExpression("role"))));

            method.Statements.Add(CreateTaskResult(new CodeVariableReferenceExpression("result")));
            type.Members.Add(method);
        }

        private void ImplementUserLoginStore(CodeTypeDeclaration type)
        {
            if (!CanImplementUserLoginStore)
                return;

            type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLoginStore", false));
            if (CanImplementGenericInterfaces)
            {
                type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLoginStore", true));
            }

            CreateAddLoginMethod(type);
            CreateRemoveLoginMethod(type);
            CreateGetLoginsMethod(type);
            CreateFindByLoginMethod(type);
        }

        private CodeExpression GetLoginProviderKeyExpression()
        {
            if (IdentityProducer.TargetVersion == AspNetIdentityVersion.Version3)
            {
                return new CodeArgumentReferenceExpression("providerKey");
            }
            return new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("userLoginInfo"), "ProviderKey");
        }
        private CodeExpression GetLoginProviderNameExpression()
        {
            if (IdentityProducer.TargetVersion == AspNetIdentityVersion.Version3)
            {
                return new CodeArgumentReferenceExpression("loginProvider");
            }
            return new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("userLoginInfo"), "LoginProvider");
        }

        private void CreateAddLoginMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "AddLoginAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.Parameters.Add(new CodeParameterDeclarationExpression("Microsoft.AspNet.Identity.UserLoginInfo", "userLoginInfo"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLoginStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLoginStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("userLoginInfo"));

            method.Statements.Add(new CodeVariableDeclarationStatement(new CodeTypeReference(IdentityUserLogin.ClrFullTypeName), "login", new CodeObjectCreateExpression(IdentityUserLogin.ClrFullTypeName)));
            method.Statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("login"), IdentityUserLogin.UserProperty.Name),
                new CodeArgumentReferenceExpression("user")));
            method.Statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("login"), IdentityUserLogin.ProviderKeyProperty.Name),
                new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("userLoginInfo"), "ProviderKey")));
            if (IdentityUserLogin.ProviderNameProperty != null)
            {
                method.Statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("login"), IdentityUserLogin.ProviderNameProperty.Name),
                    new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("userLoginInfo"), "LoginProvider")));
            }

            method.Statements.Add(new CodeMethodInvokeExpression(new CodeVariableReferenceExpression("login"), "Save"));
            method.Statements.Add(new CodeMethodInvokeExpression(
                new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.LoginsProperty.Name), "Add", new CodeVariableReferenceExpression("login")));

            method.Statements.Add(CreateEmptyTaskResult());
            type.Members.Add(method);
        }

        private void CreateRemoveLoginMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "RemoveLoginAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            if (IdentityProducer.TargetVersion == AspNetIdentityVersion.Version3)
            {
                method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(string), "loginProvider"));
                method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(string), "providerKey"));
            }
            else
            {
                method.Parameters.Add(new CodeParameterDeclarationExpression("Microsoft.AspNet.Identity.UserLoginInfo", "userLoginInfo"));
            }

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLoginStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLoginStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            if (IdentityProducer.TargetVersion != AspNetIdentityVersion.Version3)
            {
                method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("userLoginInfo"));
            }

            bool useMethod = false;
            if (IdentityUserLogin.DeleteByUserLoginInfoMethod != null)
            {
                if (IdentityUserLogin.DeleteByUserLoginInfoMethod.Parameters.Count == 2)
                {
                    method.Statements.Add(CreateMethodInvokeExpression(IdentityUserLogin.Entity, IdentityUserLogin.DeleteByUserLoginInfoMethod,
                        new CodeArgumentReferenceExpression("user"),
                        GetLoginProviderKeyExpression()));
                    useMethod = true;
                }
                else if (IdentityUserLogin.DeleteByUserLoginInfoMethod.Parameters.Count == 3)
                {
                    method.Statements.Add(CreateMethodInvokeExpression(IdentityUserLogin.Entity, IdentityUserLogin.DeleteByUserLoginInfoMethod,
                        new CodeArgumentReferenceExpression("user"),
                        GetLoginProviderKeyExpression(),
                        GetLoginProviderNameExpression()));
                    useMethod = true;
                }
            }

            if (!useMethod)
            {
                /*
                List<UserLogin> toDelete = new List<UserLogin>();
                foreach (var userLogin in user.Logins)
                {
                    if (userLogin.Equals(userLoginInfo))
                    {
                        toDelete.Add(userLogin);
                    }
                }*/
                method.Statements.Add(new CodeVariableDeclarationStatement(CodeDomUtilities.GetGenericType(typeof(IList<>), IdentityUserLogin.ClrFullTypeName), "toDelete", new CodeObjectCreateExpression(CodeDomUtilities.GetGenericType(typeof(List<>), IdentityUserLogin.ClrFullTypeName))));

                var userLoginsEnumerator = CodeDomUtilities.GetUniqueVariable(method, CodeDomUtilities.GetGenericType(typeof(IEnumerator<>), IdentityUserLogin.ClrFullTypeName), "enumerator");
                userLoginsEnumerator.InitExpression = new CodeMethodInvokeExpression(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.LoginsProperty.Name), "GetEnumerator");

                var userLoginsIteration = new CodeIterationStatement();
                userLoginsIteration.InitStatement = userLoginsEnumerator;
                userLoginsIteration.TestExpression = new CodeMethodInvokeExpression(new CodeVariableReferenceExpression(userLoginsEnumerator.Name), "MoveNext");
                userLoginsIteration.IncrementStatement = new CodeSnippetStatement("");
                method.Statements.Add(userLoginsIteration);

                userLoginsIteration.Statements.Add(new CodeVariableDeclarationStatement(IdentityUserLogin.ClrFullTypeName, "userLogin", new CodePropertyReferenceExpression(new CodeVariableReferenceExpression(userLoginsEnumerator.Name), "Current")));
                CodeConditionStatement loginEqual = new CodeConditionStatement();
                userLoginsIteration.Statements.Add(loginEqual);
                loginEqual.Condition = CreateStringEqualsExpression(StringComparison.OrdinalIgnoreCase,
                            new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("userLogin"), IdentityUserLogin.ProviderKeyProperty.Name),
                            GetLoginProviderKeyExpression());

                if (IdentityUserLogin.ProviderNameProperty != null && IdentityUserLogin.ProviderNameProperty.GetAttributeValue("isComparer", Constants.NamespaceUri, true))
                {
                    loginEqual.Condition = new CodeBinaryOperatorExpression(loginEqual.Condition, CodeBinaryOperatorType.BooleanAnd,
                        CreateStringEqualsExpression(StringComparison.OrdinalIgnoreCase,
                            new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("userLogin"), IdentityUserLogin.ProviderNameProperty.Name),
                            GetLoginProviderNameExpression()));
                }

                loginEqual.TrueStatements.Add(new CodeMethodInvokeExpression(new CodeVariableReferenceExpression("toDelete"), "Add", new CodeVariableReferenceExpression("userLogin")));

                /*
                foreach (var userLogin in toDelete)
                {
                    userLogin.Delete();
                    user.Logins.Remove(userLogin);
                }
                */

                var toDeleteEnumerator = CodeDomUtilities.GetUniqueVariable(method, CodeDomUtilities.GetGenericType(typeof(IEnumerator<>), IdentityUserLogin.ClrFullTypeName), "enumerator");
                toDeleteEnumerator.InitExpression = new CodeMethodInvokeExpression(new CodeVariableReferenceExpression("toDelete"), "GetEnumerator");

                var toDeleteIteration = new CodeIterationStatement();
                toDeleteIteration.InitStatement = toDeleteEnumerator;
                toDeleteIteration.TestExpression = new CodeMethodInvokeExpression(new CodeVariableReferenceExpression(toDeleteEnumerator.Name), "MoveNext");
                toDeleteIteration.IncrementStatement = new CodeSnippetStatement("");
                method.Statements.Add(toDeleteIteration);

                toDeleteIteration.Statements.Add(new CodeVariableDeclarationStatement(IdentityUserLogin.ClrFullTypeName, "userLogin", new CodePropertyReferenceExpression(new CodeVariableReferenceExpression(toDeleteEnumerator.Name), "Current")));
                toDeleteIteration.Statements.Add(new CodeMethodInvokeExpression(new CodeVariableReferenceExpression("userLogin"), "Delete"));
                toDeleteIteration.Statements.Add(new CodeMethodInvokeExpression(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.LoginsProperty.Name), "Remove", new CodeVariableReferenceExpression("userLogin")));
            }

            method.Statements.Add(CreateEmptyTaskResult());
            type.Members.Add(method);
        }

        private void CreateGetLoginsMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            CodeTypeReference returnType = CreateTaskTypeReference();
            returnType.TypeArguments.Add(CodeDomUtilities.GetGenericType(typeof(IList<>), "Microsoft.AspNet.Identity.UserLoginInfo"));
            method.ReturnType = returnType;
            method.Attributes = MemberAttributes.Public;
            method.Name = "GetLoginsAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLoginStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLoginStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));

            method.Statements.Add(new CodeVariableDeclarationStatement(CodeDomUtilities.GetGenericType(typeof(IList<>), "Microsoft.AspNet.Identity.UserLoginInfo"), "result", new CodeObjectCreateExpression(CodeDomUtilities.GetGenericType(typeof(List<>), "Microsoft.AspNet.Identity.UserLoginInfo"))));

            var enumerator = new CodeVariableDeclarationStatement(CodeDomUtilities.GetGenericType(typeof(IEnumerator<>), IdentityUserLogin.ClrFullTypeName), "enumerator");
            enumerator.InitExpression = new CodeMethodInvokeExpression(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.LoginsProperty.Name), "GetEnumerator");

            var iteration = new CodeIterationStatement();
            iteration.InitStatement = enumerator;
            iteration.TestExpression = new CodeMethodInvokeExpression(new CodeVariableReferenceExpression("enumerator"), "MoveNext");
            iteration.IncrementStatement = new CodeSnippetStatement("");

            iteration.Statements.Add(new CodeVariableDeclarationStatement(IdentityUserLogin.ClrFullTypeName, "userLogin", new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("enumerator"), "Current")));
            // V1 & V2: public UserLoginInfo(string loginProvider, string providerKey)
            // V3:      public UserLoginInfo(string loginProvider, string providerKey, string displayName)
            var createExpression = new CodeObjectCreateExpression("Microsoft.AspNet.Identity.UserLoginInfo");
            if (IdentityUserLogin.ProviderNameProperty != null)
            {
                createExpression.Parameters.Add(new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("userLogin"), IdentityUserLogin.ProviderNameProperty.Name));
            }
            else
            {
                createExpression.Parameters.Add(new CodePrimitiveExpression(null));
            }

            createExpression.Parameters.Add(new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("userLogin"), IdentityUserLogin.ProviderKeyProperty.Name));

            if (IdentityProducer.TargetVersion == AspNetIdentityVersion.Version3)
            {
                if (IdentityUserLogin.ProviderDisplayNameProperty != null)
                {
                    createExpression.Parameters.Add(new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("userLogin"), IdentityUserLogin.ProviderDisplayNameProperty.Name));
                }
                else
                {
                    createExpression.Parameters.Add(new CodePrimitiveExpression(null));
                }
            }

            iteration.Statements.Add(
                new CodeMethodInvokeExpression(
                    new CodeVariableReferenceExpression("result"), "Add",
                    createExpression));
            method.Statements.Add(iteration);

            method.Statements.Add(CreateTaskResult(new CodeVariableReferenceExpression("result")));
            type.Members.Add(method);
        }

        private void CreateFindByLoginMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CodeDomUtilities.GetGenericType(TaskFullTypeName, IdentityUser.ClrFullTypeName);
            method.Attributes = MemberAttributes.Public;
            if (IdentityProducer.TargetVersion == AspNetIdentityVersion.Version3)
            {
                method.Name = "FindByLoginAsync";
                method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(string), "loginProvider"));
                method.Parameters.Add(new CodeParameterDeclarationExpression(typeof(string), "providerKey"));
            }
            else
            {
                method.Name = "FindAsync";
                method.Parameters.Add(new CodeParameterDeclarationExpression("Microsoft.AspNet.Identity.UserLoginInfo", "userLoginInfo"));
            }


            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLoginStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserLoginStore", true));
            }

            if (IdentityUser.LoadByUserLoginInfoMethod != null)
            {
                var invokeExpression = CreateMethodInvokeExpression(IdentityUser.Entity, IdentityUser.LoadByUserLoginInfoMethod);
                invokeExpression.Parameters.Add(GetLoginProviderKeyExpression());
                if (IdentityUser.LoadByUserLoginInfoMethod.Parameters.Count > 1)
                {
                    invokeExpression.Parameters.Add(GetLoginProviderNameExpression());
                }

                method.Statements.Add(CreateTaskResult(invokeExpression));
            }
            else
            {
                method.Statements.Add(CreateThrowInvalidOperationException());
            }

            type.Members.Add(method);
        }

        private void ImplementUserClaimStore(CodeTypeDeclaration type)
        {
            if (!CanImplementUserClaimsStore)
                return;

            type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserClaimStore", false));
            if (CanImplementGenericInterfaces)
            {
                type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserClaimStore", true));
            }

            CreateAddClaimMethod(type);
            CreateAddClaimsMethod(type);
            CreateRemoveClaimMethod(type);
            CreateRemoveClaimsMethod(type);
            CreateReplaceClaimMethod(type); 
            CreateGetClaimsMethod(type);
        }

        private void AddSetAndSaveUserClaimFromClaim(CodeStatementCollection statements, CodeExpression userClaim, Func<string, CodeExpression> getClaimProperty)
        {
            statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(userClaim, IdentityUserClaim.UserProperty.Name), new CodeArgumentReferenceExpression("user")));

            statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(userClaim, IdentityUserClaim.TypeProperty.Name), getClaimProperty("Type")));
            statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(userClaim, IdentityUserClaim.ValueProperty.Name), getClaimProperty("Value")));

            if (IdentityUserClaim.IssuerProperty != null)
            {
                statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(userClaim, IdentityUserClaim.IssuerProperty.Name), getClaimProperty("Issuer")));
            }
            if (IdentityUserClaim.OriginalIssuerProperty != null)
            {
                statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(userClaim, IdentityUserClaim.OriginalIssuerProperty.Name), getClaimProperty("OriginalIssuer")));
            }
            if (IdentityUserClaim.ValueTypeProperty != null)
            {
                statements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(userClaim, IdentityUserClaim.ValueTypeProperty.Name), getClaimProperty("ValueType")));
            }

            statements.Add(new CodeMethodInvokeExpression(userClaim, "Save"));
        }

        private void AddCreateUserClaimFromClaim(CodeStatementCollection statements, Func<string, CodeExpression> getClaimProperty)
        {
            statements.Add(new CodeVariableDeclarationStatement(new CodeTypeReference(IdentityUserClaim.ClrFullTypeName), "userClaim", new CodeObjectCreateExpression(IdentityUserClaim.ClrFullTypeName)));
            AddSetAndSaveUserClaimFromClaim(statements, new CodeVariableReferenceExpression("userClaim"), getClaimProperty);
            statements.Add(new CodeMethodInvokeExpression(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.ClaimsProperty.Name), "Add", new CodeVariableReferenceExpression("userClaim")));
        }

        private void CreateAddClaimMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "AddClaimAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(ClaimFullTypeName, "claim"));

            if (IdentityProducer.TargetVersion == AspNetIdentityVersion.Version1 || IdentityProducer.TargetVersion == AspNetIdentityVersion.Version2)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserClaimStore", false));
                if (CanImplementGenericInterfaces)
                {
                    method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserClaimStore", true));
                }
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("claim"));


            Func<string, CodeExpression> claimProperty = propertyName => new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("claim"), propertyName);
            AddCreateUserClaimFromClaim(method.Statements, claimProperty);
            method.Statements.Add(CreateEmptyTaskResult());
            type.Members.Add(method);
        }

        private void CreateAddClaimsMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "AddClaimsAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(CodeDomUtilities.GetGenericType(typeof(IEnumerable<>), ClaimFullTypeName), "claims"));

            if (IdentityProducer.TargetVersion == AspNetIdentityVersion.Version3)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserClaimStore", false));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("claims"));

            var enumerator = new CodeVariableDeclarationStatement(CodeDomUtilities.GetGenericType(typeof(IEnumerator<>), ClaimFullTypeName), "enumerator");
            enumerator.InitExpression = new CodeMethodInvokeExpression(new CodeArgumentReferenceExpression("claims"), "GetEnumerator");

            var iteration = new CodeIterationStatement();
            iteration.InitStatement = enumerator;
            iteration.TestExpression = new CodeMethodInvokeExpression(new CodeVariableReferenceExpression("enumerator"), "MoveNext");
            iteration.IncrementStatement = new CodeSnippetStatement("");
            iteration.Statements.Add(new CodeVariableDeclarationStatement(ClaimFullTypeName, "claim", new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("enumerator"), "Current")));
            method.Statements.Add(iteration);

            Func<string, CodeExpression> claimProperty = propertyName => new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("claim"), propertyName);
            AddCreateUserClaimFromClaim(iteration.Statements, claimProperty);
            method.Statements.Add(CreateEmptyTaskResult());
            type.Members.Add(method);
        }

        private void AddRemoveUserClaimFromClaim(CodeMemberMethod method, CodeStatementCollection statements, Func<string, CodeExpression> getClaimProperty)
        {
            bool useMethod = false;
            if (IdentityUserClaim.DeleteClaimsMethod != null)
            {
                CodeMethodInvokeExpression invokeMethod = CreateMethodInvokeExpression(IdentityUserClaim.Entity, IdentityUserClaim.DeleteClaimsMethod);
                foreach (var parameter in IdentityUserClaim.DeleteClaimsMethod.Parameters)
                {
                    if (parameter.ProjectProperty == IdentityUserClaim.UserProperty)
                    {
                        invokeMethod.Parameters.Add(new CodeArgumentReferenceExpression("user"));
                    }
                    else if (parameter.ProjectProperty == IdentityUserClaim.TypeProperty)
                    {
                        invokeMethod.Parameters.Add(getClaimProperty("Type"));
                    }
                    else if (parameter.ProjectProperty == IdentityUserClaim.ValueProperty)
                    {
                        invokeMethod.Parameters.Add(getClaimProperty("Value"));
                    }
                    else if (parameter.ProjectProperty == IdentityUserClaim.ValueTypeProperty)
                    {
                        invokeMethod.Parameters.Add(getClaimProperty("ValueType"));
                    }
                    else if (parameter.ProjectProperty == IdentityUserClaim.IssuerProperty)
                    {
                        invokeMethod.Parameters.Add(getClaimProperty("Issuer"));
                    }
                    else if (parameter.ProjectProperty == IdentityUserClaim.OriginalIssuerProperty)
                    {
                        invokeMethod.Parameters.Add(getClaimProperty("OriginalIssuer"));
                    }
                    else
                    {
                        invokeMethod = null;
                        break;
                    }
                }

                if (invokeMethod != null)
                {
                    statements.Add(invokeMethod);
                    useMethod = true;
                }
            }

            if (!useMethod)
            {
                /*
                List<UserClaim> toDelete = new List<UserClaim>();
                foreach (var userClaim in user.Claims)
                {
                    if (userClaim.Equals(claim))
                    {
                        toDelete.Add(userClaim);
                    }
                }*/
                statements.Add(new CodeVariableDeclarationStatement(CodeDomUtilities.GetGenericType(typeof(IList<>), IdentityUserClaim.ClrFullTypeName), "toDelete", new CodeObjectCreateExpression(CodeDomUtilities.GetGenericType(typeof(List<>), IdentityUserClaim.ClrFullTypeName))));

                var userClaimsEnumerator = CodeDomUtilities.GetUniqueVariable(method, CodeDomUtilities.GetGenericType(typeof(IEnumerator<>), IdentityUserClaim.ClrFullTypeName), "enumerator");
                userClaimsEnumerator.InitExpression = new CodeMethodInvokeExpression(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.ClaimsProperty.Name), "GetEnumerator");

                var userClaimsIteration = new CodeIterationStatement();
                userClaimsIteration.InitStatement = userClaimsEnumerator;
                userClaimsIteration.TestExpression = new CodeMethodInvokeExpression(new CodeVariableReferenceExpression(userClaimsEnumerator.Name), "MoveNext");
                userClaimsIteration.IncrementStatement = new CodeSnippetStatement("");
                statements.Add(userClaimsIteration);

                userClaimsIteration.Statements.Add(new CodeVariableDeclarationStatement(IdentityUserClaim.ClrFullTypeName, "userClaim", new CodePropertyReferenceExpression(new CodeVariableReferenceExpression(userClaimsEnumerator.Name), "Current")));

                CodeConditionStatement claimsEqual = new CodeConditionStatement();
                userClaimsIteration.Statements.Add(claimsEqual);
                claimsEqual.Condition = CreateStringEqualsExpression(StringComparison.OrdinalIgnoreCase,
                        new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("userClaim"), IdentityUserClaim.TypeProperty.Name),
                        getClaimProperty("Type"));

                if (IdentityUserClaim.ValueProperty.GetAttributeValue("isComparer", Constants.NamespaceUri, true))
                {
                    claimsEqual.Condition = new CodeBinaryOperatorExpression(claimsEqual.Condition, CodeBinaryOperatorType.BooleanAnd, CreateStringEqualsExpression(StringComparison.OrdinalIgnoreCase,
                        new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("userClaim"), IdentityUserClaim.ValueProperty.Name),
                        getClaimProperty("Value")));
                }

                if (IdentityUserClaim.ValueTypeProperty != null && IdentityUserClaim.ValueTypeProperty.GetAttributeValue("isComparer", Constants.NamespaceUri, false))
                {
                    claimsEqual.Condition = new CodeBinaryOperatorExpression(claimsEqual.Condition, CodeBinaryOperatorType.BooleanAnd,
                        CreateStringEqualsExpression(StringComparison.OrdinalIgnoreCase,
                            new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("userClaim"), IdentityUserClaim.ValueTypeProperty.Name),
                            getClaimProperty("ValueType")));
                }

                if (IdentityUserClaim.IssuerProperty != null && IdentityUserClaim.IssuerProperty.GetAttributeValue("isComparer", Constants.NamespaceUri, false))
                {
                    claimsEqual.Condition = new CodeBinaryOperatorExpression(claimsEqual.Condition, CodeBinaryOperatorType.BooleanAnd,
                        CreateStringEqualsExpression(StringComparison.OrdinalIgnoreCase,
                            new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("userClaim"), IdentityUserClaim.IssuerProperty.Name),
                            getClaimProperty("Issuer")));
                }

                if (IdentityUserClaim.OriginalIssuerProperty != null && IdentityUserClaim.OriginalIssuerProperty.GetAttributeValue("isComparer", Constants.NamespaceUri, false))
                {
                    claimsEqual.Condition = new CodeBinaryOperatorExpression(claimsEqual.Condition, CodeBinaryOperatorType.BooleanAnd,
                        CreateStringEqualsExpression(StringComparison.OrdinalIgnoreCase,
                            new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("userClaim"), IdentityUserClaim.OriginalIssuerProperty.Name),
                            getClaimProperty("OriginalIssuer")));
                }

                claimsEqual.TrueStatements.Add(new CodeMethodInvokeExpression(new CodeVariableReferenceExpression("toDelete"), "Add", new CodeVariableReferenceExpression("userClaim")));

                /*
                foreach (var userClaim in toDelete)
                {
                    userClaim.Delete();
                    user.Claims.Remove(userClaim);
                }
                */

                var toDeleteEnumerator = CodeDomUtilities.GetUniqueVariable(method, CodeDomUtilities.GetGenericType(typeof(IEnumerator<>), IdentityUserClaim.ClrFullTypeName), "enumerator");
                toDeleteEnumerator.InitExpression = new CodeMethodInvokeExpression(new CodeVariableReferenceExpression("toDelete"), "GetEnumerator");

                var toDeleteIteration = new CodeIterationStatement();
                toDeleteIteration.InitStatement = toDeleteEnumerator;
                toDeleteIteration.TestExpression = new CodeMethodInvokeExpression(new CodeVariableReferenceExpression(toDeleteEnumerator.Name), "MoveNext");
                toDeleteIteration.IncrementStatement = new CodeSnippetStatement("");
                statements.Add(toDeleteIteration);

                toDeleteIteration.Statements.Add(new CodeVariableDeclarationStatement(IdentityUserClaim.ClrFullTypeName, "userClaim", new CodePropertyReferenceExpression(new CodeVariableReferenceExpression(toDeleteEnumerator.Name), "Current")));
                toDeleteIteration.Statements.Add(new CodeMethodInvokeExpression(new CodeVariableReferenceExpression("userClaim"), "Delete"));
                toDeleteIteration.Statements.Add(new CodeMethodInvokeExpression(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.ClaimsProperty.Name), "Remove", new CodeVariableReferenceExpression("userClaim")));
            }
        }

        private void CreateRemoveClaimMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "RemoveClaimAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(ClaimFullTypeName, "claim"));

            if (IdentityProducer.TargetVersion == AspNetIdentityVersion.Version1 || IdentityProducer.TargetVersion == AspNetIdentityVersion.Version2)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserClaimStore", false));
                if (CanImplementGenericInterfaces)
                {
                    method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserClaimStore", true));
                }
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("claim"));
            AddRemoveUserClaimFromClaim(method, method.Statements, propertyName => new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("claim"), propertyName));
            method.Statements.Add(CreateEmptyTaskResult());
            type.Members.Add(method);
        }

        private void CreateRemoveClaimsMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "RemoveClaimsAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(CodeDomUtilities.GetGenericType(typeof(IEnumerable<>), ClaimFullTypeName), "claims"));

            if (IdentityProducer.TargetVersion == AspNetIdentityVersion.Version3)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserClaimStore", false));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("claims"));

            var enumerator = new CodeVariableDeclarationStatement(CodeDomUtilities.GetGenericType(typeof(IEnumerator<>), ClaimFullTypeName), "claimEnumerator");
            enumerator.InitExpression = new CodeMethodInvokeExpression(new CodeArgumentReferenceExpression("claims"), "GetEnumerator");

            var iteration = new CodeIterationStatement();
            iteration.InitStatement = enumerator;
            iteration.TestExpression = new CodeMethodInvokeExpression(new CodeVariableReferenceExpression("claimEnumerator"), "MoveNext");
            iteration.IncrementStatement = new CodeSnippetStatement("");
            iteration.Statements.Add(new CodeVariableDeclarationStatement(ClaimFullTypeName, "claim", new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("claimEnumerator"), "Current")));
            method.Statements.Add(iteration);

            AddRemoveUserClaimFromClaim(method, iteration.Statements, propertyName => new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("claim"), propertyName));
            method.Statements.Add(CreateEmptyTaskResult());
            type.Members.Add(method);
        }

        private void CreateReplaceClaimMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            method.ReturnType = CreateTaskTypeReference();
            method.Attributes = MemberAttributes.Public;
            method.Name = "ReplaceClaimAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(ClaimFullTypeName, "oldClaim"));
            method.Parameters.Add(new CodeParameterDeclarationExpression(ClaimFullTypeName, "newClaim"));
            
            if (IdentityProducer.TargetVersion == AspNetIdentityVersion.Version3)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserClaimStore", false));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));
            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("oldClaim"));
            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("newClaim"));

            var userClaimsEnumerator = new CodeVariableDeclarationStatement(CodeDomUtilities.GetGenericType(typeof(IEnumerator<>), IdentityUserClaim.ClrFullTypeName), "enumerator");
            userClaimsEnumerator.InitExpression = new CodeMethodInvokeExpression(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.ClaimsProperty.Name), "GetEnumerator");

            var userClaimsIteration = new CodeIterationStatement();
            userClaimsIteration.InitStatement = userClaimsEnumerator;
            userClaimsIteration.TestExpression = new CodeMethodInvokeExpression(new CodeVariableReferenceExpression("enumerator"), "MoveNext");
            userClaimsIteration.IncrementStatement = new CodeSnippetStatement("");
            method.Statements.Add(userClaimsIteration);

            userClaimsIteration.Statements.Add(new CodeVariableDeclarationStatement(IdentityUserClaim.ClrFullTypeName, "userClaim", new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("enumerator"), "Current")));

            CodeConditionStatement claimsEqual = new CodeConditionStatement();
            userClaimsIteration.Statements.Add(claimsEqual);
            claimsEqual.Condition = CreateStringEqualsExpression(StringComparison.OrdinalIgnoreCase,
                    new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("userClaim"), IdentityUserClaim.TypeProperty.Name),
                    new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("oldClaim"), "Type"));

            if (IdentityUserClaim.ValueProperty.GetAttributeValue("isComparer", Constants.NamespaceUri, true))
            {
                claimsEqual.Condition = new CodeBinaryOperatorExpression(claimsEqual.Condition, CodeBinaryOperatorType.BooleanAnd, CreateStringEqualsExpression(StringComparison.OrdinalIgnoreCase,
                    new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("userClaim"), IdentityUserClaim.ValueProperty.Name),
                    new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("oldClaim"), "Value")));
            }

            if (IdentityUserClaim.ValueTypeProperty != null && IdentityUserClaim.ValueTypeProperty.GetAttributeValue("isComparer", Constants.NamespaceUri, false))
            {
                claimsEqual.Condition = new CodeBinaryOperatorExpression(claimsEqual.Condition, CodeBinaryOperatorType.BooleanAnd,
                    CreateStringEqualsExpression(StringComparison.OrdinalIgnoreCase,
                        new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("userClaim"), IdentityUserClaim.ValueTypeProperty.Name),
                        new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("oldClaim"), "ValueType")));
            }

            if (IdentityUserClaim.IssuerProperty != null && IdentityUserClaim.IssuerProperty.GetAttributeValue("isComparer", Constants.NamespaceUri, false))
            {
                claimsEqual.Condition = new CodeBinaryOperatorExpression(claimsEqual.Condition, CodeBinaryOperatorType.BooleanAnd,
                    CreateStringEqualsExpression(StringComparison.OrdinalIgnoreCase,
                        new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("userClaim"), IdentityUserClaim.IssuerProperty.Name),
                        new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("oldClaim"), "Issuer")));
            }

            if (IdentityUserClaim.OriginalIssuerProperty != null && IdentityUserClaim.OriginalIssuerProperty.GetAttributeValue("isComparer", Constants.NamespaceUri, false))
            {
                claimsEqual.Condition = new CodeBinaryOperatorExpression(claimsEqual.Condition, CodeBinaryOperatorType.BooleanAnd,
                    CreateStringEqualsExpression(StringComparison.OrdinalIgnoreCase,
                        new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("userClaim"), IdentityUserClaim.OriginalIssuerProperty.Name),
                        new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("oldClaim"), "OriginalIssuer")));
            }

            // Replace userClaim properties & Save
            AddSetAndSaveUserClaimFromClaim(
                claimsEqual.TrueStatements, 
                new CodeVariableReferenceExpression("userClaim"), 
                propertyName => new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("newClaim"), propertyName));
            
            method.Statements.Add(CreateEmptyTaskResult());
            type.Members.Add(method);
        }

        private void CreateGetClaimsMethod(CodeTypeDeclaration type)
        {
            CodeMemberMethod method = new CodeMemberMethod();
            var returnType = CreateTaskTypeReference();
            returnType.TypeArguments.Add(CodeDomUtilities.GetGenericType(typeof(IList<>), ClaimFullTypeName));
            method.ReturnType = returnType;
            method.Attributes = MemberAttributes.Public;
            method.Name = "GetClaimsAsync";
            method.Parameters.Add(new CodeParameterDeclarationExpression(IdentityUser.ClrFullTypeName, "user"));

            method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserClaimStore", false));
            if (CanImplementGenericInterfaces)
            {
                method.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IUserClaimStore", true));
            }

            method.Statements.Add(CodeDomUtilities.CreateParameterThrowIfNull("user"));

            method.Statements.Add(new CodeVariableDeclarationStatement(CodeDomUtilities.GetGenericType(typeof(IList<>), ClaimFullTypeName), "result", new CodeObjectCreateExpression(CodeDomUtilities.GetGenericType(typeof(List<>), ClaimFullTypeName))));

            var enumerator = new CodeVariableDeclarationStatement(CodeDomUtilities.GetGenericType(typeof(IEnumerator<>), IdentityUserClaim.ClrFullTypeName), "enumerator");
            enumerator.InitExpression = new CodeMethodInvokeExpression(new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("user"), IdentityUser.ClaimsProperty.Name), "GetEnumerator");

            var iteration = new CodeIterationStatement();
            iteration.InitStatement = enumerator;
            iteration.TestExpression = new CodeMethodInvokeExpression(new CodeVariableReferenceExpression("enumerator"), "MoveNext");
            iteration.IncrementStatement = new CodeSnippetStatement("");

            iteration.Statements.Add(new CodeVariableDeclarationStatement(IdentityUserClaim.ClrFullTypeName, "userClaim", new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("enumerator"), "Current")));
            var createExpression = new CodeObjectCreateExpression(ClaimFullTypeName);

            if (IdentityUserClaim.OriginalIssuerProperty != null)
            {
                createExpression.Parameters.Insert(0, new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("userClaim"), IdentityUserClaim.OriginalIssuerProperty.Name));
            }

            if (IdentityUserClaim.IssuerProperty != null)
            {
                createExpression.Parameters.Insert(0, new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("userClaim"), IdentityUserClaim.IssuerProperty.Name));
            }
            else if (createExpression.Parameters.Count > 0)
            {
                createExpression.Parameters.Insert(0, createExpression.Parameters[0]); // OriginalIssuer
            }

            if (IdentityUserClaim.ValueTypeProperty != null)
            {
                createExpression.Parameters.Insert(0, new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("userClaim"), IdentityUserClaim.ValueTypeProperty.Name));
            }
            else if (createExpression.Parameters.Count > 0)
            {
                createExpression.Parameters.Insert(0, new CodeFieldReferenceExpression(new CodeTypeReferenceExpression(ClaimValueTypesFullTypeName), "String"));
            }

            createExpression.Parameters.Insert(0, new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("userClaim"), IdentityUserClaim.ValueProperty.Name));
            createExpression.Parameters.Insert(0, new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("userClaim"), IdentityUserClaim.TypeProperty.Name));

            iteration.Statements.Add(
                new CodeMethodInvokeExpression(
                    new CodeVariableReferenceExpression("result"), "Add",
                    createExpression));
            method.Statements.Add(iteration);

            method.Statements.Add(CreateTaskResult(new CodeVariableReferenceExpression("result")));
            type.Members.Add(method);
        }

        private void ImplementIQueryableUserStore(CodeTypeDeclaration type)
        {
            if (!CanImplementQueryableUserStore)
                return;

            type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IQueryableUserStore", false));
            if (CanImplementGenericInterfaces)
            {
                type.BaseTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IQueryableUserStore", true));
            }

            CreateUsersProperty(type);
        }

        private void CreateUsersProperty(CodeTypeDeclaration type)
        {
            CodeMemberProperty property = new CodeMemberProperty();
            property.Type = CodeDomUtilities.GetGenericType(typeof(IQueryable), IdentityUser.ClrFullTypeName);
            property.Attributes = MemberAttributes.Public;
            property.Name = "Users";
            property.HasSet = false;
            property.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IQueryableUserStore", false));
            if (CanImplementGenericInterfaces)
            {
                property.ImplementationTypes.Add(GetGenericInterfaceType("Microsoft.AspNet.Identity.IQueryableUserStore", true));
            }

            if (IdentityRole.LoadAllMethod != null)
            {
                property.GetStatements.Add(
                    new CodeMethodReturnStatement(
                        new CodeMethodInvokeExpression(new CodeTypeReferenceExpression(typeof(Queryable)), "AsQueryable",
                            CreateMethodInvokeExpression(IdentityUser.Entity, IdentityUser.LoadAllMethod))));
            }
            else
            {
                property.GetStatements.Add(CreateThrowInvalidOperationException());
            }

            type.Members.Add(property);
        }
    }
}