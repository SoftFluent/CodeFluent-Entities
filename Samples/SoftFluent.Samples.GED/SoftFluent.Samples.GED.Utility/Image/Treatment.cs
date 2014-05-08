using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;

namespace SoftFluent.Samples.GED.Utility.Image
{
    public class Treatment
    {
        public static void Convert(string key, string p, Page page, string imageFile)
        {
            System.IO.MemoryStream cryptoStream = new System.IO.MemoryStream(Utility.Security.AES.DecryptStream(key, System.IO.File.ReadAllBytes(imageFile)).ToArray());
            using (var srcImage = System.Drawing.Image.FromStream(cryptoStream))
            {
                using (var graphics = Graphics.FromImage(srcImage))
                {
                    graphics.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;
                    graphics.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
                    graphics.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;
                    graphics.DrawImage(srcImage, new System.Drawing.Rectangle(0, 0, srcImage.Width, srcImage.Height));

                    System.IO.MemoryStream ms = new System.IO.MemoryStream();
                    System.Drawing.Imaging.EncoderParameters parms = new System.Drawing.Imaging.EncoderParameters(1);
                    parms.Param[0] = new System.Drawing.Imaging.EncoderParameter(System.Drawing.Imaging.Encoder.Compression, 0);
                    System.Drawing.Imaging.ImageCodecInfo jpegEncoder = System.Drawing.Imaging.ImageCodecInfo.GetImageEncoders().FirstOrDefault(e => e.FormatDescription == "JPEG");
                    srcImage.Save(ms, jpegEncoder, parms);
                    System.IO.File.WriteAllBytes(System.IO.Path.Combine(p, string.Format("{0}.jpg", page.Id.ToString())), SoftFluent.Samples.GED.Utility.Security.AES.EncryptStream(page.Token, ms.ToArray()).ToArray());
                    ms.Close();
                }
            }
        }

        public static void Thumbize(string pPage, string pThumb, Document document, Page page)
        {
            System.IO.MemoryStream cryptoStream = new System.IO.MemoryStream(Utility.Security.AES.DecryptStream(page.Token, System.IO.File.ReadAllBytes(System.IO.Path.Combine(pPage, page.Filename))).ToArray());
            using (var srcImage = System.Drawing.Image.FromStream(cryptoStream))
            {
                var newWidth = 300;
                var newHeight = 200;

                using (var newImage = new Bitmap(newWidth, newHeight))
                using (var graphics = Graphics.FromImage(newImage))
                {
                    graphics.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;
                    graphics.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
                    graphics.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;
                    graphics.DrawImage(srcImage, new System.Drawing.Rectangle(0, 0, newWidth, newHeight));

                    System.IO.MemoryStream ms = new System.IO.MemoryStream();
                    System.Drawing.Imaging.EncoderParameters parms = new System.Drawing.Imaging.EncoderParameters(1);
                    parms.Param[0] = new System.Drawing.Imaging.EncoderParameter(System.Drawing.Imaging.Encoder.Compression, 0);
                    System.Drawing.Imaging.ImageCodecInfo jpegEncoder = System.Drawing.Imaging.ImageCodecInfo.GetImageEncoders().FirstOrDefault(e => e.FormatDescription == "JPEG");
                    newImage.Save(ms, jpegEncoder, parms);
                    System.IO.File.WriteAllBytes(System.IO.Path.Combine(pThumb, string.Format("{0}.jpg", document.Id.ToString())), SoftFluent.Samples.GED.Utility.Security.AES.EncryptStream(document.Token, ms.ToArray()).ToArray());
                    ms.Close();
                }
            }
        }

        public static System.Drawing.Bitmap SetContrast(System.Drawing.Bitmap bitmap, double contrast)
        {
            System.Drawing.Bitmap temp = (System.Drawing.Bitmap)bitmap;
            System.Drawing.Bitmap bmap = (System.Drawing.Bitmap)temp.Clone();
            if (contrast < -100) contrast = -100;
            if (contrast > 100) contrast = 100;
            contrast = (100.0 + contrast) / 100.0;
            contrast *= contrast;
            System.Drawing.Color c;
            for (int i = 0; i < bmap.Width; i++)
            {
                for (int j = 0; j < bmap.Height; j++)
                {
                    c = bmap.GetPixel(i, j);
                    double pR = c.R / 255.0;
                    pR -= 0.5;
                    pR *= contrast;
                    pR += 0.5;
                    pR *= 255;
                    if (pR < 0) pR = 0;
                    if (pR > 255) pR = 255;

                    double pG = c.G / 255.0;
                    pG -= 0.5;
                    pG *= contrast;
                    pG += 0.5;
                    pG *= 255;
                    if (pG < 0) pG = 0;
                    if (pG > 255) pG = 255;

                    double pB = c.B / 255.0;
                    pB -= 0.5;
                    pB *= contrast;
                    pB += 0.5;
                    pB *= 255;
                    if (pB < 0) pB = 0;
                    if (pB > 255) pB = 255;

                    bmap.SetPixel(i, j, System.Drawing.Color.FromArgb((byte)pR, (byte)pG, (byte)pB));
                }
            }
            bitmap = (System.Drawing.Bitmap)bmap.Clone();
            return bitmap;
        }
    }
}
