using System.ComponentModel;
using System.Management.Automation;

namespace CodeFluentEntitiesCmdlet
{
    [RunInstaller(true)]
    public class CodeFluentEntitiesCmdletPSSnapIn01 : PSSnapIn
    {
        public CodeFluentEntitiesCmdletPSSnapIn01()
            : base() { }

        public override string Name
        {
            get { return ((object)this).GetType().Name; }
        }

        public override string Vendor
        {
            get { return "SoftFluent"; }
        }

        public override string VendorResource
        {
            get { return string.Format("{0},{1}", Name, Vendor); }
        }

        public override string Description
        {
            get { return "This is a PowerShell snap-in that includes Update-CFEDatabases cmdlet."; }
        }

        public override string DescriptionResource
        {
            get { return string.Format("{0},{1}", Name, Description); }
        }
    }
}
