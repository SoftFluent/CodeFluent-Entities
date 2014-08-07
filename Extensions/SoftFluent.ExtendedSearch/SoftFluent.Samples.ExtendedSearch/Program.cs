using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoftFluent.Samples.ExtendedSearch
{
    class Program
    {
        static void Main(string[] args)
        {
            var collection = CustomerCollection.Search(
                "John", FilterFunctions.Contains | FilterFunctions.IsLessThan, 
                new DateTime(2014, 1, 1), FilterFunctions.IsLessThan);

            foreach (var item in collection)
            {
                Console.WriteLine(item.Trace());
            }
        }
    }
}
