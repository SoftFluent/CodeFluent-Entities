using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using iTextSharp;
using iTextSharp.text;
using iTextSharp.text.pdf;

namespace SoftFluent.Samples.GED.Utility.Image
{
    public class PDFManager
    {
        public static void ExtractImagesFromPDF(string password, string key, string docPath, string pagePath, PageCollection pages)
        {
            Page page = null;
            // NOTE:  This will only get the first image it finds per page.
            PdfReader pdf = new PdfReader(Utility.Security.AES.DecryptFile(key, docPath));
            //RandomAccessFileOrArray raf = new iTextSharp.text.pdf.RandomAccessFileOrArray(p);

            try
            {
                for (int pageNumber = 1; pageNumber <= pdf.NumberOfPages; pageNumber++)
                {
                    PdfDictionary pg = pdf.GetPageN(pageNumber);

                    // recursively search pages, forms and groups for images.
                    PdfObject obj = FindImageInPDFDictionary(pg);
                    if (obj != null)
                    {

                        int XrefIndex = Convert.ToInt32(((PRIndirectReference)obj).Number.ToString(System.Globalization.CultureInfo.InvariantCulture));
                        PdfObject pdfObj = pdf.GetPdfObject(XrefIndex);
                        PdfStream pdfStrem = (PdfStream)pdfObj;
                        byte[] bytes = PdfReader.GetStreamBytesRaw((PRStream)pdfStrem);
                        if ((bytes != null))
                        {
                            using (System.IO.MemoryStream memStream = new System.IO.MemoryStream(bytes))
                            {
                                memStream.Position = 0;
                                System.Drawing.Image img = System.Drawing.Image.FromStream(memStream);
                                // must save the file while stream is open.

                                page = new Page();
                                page.Order = pages.Count;
                                page.Save();
                                page.Token = Utility.Security.AES.GetToken(page.Id, password);
                                //string path = System.IO.Path.Combine(page.Filename, String.Format(@"{0}.jpg", pageNumber));
                                System.Drawing.Imaging.EncoderParameters parms = new System.Drawing.Imaging.EncoderParameters(1);
                                parms.Param[0] = new System.Drawing.Imaging.EncoderParameter(System.Drawing.Imaging.Encoder.Compression, 0);
                                System.Drawing.Imaging.ImageCodecInfo jpegEncoder = System.Drawing.Imaging.ImageCodecInfo.GetImageEncoders().FirstOrDefault(e => e.FormatDescription == "JPEG");
                                System.IO.MemoryStream ms = new System.IO.MemoryStream();
                                img.Save(ms, jpegEncoder, parms);
                                System.IO.File.WriteAllBytes(System.IO.Path.Combine(pagePath, page.Filename), SoftFluent.Samples.GED.Utility.Security.AES.EncryptStream(page.Token, ms.ToArray()).ToArray());
                                ms.Close();
                                pages.Add(page);
                            }
                        }
                    }
                }
            }
            catch
            {
                throw;
            }
            finally
            {
                pdf.Close();
                //raf.Close();
            }
        }
        private static PdfObject FindImageInPDFDictionary(PdfDictionary pg)
        {
            PdfDictionary res =
                (PdfDictionary)PdfReader.GetPdfObject(pg.Get(PdfName.RESOURCES));


            PdfDictionary xobj =
              (PdfDictionary)PdfReader.GetPdfObject(res.Get(PdfName.XOBJECT));
            if (xobj != null)
            {
                foreach (PdfName name in xobj.Keys)
                {

                    PdfObject obj = xobj.Get(name);
                    if (obj.IsIndirect())
                    {
                        PdfDictionary tg = (PdfDictionary)PdfReader.GetPdfObject(obj);

                        PdfName type =
                          (PdfName)PdfReader.GetPdfObject(tg.Get(PdfName.SUBTYPE));

                        //image at the root of the pdf
                        if (PdfName.IMAGE.Equals(type))
                        {
                            return obj;
                        }// image inside a form
                        else if (PdfName.FORM.Equals(type))
                        {
                            return FindImageInPDFDictionary(tg);
                        } //image inside a group
                        else if (PdfName.GROUP.Equals(type))
                        {
                            return FindImageInPDFDictionary(tg);
                        }

                    }
                }
            }

            return null;
        }
        public static byte[] CreatePdf(string key, string p, PageCollection pages)
        {
            using (var ms = new System.IO.MemoryStream())
            {
                var document = new iTextSharp.text.Document(iTextSharp.text.PageSize.A4, 0, 0, 0, 0);
                iTextSharp.text.pdf.PdfWriter.GetInstance(document, ms).SetFullCompression();
                document.Open();
                foreach (Page page in pages)
                {
                    byte[] content = Utility.Security.AES.DecryptFile(Utility.Security.AES.GetToken(page.Id, key), System.IO.Path.Combine(p, page.Filename));
                    var image = iTextSharp.text.Image.GetInstance(content);
                    image.ScaleToFit(document.PageSize.Width, document.PageSize.Height);
                    document.Add(image);
                }
                document.Close();
                return ms.ToArray();
            }
        }
    }
}
