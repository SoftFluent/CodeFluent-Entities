using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoftFluent.Samples.ReadOnLoad
{
    class Program
    {
        static void Main()
        {
            Customer customer = new Customer();
            customer.Name = "John Doe";
            customer.Save();
        }
    }
}
