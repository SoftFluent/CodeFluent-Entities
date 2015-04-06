using System.Linq;

namespace SoftFluent.AspNetIdentity
{
    public static class Utilities
    {
        public static bool IsNullOrWhiteSpace(string str)
        {
            if (str == null)
                return true;

            return str.All(char.IsWhiteSpace);
        }
    }
}
