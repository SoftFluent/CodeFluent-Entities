using CodeFluent.Runtime.Caching;
using CodeFluent.Runtime.Utilities;
using Microsoft.ApplicationServer.Caching;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;

namespace SoftFluent.Samples.AzureCache
{
    class Program
    {
        static void Main(string[] args)
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
