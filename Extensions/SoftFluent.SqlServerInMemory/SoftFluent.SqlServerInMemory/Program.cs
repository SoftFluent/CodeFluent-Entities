using CodeFluent.Runtime;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoftFluent.SqlServerInMemory
{
    class Program
    {
        static void Main(string[] args)
        {
            Customer customer = new Customer();
            customer.Name = "John Doe";
            customer.Save();

            //customer.Reload(CodeFluentReloadOptions.Default);

            Console.WriteLine(customer.Trace());

            foreach (var c in CustomerCollection.LoadAll())
            {
                Console.WriteLine(c.Trace());
            }
        }
    }
}
