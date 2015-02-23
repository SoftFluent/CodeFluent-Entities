using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace SoftFluent.Json.NET
{
    class Program
    {
        static void Main(string[] args)
        {
            Customer customer = new Customer();
            customer.Name = "John Doe";
            customer.Phone = "(704) 494-3332";
            customer.Address = "759 High Street";
            customer.City = "Marietta";
            customer.ZipCode = "30008";
            customer.Country = "US";
            customer.WebSite = "http://www.softfluent.com";

            Console.WriteLine(JsonConvert.SerializeObject(customer));
        }
    }
}
