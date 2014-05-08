using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SoftFluent.Samples.GED;
using SoftFluent.Samples.GED.Security;

namespace SoftFluent.Samples.GED.Web.Class
{
    public class BaseController : Controller
    {
        private User _user;

        public User UserEntity
        {
            get
            {
                if (_user == null)
                {
                    _user = SoftFluent.Samples.GED.Security.User.LoadByUserName(base.User.Identity.Name);
                }

                return _user;
            }
        }
        public Guid UserId
        {
            get
            {
                if (_user == null)
                {
                    _user = SoftFluent.Samples.GED.Security.User.LoadByUserName(base.User.Identity.Name);
                }

                return _user.Id;
            }
        }
        public string UserPassword
        {
            get
            {
                return (string)Session["UserPassword"];
            }
            set
            {
                Session["UserPassword"] = value;
            }
        }

        public void InitPagination(string url, int current, int count)
        {
            ViewBag.Pagination = true;
            ViewBag.PaginationUrl = url;
            ViewBag.PaginationCurrent = current;
            ViewBag.PaginationTotal = count / Utility.Misc.Constants.itemByPage;
        }

        protected override void Initialize(System.Web.Routing.RequestContext requestContext)
        {
            base.Initialize(requestContext);

            if (UserPassword == null)
            {
                Response.Redirect("~/Account/LogOn");
            }
        }
    }
}