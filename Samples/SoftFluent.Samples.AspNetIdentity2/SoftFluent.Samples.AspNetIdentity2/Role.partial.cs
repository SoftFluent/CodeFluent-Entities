using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoftFluent.Samples.AspNetIdentity2
{
    partial class Role
    {
        System.Guid Microsoft.AspNet.Identity.IRole<System.Guid>.Id
        {
            get
            {
                return this.Id;
            }
        }

        string Microsoft.AspNet.Identity.IRole<System.Guid>.Name
        {
            get
            {
                return this.Name;
            }
            set
            {
                this.Name = value;
            }
        }

        string Microsoft.AspNet.Identity.IRole<string>.Id
        {
            get
            {
                return this.EntityKey;
            }
        }

        string Microsoft.AspNet.Identity.IRole<string>.Name
        {
            get
            {
                return this.Name;
            }
            set
            {
                this.Name = value;
            }
        }
    }
}
