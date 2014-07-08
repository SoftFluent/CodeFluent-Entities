using CodeFluent.Runtime;
using CodeFluent.Runtime.Utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace SoftFluent.Samples.StoreEnumAsText
{
    class Program
    {
        static void Main()
        {
            Sample sample = new Sample();
            sample.Gender = Gender.Female;
            sample.Day = Day.Monday | Day.Thursday;
            sample.Save();

            sample.Reload(CodeFluent.Runtime.CodeFluentReloadOptions.Default);
            Console.WriteLine(sample.Trace());
        }
    }

    // Only needed when using CodeFluent.Runtime < 772
    //public static class PersistenceExtensions
    //{
    //    public static IDbDataParameter AddParameterAsText(this CodeFluent.Runtime.CodeFluentPersistence persistence, string name, Enum value, Enum defaultValue)
    //    {
    //        if (name == null)
    //            throw new ArgumentNullException("name");

    //        return persistence.AddParameter(name, ConvertUtilities.ChangeType<string>(value), ConvertUtilities.ChangeType<string>(defaultValue));
    //    }
    //}
}
