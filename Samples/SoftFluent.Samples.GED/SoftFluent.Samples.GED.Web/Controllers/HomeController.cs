using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Text;
using SoftFluent.Samples.GED;
using SoftFluent.Samples.GED.Web.Class;

namespace SoftFluent.Samples.GED.Web.Controllers
{
    public class HomeController : BaseController
    {
        public ActionResult Email(Guid id, string emailTo)
        {
            Document document = Document.Load(id);

            string subject = "SoftFluent.Samples.GED - Partage de fichier de " + UserEntity.UserName;
            StringBuilder bodyBuilder = new StringBuilder();
            bodyBuilder.AppendLine("Veuillez trouver le fichier " + document.Title + " ci-joint.");
            bodyBuilder.AppendLine("");
            bodyBuilder.AppendLine("Le texte ci-dessous à été récupéré à partir du document en pièce jointe :");
            bodyBuilder.AppendLine(document.Text);

            SoftFluent.Samples.GED.Utility.Misc.Email.SendMail(emailTo, subject, bodyBuilder.ToString(), document.Id.ToString(), new List<Stream>() { new MemoryStream(Utility.Image.PDFManager.CreatePdf(UserPassword, Server.MapPath(Utility.Misc.Constants.pageDirectory), document.Pages)) });
            return new HttpStatusCodeResult(200);
        }

        public ActionResult Download(Guid id)
        {
            Document document = Document.Load(id);

            return new FileContentResult(Utility.Image.PDFManager.CreatePdf(UserPassword, Server.MapPath(Utility.Misc.Constants.pageDirectory), document.Pages), "application/pdf");
        }

        public ActionResult Update(Guid id)
        {
            ViewBag.Title = "Intégration";
            ViewBag.Message = "Modifier un fichier";

            Document document = Document.Load(id);

            return View(document);
        }
        [HttpPost]
        public ActionResult Update(Document model)
        {
            Document document = Document.Load(model.Id);
            //if (model.RowVersion != document.RowVersion)
            //{
            //    return Json(new { success = false, mesage = "Le document a été édité par un autre processus. Veuillez recharger le document avant de valider votre modification." });
            //}

            document.DirectoryId = model.DirectoryId;
            document.Title = model.Title;
            document.Reference = model.Reference;
            document.Text = model.Text;

            document.Save();

            return Redirect("Directory/?id=" + document.DirectoryId.ToString());
        }
        [HttpPost]
        public ActionResult Delete(Guid id)
        {
            Document doc = Document.Load(id);
            doc.Delete();
            return new HttpStatusCodeResult(200);
        }
        [HttpPost]
        public ActionResult DeletePage(Guid id)
        {
            Page p = Page.Load(id);
            p.Delete();
            return new HttpStatusCodeResult(200);
        }

        #region " Image "

        [HttpGet]
        public ActionResult GetFile(Guid id)
        {
            Page page = Page.Load(id);

            string filePath = Path.Combine(Server.MapPath(Utility.Misc.Constants.pageDirectory), page.Filename);
            string fileType = "image/jpg";

            return File(Utility.Security.AES.DecryptFile(Utility.Security.AES.GetToken(page.Id, UserPassword), filePath), fileType);
        }
        [HttpGet]
        public ActionResult GetPages(Guid id)
        {
            Document document = Document.Load(id);

            return Json(new { ids = document.Pages.Select(p => p.Id) }, JsonRequestBehavior.AllowGet);
        }
        [HttpGet]
        public ActionResult GetFileThumb(Guid id)
        {
            Document doc = Document.Load(id);

            string filePath = Path.Combine(Server.MapPath(Utility.Misc.Constants.thumbDirectory), string.Format("{0}.jpg", doc.Id));
            string fileType = "image/jpg";

            return File(Utility.Security.AES.DecryptFile(Utility.Security.AES.GetToken(doc.Id, UserPassword), filePath), fileType);
        }

        #endregion

        #region " New "

        public ActionResult New()
        {
            ViewBag.Title = "Intégration";
            ViewBag.Message = "Ajouter un fichier";

            return View();
        }

