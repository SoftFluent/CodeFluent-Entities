using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoftFluent.Samples.AspNetIdentity2
{
    partial class User : Microsoft.AspNet.Identity.IUser<System.Guid>, Microsoft.AspNet.Identity.IUser
    {
        System.Guid Microsoft.AspNet.Identity.IUser<System.Guid>.Id
        {
            get
            {
                return this.Id;
            }
        }

        string Microsoft.AspNet.Identity.IUser<System.Guid>.UserName
        {
            get
            {
                return this.UserName;
            }
            set
            {
                this.UserName = value;
            }
        }

        string Microsoft.AspNet.Identity.IUser<string>.Id
        {
            get
            {
                return this.EntityKey;
            }
        }

        string Microsoft.AspNet.Identity.IUser<string>.UserName
        {
            get
            {
                return this.UserName;
            }
            set
            {
                this.UserName = value;
            }
        }
    }
}
