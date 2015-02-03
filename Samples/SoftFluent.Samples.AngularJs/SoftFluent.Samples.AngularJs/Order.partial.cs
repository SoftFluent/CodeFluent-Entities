using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CodeFluent.Runtime;
using SoftFluent.Samples.AngularJs.ReferenceData;

namespace SoftFluent.Samples.AngularJs
{
    public partial class Order
    {
        private void OnBeforeSave()
        {
            Date = DateTime.Now;
            if (Customer != null)
            {
                Customer.Save();
            }
           
                this.SaveProductsRelations();
                
        }
    }
}
