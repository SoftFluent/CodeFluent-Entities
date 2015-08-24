using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoftFluent.Samples.EncryptAspect
{
    public class PassPhrase
    {
        public static string GetPassPhrase()
        {
            return "Pa$$w0rd";
        }
    }


    class Program
    {
        static void Main(string[] args)
        {
            Customer customer = new Customer();
            customer.Name = "John Doe";
            customer.CardNumber = "1234-1234-1234-1234";
            customer.Save();

            Console.WriteLine(Customer.Load(customer.Id).Trace());
        }
    }
}
