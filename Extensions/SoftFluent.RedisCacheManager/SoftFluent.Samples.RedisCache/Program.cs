using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoftFluent.Samples.RedisCache.Caching;
using StackExchange.Redis;
using CodeFluent.Runtime.Caching;
using System.Net;
using CodeFluent.Runtime;
using CodeFluent.Runtime.Utilities;
using System.Data;
using System.Threading;

namespace SoftFluent.Samples.RedisCache
{
    class Program
    {
        static void Main()
        {
            ConvertUtilities.SetCurrentThreadCulture("en-US");
            Category category = new Category();
            category.Name = "EN: High-Tech";
            category.Save();
            Category.SaveLocalizedValues(category, 1036, false, "FR: High-Tech");

            Product product = new Product();
            product.Name = "Phone";
            product.Category = category;
            product.Save();

            Console.WriteLine(Product.LoadById(product.Id).Name);
            Console.WriteLine(Product.LoadById(product.Id).Name);

            ConvertUtilities.SetCurrentThreadCulture(1036);
            Console.WriteLine(Category.Load(category.Id).Name);
            Console.WriteLine(Category.Load(category.Id).Name);
            ConvertUtilities.SetCurrentThreadCulture(1033);
            Console.WriteLine(Category.Load(category.Id).Name);
            Console.WriteLine(Category.Load(category.Id).Name);
        }
    }
}
