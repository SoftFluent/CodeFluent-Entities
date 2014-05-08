using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace SoftFluent.Samples.GED.Utility.Misc
{
    public class Log
    {
        public static void Write(string p, string l)
        {
            if (!System.IO.File.Exists(p))
            {
                System.IO.File.WriteAllText(p, string.Empty);
            }
            using (var f = System.IO.File.Open(p, System.IO.FileMode.Append))
            {
                foreach (byte b in Encoding.ASCII.GetBytes("\n"))
                {
                    f.WriteByte(b);
                }
                foreach (byte b in Encoding.ASCII.GetBytes(string.Format("{0} : {1}", DateTime.Now.ToString(), l)))
                {
                    f.WriteByte(b);
                }
                f.Close();
            }
        }
    }
}
