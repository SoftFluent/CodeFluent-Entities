using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SoftFluent.Samples.GED;
using SoftFluent.Samples.GED.Utility.Image;
using SoftFluent.Samples.GED.Utility.Misc;
using Tesseract;

namespace SoftFluent.Samples.GED.Utility.OCR
{
    public class Process
    {
        public static bool ProcessQueue(string p)
        {
            string logPath = System.IO.Path.Combine(p, "log", string.Format("{0}.txt", DateTime.Today.ToShortDateString().Replace("/", "-")));

            try
            {
                Page page = Page.LoadOneToProcess();

                if (page != null)
                {
                    Log.Write(logPath, "process launched");
                    //StringBuilder builder = new StringBuilder();
                    //foreach (Page page in document.Pages)
                    //{
                    // analyze file to get index infos
                    page.Text = AnalyzeFile(page.Token, p, System.IO.Path.Combine(p, "page", page.Filename));
                    page.IsProcessed = true;
                    page.Token = null;
                    page.Save();
                    //builder.AppendLine(page.Text);
                    //}

                    page.Document.Text = string.Format("{0} {1}", page.Document.Text, page.Text);
                    if (page.Document.Pages.Count(pa => pa.IsProcessed) == page.Document.Pages.Count)
                    {
                        page.Document.IsProcessed = true;
                    }
                    page.Document.Save();
                }
            }
            catch (Exception e)
            {
                Log.Write(logPath, e.Source + "|" + e.TargetSite.Name + "|" + e.Message);

                return false;
            }

            return true;
        }

        public static string AnalyzeFile(string key, string p, string fileName)
        {
            var data = System.IO.Path.Combine(p, "tessdata");

            using (var engine = new TesseractEngine(data, "fra", EngineMode.Default))
            {
                string bitmapPath = System.IO.Path.Combine(p, Guid.NewGuid().ToString() + System.IO.Path.GetExtension(fileName));
                System.IO.MemoryStream ms = new System.IO.MemoryStream(Utility.Security.AES.DecryptFile(key, fileName));
                System.Drawing.Bitmap bitmap = new System.Drawing.Bitmap(ms);
                bitmap = Treatment.SetContrast(bitmap, 20);
                bitmap.Save(bitmapPath);
                ms.Close();

                using (var img = Pix.LoadFromFile(bitmapPath))
                {
                    using (var page = engine.Process(img))
                    {
                        System.IO.File.Delete(bitmapPath);
                        return page.GetText().Trim();
                    }
                }
            }
        }

        public static string AnalyzeFileHOCR(string p, string fileName)
        {
            var data = System.IO.Path.Combine(p, "tessdata");

            using (var engine = new TesseractEngine(data, "fra", EngineMode.Default))
            {
                using (var img = Pix.LoadFromFile(fileName))
                {
                    using (var page = engine.Process(img))
                    {
                        return page.GetHOCRText(0);
                    }
                }
            }
        }
    }
}
