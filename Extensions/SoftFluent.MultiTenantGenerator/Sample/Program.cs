using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CodeFluent.Runtime;

namespace Sample
{
    class Program
    {
        static void Main(string[] args)
        {
            CustomerCollection.LoadAll();
        }
    }

    // This PersistenceHook is not thread-safe.
    // By default there is one instance of PersistenceHook by thread, so it's OK.
    public class SchemaPersistenceHook : BasePersistenceHook
    {
        private bool _processing = false;
        public override bool BeforeCreateStoredProcedureCommand(string schema, string package, string intraPackageName, string name)
        {
            if (_processing)
                return false;

            _processing = true;
            try
            {
                string currentSchema = GetTenantName();
                Persistence.CreateStoredProcedureCommand(currentSchema, package, intraPackageName, name);
            }
            finally
            {
                _processing = false;
            }

            return true;
        }

        public virtual string GetTenantName()
        {
            // Implement your own logic
            return CodeFluentUser.Current.UserDomainName;
        }
    }
}
