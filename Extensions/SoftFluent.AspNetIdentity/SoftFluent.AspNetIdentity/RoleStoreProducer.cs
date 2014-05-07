using System;
using System.Collections;
using CodeFluent.Model;
using CodeFluent.Model.Common.Templating;
using CodeFluent.Producers.CodeDom;
using CodeFluent.Runtime.Utilities;

namespace SoftFluent.AspNetIdentity
{
    public class RoleStoreProducer : SimpleTemplateProducer
    {
        private readonly AspNetIdentityProducer _aspNetIdentityProducer;
        private readonly IdentityRole _identityRole;

        public IdentityRole IdentityRole
        {
            get { return _identityRole; }
        }

        public RoleStoreProducer(CodeDomBaseProducer codeDomBaseProducer, AspNetIdentityProducer aspNetIdentityProducer, IdentityRole identityRole)
            : base(codeDomBaseProducer)
        {
            if (aspNetIdentityProducer == null) throw new ArgumentNullException("aspNetIdentityProducer");
            if (identityRole == null) throw new ArgumentNullException("identityRole");

            _aspNetIdentityProducer = aspNetIdentityProducer;
            _identityRole = identityRole;
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
            get { return "RoleStore"; }
        }

        protected override Template CreateTemplate()
        {
            var template = base.CreateTemplate();

            template.AddReferenceDirective(typeof(CodeDomBaseProducer));
            template.AddReferenceDirective(typeof(UserStoreProducer));

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



        public bool CanImplementRoleStore
        {
            get
            {
                return IdentityRole != null && IdentityRole.NameProperty != null;
            }
        }

        public bool CanImplementQueryableRoleStore
        {
            get { return _aspNetIdentityProducer.MustImplementQueryableRoleStore && CanImplementRoleStore; }
        }
    }
}