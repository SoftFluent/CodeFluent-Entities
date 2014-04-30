using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeFluent.Runtime;
using CodeFluent.Runtime.Utilities;
using CodeFluent.Runtime.Web.UI.WebControls;
using ContactManager.Web;

namespace ContactManager.Web
{
    public partial class UserForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
			string formName = Utilities.GetFormName(HttpContext.Current);
			switch(formName)
			{
				
				case "default":
					defaultForm.Visible = true;
					break;
				
				default:
					
					defaultForm.Visible = true;
					
					break;
			}
        }
		
		protected void OnItemInserted(object sender, FormViewInsertedEventArgs e)
		{
            if (e.Exception == null)
            {
                Utilities.WriteWindowClose();
            }
            else
            {
                Utilities.OnError(Page, false, e.Exception);
                e.KeepInInsertMode = true;
                e.ExceptionHandled = true;
            }
        }

		protected void OnItemUpdated(object sender, FormViewUpdatedEventArgs e)
		{
            if (e.Exception == null)
            {
                Utilities.WriteWindowClose();
            }
            else
            {
                Utilities.OnError(Page, false, e.Exception);
                e.KeepInEditMode = true;
                e.ExceptionHandled = true;
            }
        }
    }
}