        //// This action handles the ajax POST and the upload
        [HttpPost]
        public ActionResult NewAjax(string dirId, string fileName, string fileContent, string docId, bool forceDoc = false)
        {
            bool newDoc = false;
            bool multiPage = false;
            Guid idPage = new Guid();

            if (fileName.EndsWith(".pdf"))
            {
                multiPage = true;
            }

            Document document;
            PageCollection pages;
            if (string.IsNullOrWhiteSpace(docId) || (multiPage && !forceDoc))
            {
                newDoc = true;
                document = new Document();
                pages = new PageCollection();

                //document.Extension = Path.GetExtension(fileName);
                document.DirectoryId = Guid.Parse(dirId);
                document.UserId = UserId;
                document.Title = fileName;
                document.IsReady = false;
                document.IsProcessed = false;
                document.Token = null;
                document.Save();
            }
            else
            {
                document = Document.LoadById(Guid.Parse(docId));
                pages = document.Pages;
            }

            document.Token = Utility.Security.AES.GetToken(document.Id, UserPassword);

            // generate file paths
            string path = Path.Combine(Server.MapPath(Utility.Misc.Constants.docDirectory), Guid.NewGuid().ToString());
            // upload original file
            System.IO.File.WriteAllBytes(path, Utility.Security.AES.EncryptBytes(document.Token, Convert.FromBase64String(fileContent)));

            if (fileName.EndsWith(".pdf"))
            {
                string pathPDF = Server.MapPath(Utility.Misc.Constants.pageDirectory);
                Utility.Image.PDFManager.ExtractImagesFromPDF(UserPassword, document.Token, path, pathPDF, pages);
            }
            else
            {
                Page page = null;
                page = new Page();
                page.IsReady = false;
                page.IsProcessed = false;
                page.Order = pages.Count;
                page.Save();
                page.Token = Utility.Security.AES.GetToken(page.Id, UserPassword);
                idPage = page.Id;
                Utility.Image.Treatment.Convert(document.Token, Server.MapPath(Utility.Misc.Constants.pageDirectory), page, path);
                pages.Add(page);
            }

            System.IO.File.Delete(path);

            if (newDoc || pages.Count == 1)
            {
                Utility.Image.Treatment.Thumbize(Server.MapPath(Utility.Misc.Constants.pageDirectory), Server.MapPath(Utility.Misc.Constants.thumbDirectory), document, pages.First());
            }

            bool docProcessed = true;
            foreach (Page p in pages)
            {
                if (p.IsProcessed == false)
                {
                    docProcessed = false;
                }

                p.DocumentId = document.Id; // a faire plus haut...
                p.IsReady = true;
            }

            pages.SaveAll();

            document.IsProcessed = docProcessed;
            document.IsReady = true;
            document.Token = null;
            document.Save();

            return Json(new { multipage = multiPage, id = document.Id, title = document.Title, idPage = idPage });
        }

        //// This action handles the form POST and the upload
        [HttpPost]
        public ActionResult New(string dirId, HttpPostedFileBase file)
        {
            // Verify that the user selected a file
            if (file != null && file.ContentLength > 0)
            {
                byte[] content = new byte[file.ContentLength];
                file.InputStream.Read(content, 0, file.ContentLength);
                //return NewAjax(dirId, file.FileName, Convert.ToBase64String(content));
            }

            return RedirectToAction("Index");
        }

        [HttpPost]
        public ActionResult SetTitle(Guid id, string title)
        {
            Document doc = Document.Load(id);
            doc.Title = title;
            doc.Save();
            return new HttpStatusCodeResult(200);
        }

        [HttpPost]
        public ActionResult CreateTitle(string title)
        {
            Document doc = new Document();
            doc.Title = title;
            doc.Save();
            return Json(new { id = doc.Id });
        }

        [HttpPost]
        public ActionResult ReOrder(Guid id, string[] list)
        {
            if (list != null)
            {
                PageCollection pages = new PageCollection();
                Page p = null;

                foreach (string idPage in list)
                {
                    p = Page.Load(Guid.Parse(idPage));
                    p.Order = pages.Count;
                    p.DocumentId = id;
                    pages.Add(p);
                }

                pages.SaveAll();
            }

            return new HttpStatusCodeResult(200);
        }

        #endregion

        #region " Display "

        public ActionResult Index()
        {
            ViewBag.Title = "Bibliothèque";
            ViewBag.Message = "Liste des fichiers";

            DocumentCollection documents = DocumentCollection.LoadTopByUser(UserEntity);

            return View(documents);
        }
        public ActionResult Search(string search, int p = 0)
        {
            ViewBag.Title = "Recherche";
            ViewBag.Message = string.Format("Recherche de [ {0} ] :", search);

            InitPagination(string.Format("{0}?{1}={2}&p=", Request.Path, "search", search), p, DocumentCollection.SearchByUserCount(UserEntity, search));

            DocumentCollection documents = DocumentCollection.PageSearchByUser(p, Utility.Misc.Constants.itemByPage, null, UserEntity, search);

            return View("Index", documents);
        }
        public ActionResult Directory(string id, int p = 0)
        {
            SoftFluent.Samples.GED.Directory dir = SoftFluent.Samples.GED.Directory.Load(Guid.Parse(id));
            ViewBag.Title = "Dossier";
            ViewBag.Message = string.Format("Fichiers du dossier [ {0} ] :", dir.Title);

            InitPagination(string.Format("{0}?{1}={2}&p=", Request.Path, "id", id), p, DocumentCollection.LoadByDirectoryUserCount(dir, UserEntity));

            DocumentCollection documents = DocumentCollection.PageLoadByDirectoryUser(p, Utility.Misc.Constants.itemByPage, null, dir, UserEntity);

            return View("Index", documents);
        }
        public ActionResult Queue(int p = 0)
        {
            ViewBag.Title = "File d'attente";
            ViewBag.Message = "Liste des fichiers";

            InitPagination(string.Format("{0}?p=", Request.Path), p, DocumentCollection.LoadQueueByUserCount(UserEntity));

            DocumentCollection documents = DocumentCollection.PageLoadQueueByUser(p, Utility.Misc.Constants.itemByPage, null, UserEntity);

            return View("Index", documents);
        }

        #endregion

    }
}