using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ContactManager.Web
{
    public partial class AddressLoadAllDefaultForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            FreeForm.Command += OnFreeFormCommand;
        }

        private void OnFreeFormCommand(object sender, CommandEventArgs e)
        {
            Utilities.WriteWindowClose(FreeForm);
        }
      
        public new object Eval(string expression)
        {
            return null;
        }

        public new string Eval(string expression, string format)
        {
            return null;
        }

        public T Eval<T>(string expression, T format)
        {
            return default(T);
        }
    }
}
