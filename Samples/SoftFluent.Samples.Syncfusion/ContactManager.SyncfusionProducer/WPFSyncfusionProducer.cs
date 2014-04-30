using CodeFluent.Model.Common.Design;
using CodeFluent.Model.Design;
using CodeFluent.Producers.CodeDom;
using CodeFluent.Producers.UI;
using CodeFluent.Runtime.Utilities;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing.Design;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ContactManager.SyncfusionProducer
{
    [DisplayName("Syncfusion WPF"), Category("Syncfusion producers"), Producer("http://www.softfluent.com/codefluent/producers.aspnet/2011/1", "cfasp")]
    public class WPFSyncfusionProducer : UIProducer
    {
        public WPFSyncfusionProducer()
        {

        }

        protected override string DefaultCategoryPath
        {
            get
            {
                return ("SyncfusionWPF");
            }
        }

        protected override string NamespaceUri
        {
            get
            {
                return "http://www.softfluent.com/codefluent/producers.syncfusion/2011/1";
            }
        }

        [Description("Defines the root directory that contains templates sub directories. If left empty, the standard templates directory will be used."), Editor(typeof(FolderNameEditor), typeof(UITypeEditor)), Category("Configuration"), DisplayName("Templates Directory Path"), EditorBrowsable(EditorBrowsableState.Never), DefaultValue((string)null), ModelLevel(ModelLevel.Normal)]
        public override string EditorTemplatesPath
        {
            get
            {
                string path = ConvertUtilities.Nullify(XmlUtilities.GetAttribute<string>(this.Element, "templatesPath", null), true);
                if (path == null)
                {
                    return null;
                }
                if (!Path.IsPathRooted(path) && base.IsTargetRelativeToModelDirectory)
                {
                    return Path.GetFullPath(Path.Combine(base.Project.Package.DirectoryPath, path));
                }
                return path;
            }
            set
            {
                if ((base.IsTargetRelativeToModelDirectory && (value != null)) && Path.IsPathRooted(value))
                {
                    value = base.Project.Package.GetPortableRelativeDirectoryPath(value);
                }
                if (value != this.EditorTemplatesPath)
                {
                    XmlUtilities.SetAttribute(base.Element, "templatesPath", value);
                }
            }
        }


        public override void Produce()
        {
            base.Produce();

            Dictionary<string, string> context = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
            context["$clrversion$"] = Environment.Version.ToString();
            for (int i = 1; i <= 10; i++)
            {
                context["$guid" + i + "$"] = Guid.NewGuid().ToString();
            }
            context["$itemname$"] = base.Project.DefaultNamespace;
            context["$machinename$"] = Environment.MachineName;
            context["$projectname$"] = this.SyncfusionWPFAssemblyNamespace;
            context["$registeredorganization$"] = ConvertUtilities.RegisteredOrganization;
            context["$rootnamespace$"] = this.SyncfusionWPFAssemblyNamespace;
            context["$safeitemname$"] = base.Project.DefaultNamespace;
            context["$safeprojectname$"] = this.SyncfusionWPFAssemblyNamespace;
            context["$time$"] = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
            context["$userdomain$"] = Environment.UserDomainName;
            context["$username$"] = Environment.UserName;
            context["$webnamespace$"] = this.SyncfusionWPFAssemblyNamespace;
            context["$year$"] = DateTime.Now.Year.ToString("0000");

            foreach (string sourceDirectory in this.GetFullSourceDirectories(this.CategoryPath, false))
            {
                BaseProducer.TransformAllFiles(this, this.FullTargetDirectory, sourceDirectory, context, new BaseProducer.TransformCallback(this.TransformFile));
            }
        }

        public virtual string SyncfusionWPFAssemblyNamespace
        {
            get
            {
                string format = XmlUtilities.GetAttribute<string>(this.Element, "syncfusionWPFAssemblyNamespace", null);
                if (format == null)
                {
                    format = "{0}.WPFSyncfusion";
                }
                if (base.Project == null)
                {
                    return format;
                }
                return string.Format(format, base.Project.DefaultNamespace);
            }
            set
            {
                XmlUtilities.SetAttribute(this.Element, "syncfusionWPFAssemblyNamespace", value);
            }

        }

        protected virtual bool TransformFile(BaseProducer producer, string source, string target, IDictionary context)
        {
            if ((source != null) && source.Contains("cf_template.xml"))
            {
                return false;
            }
            return true;
        }
    }
}
