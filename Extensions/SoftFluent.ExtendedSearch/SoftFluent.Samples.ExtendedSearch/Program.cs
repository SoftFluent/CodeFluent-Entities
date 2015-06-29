using System;

namespace SoftFluent.Samples.ExtendedSearch
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("CustomerCollection.Search");
            var collection = CustomerCollection.Search(
                "John", FilterFunctions.Contains | FilterFunctions.IsLessThan,
                new DateTime(1986, 1, 1), FilterFunctions.IsLessThan);

            foreach (var item in collection)
            {
                Console.WriteLine(item.Trace());
            }

            Console.WriteLine("");
            Console.WriteLine("CustomerCollection.SearchFromView");
            var collection2 = CustomerCollection.SearchFromView(
                "John", FilterFunctions.Contains | FilterFunctions.IsLessThan,
                new DateTime(1986, 1, 1), FilterFunctions.IsLessThan);

            foreach (var item in collection2)
            {
                Console.WriteLine(item.FullName);
            }
        }
    }
}
