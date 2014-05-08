using SoftFluent.Samples.GED.Web.Class;
using System;
using System.Web.Mvc;

namespace SoftFluent.Samples.GED.Web.Controllers
{
    public class DirectoryController : BaseController
    {
        //
        // GET: /Directory/

        public ActionResult Index(int p = 0)
        {
            ViewBag.Title = "Gestion des dossiers";
            ViewBag.Pagination = true;
            ViewBag.PaginationUrl = string.Format("{0}?p=", Request.Path);
            ViewBag.PaginationCurrent = p;
            ViewBag.PaginationTotal = DirectoryCollection.LoadByUserCount(SoftFluent.Samples.GED.Security.User.LoadByUserName(User.Identity.Name)) / 50;

            return View(DirectoryCollection.PageLoadByUser(0, 50, null, SoftFluent.Samples.GED.Security.User.LoadByUserName(User.Identity.Name)));
        }

        //
        // GET: /Directory/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /Directory/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /Directory/Create

        [HttpPost]
        public ActionResult Create(Directory dir)
        {
            try
            {
                dir.User = SoftFluent.Samples.GED.Security.User.LoadByUserName(User.Identity.Name);
                dir.Save();

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /Directory/Edit/5

        public ActionResult Edit(string id)
        {
            return View(SoftFluent.Samples.GED.Directory.Load(Guid.Parse(id)));
        }

        //
        // POST: /Directory/Edit/5

        [HttpPost]
        public ActionResult Edit(Directory dir)
        {
            try
            {
                dir.Save();

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /Directory/Delete/5

        public ActionResult Delete(string id)
        {
            try
            {
                // TODO: Add delete logic here
                Directory dir = Directory.Load(Guid.Parse(id));
                dir.Delete();

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
