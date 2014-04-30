using System;
using System.Collections;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeFluent.Runtime;
using CodeFluent.Runtime.Utilities;
using CodeFluent.Runtime.Web.UI.WebControls;

namespace ContactManager.Web
{
    public partial class Utilities
    {
        public static string GetViewName(HttpContext context)
        {
            if (context == null)
                return null; ;

            string viewName = ConvertUtilities.Nullify(context.Request["view"], true);
            if (viewName == null)
                return null;

            return viewName.ToLowerInvariant();
        }

        public static string GetFormName(HttpContext context)
        {
            if (context == null)
                return null; ;

            string formName = ConvertUtilities.Nullify(context.Request["form"], true);
            if (formName == null)
                return null;

            return formName.ToLowerInvariant();
        }

        public static void WriteWindowClose(FreeFormView freeForm)
        {
            HttpContext.Current.Response.Write("<script language='javascript'>");
            if ((freeForm != null) && (freeForm.Values.Count > 0))
            {
                HttpContext.Current.Response.Write("var _v='");
                int i = 0;
                foreach (DictionaryEntry entry in freeForm.Values)
                {
                    string key = entry.Key as string;
                    if (key == null)
                        continue;
                        
                    if (i > 0)
                    {
						HttpContext.Current.Response.Write('&');
                    }

                    HttpContext.Current.Response.Write("_p_");
                    HttpContext.Current.Response.Write(ConvertUtilities.EscapeJavascript(key));
                    HttpContext.Current.Response.Write('=');
                    HttpContext.Current.Response.Write(ConvertUtilities.EscapeJavascript(string.Format("{0}", entry.Value)));
                    i++;
                }
                HttpContext.Current.Response.Write("';if(window.opener)window.opener.returnValue=_v;window.returnValue=_v;");
            }
            HttpContext.Current.Response.Write("window.close();</script>");
            HttpContext.Current.Response.End();
        }

        public static void WriteWindowClose()
        {
            WriteWindowClose(null);
        }

        public static void OnError(Page page, Exception e)
        {
			OnError(page, true, e);
        }

        private static bool? _showErrorsFullStack;
        public static bool ShowErrorsFullStack
        {
            get
            {
                if (!_showErrorsFullStack.HasValue)
                {
                    _showErrorsFullStack = ConvertUtilities.ChangeType(ConfigurationManager.AppSettings["showErrorsFullStack"], false);
                }
                return _showErrorsFullStack.Value;
            }
        }
        
        public static void OnError(Page page, bool fullStack, Exception e)
        {
	        if ((page == null) || (e == null))
				return;
				
			Control error = page.Master.FindControl("Error");
			if (error != null)
			{
				error.Visible = true;
			}
			
			error = page.Master.FindControl("ErrorText");
			if (error != null)
			{
				Literal literal = new Literal();
				if (fullStack || ShowErrorsFullStack)
				{
					literal.Text = e.ToString() + Environment.NewLine + Environment.NewLine;
				}
				else
				{
					literal.Text = CodeFluentRuntimeException.GetAllMessages(e, "<br />") + Environment.NewLine + Environment.NewLine;
				}
				error.Controls.Add(literal);
			}
        }
    }
}