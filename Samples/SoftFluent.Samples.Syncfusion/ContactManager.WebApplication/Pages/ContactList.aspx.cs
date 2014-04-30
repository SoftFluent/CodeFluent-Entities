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
    public partial class ContactList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
			string viewName = Utilities.GetViewName(HttpContext.Current);
			switch(viewName)
			{
				
				case "default":
					defaultGrid.DataSourceID = "DataSource";
					break;
				
				case "myview":
					MyViewGrid.DataSourceID = "DataSource";
					break;
				
				default:
					
					defaultGrid.DataSourceID = "DataSource";
					
					break;
			}
        }
        
        protected void Page_PreRender(object sender, EventArgs e)
		{
			ClientScript.GetPostBackEventReference(new Literal(), string.Empty);
		}
		
		protected void OnError(object sender, EntityDataSourceErrorEventArgs e)
		{
			e.Handled = true;
			
            CodeFluentCoercionException cce = e.Error as CodeFluentCoercionException;
            if (cce != null)
            {
                string rawResult = string.Format("Raw result: {0}", cce.Value);
                string viewName = Utilities.GetViewName(HttpContext.Current);
                switch (viewName)
                {
					
					case "default":
						defaultGrid.EmptyDataText = rawResult;
						break;
					
					case "myview":
						MyViewGrid.EmptyDataText = rawResult;
						break;
					
					default:
						
						defaultGrid.EmptyDataText = rawResult;
						
						break;
                }
                return;
            }
            
			if (e.ExpectedResultType == typeof(IEnumerable)) // Select
			{
				e.Result = new CodeFluentSet();
			}
			else
			{
				e.Result = 0;
			}
		
            Utilities.OnError(Page, false, e.Error);
		}
    }
}
