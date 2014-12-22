using System.ComponentModel;
using System.Drawing.Design;
using CodeFluent.Runtime.Design;

namespace SoftFluent.AspNetIdentity
{
    [Editor(typeof(EnumEditor), typeof(UITypeEditor))]
    public enum AspNetIdentityVersion
    {
        [Description("ASP.NET Identity 1")]
        Version1,
        [Description("ASP.NET Identity 2")]
        Version2,
        [Browsable(false)]
        [Description("ASP.NET Identity 3 (Preview)")]
        Version3,
    }
}
