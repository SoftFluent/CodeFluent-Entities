using System;
using System.Collections;
using CodeFluent.Model;
using CodeFluent.Model.Code;
using CodeFluent.Model.Common.Templating;
using CodeFluent.Producers.CodeDom;
using CodeFluent.Runtime.Utilities;

namespace SoftFluent.AspNetIdentity
{
    public class UserStoreProducer : SimpleTemplateProducer
    {
        private readonly AspNetIdentityProducer _aspNetIdentityProducer;
        private readonly IdentityUser _identityUser;
        private readonly IdentityRole _identityRole;
        private readonly IdentityLogin _identityLogin;
        private readonly IdentityClaim _identityClaim;

        public UserStoreProducer(
            CodeDomBaseProducer codeDomBaseProducer,
            AspNetIdentityProducer aspNetIdentityProducer,
            IdentityUser identityUser,
            IdentityRole identityRole,
            IdentityLogin identityLogin,
            IdentityClaim identityClaim)
            : base(codeDomBaseProducer)
        {
            if (aspNetIdentityProducer == null) throw new ArgumentNullException("aspNetIdentityProducer");
            if (identityUser == null) throw new ArgumentNullException("identityUser");

            _aspNetIdentityProducer = aspNetIdentityProducer;
            _identityUser = identityUser;
            _identityRole = identityRole;
            _identityLogin = identityLogin;
            _identityClaim = identityClaim;
        }

        public IdentityLogin IdentityLogin
        {
            get { return _identityLogin; }
        }

        public IdentityClaim IdentityClaim
        {
            get { return _identityClaim; }
        }

        public IdentityRole IdentityRole
        {
            get { return _identityRole; }
        }

        public IdentityUser IdentityUser
        {
            get { return _identityUser; }
        }

        protected override bool RaiseProducing(IDictionary dictionary)
        {
            return true;
        }

        protected override void RaiseProduced()
        {
        }

        public override bool IsWebType
        {
            get { return true; }
        }

        protected override string DefaultNamespace
        {
            get { return Producer.Project.DefaultNamespace + Producer.WebNamespaceSuffix + ".Security"; }
        }

        protected override string DefaultTypeName
        {
            get { return "UserStore"; }
        }

        protected override Template CreateTemplate()
        {
            var template = base.CreateTemplate();

            template.AddReferenceDirective(typeof(CodeDomBaseProducer));
            template.AddReferenceDirective(typeof(UserStoreProducer));
            template.AddNamespaceDirective(typeof(Func<>));
            template.AddNamespaceDirective(typeof(Method));

            return template;
        }

        public override string TargetPath
        {
            get
            {
                string path = ConvertUtilities.Nullify(XmlUtilities.GetAttribute(Producer.Element, ConvertUtilities.Camel(this.TargetName) + "TargetPath", (string)null), true);
                if (path == null)
                    return BaseType.GetFilePath(Producer.TargetBaseNamespace, TypeName, Namespace, Producer.FullTargetDirectory, null);

                return Producer.GetFullRelativeDirectoryPath(path);
            }
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
                return IdentityUser != null && IdentityUser.LockoutEndDateProperty != null;
            }
        }

        public bool CanImplementEmailStore
        {
            get
            {
                return IdentityUser != null && IdentityUser.EmailProperty != null;
            }
        }

        public bool CanImplementPhoneNumberStore
        {
            get
            {
                return IdentityUser != null && IdentityUser.PhoneNumberProperty != null;
            }
        }

        public bool CanImplementTwoFactorStore
        {
            get
            {
                return IdentityUser != null && IdentityUser.TwoFactorEnabledProperty != null;
            }
        }

        public bool CanImplementRoleStore
        {
            get
            {
                return IdentityUser != null && IdentityUser.RolesProperty != null && IdentityRole != null;
            }
        }

        public bool CanImplementLoginStore
        {
            get
            {
                return IdentityUser != null && IdentityUser.LoginsProperty != null && IdentityLogin != null && IdentityLogin.ProviderKeyProperty != null;
            }
        }

        public bool CanImplementClaimsStore
        {
            get
            {
                return IdentityClaim != null && IdentityUser != null && IdentityUser.ClaimsProperty != null;
            }
        }

        public bool CanImplementQueryableUserStore
        {
            get { return _aspNetIdentityProducer.MustImplementQueryableUserStore && CanImplementUserStore; }
        }
    }
}