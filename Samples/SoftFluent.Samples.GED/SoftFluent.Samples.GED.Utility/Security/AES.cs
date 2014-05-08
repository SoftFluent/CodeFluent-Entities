using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace SoftFluent.Samples.GED.Utility.Security
{
    public class AES
    {
        public static byte[] EncryptFile(string key, string path)
        {
            return EncryptBytes(key, System.IO.File.ReadAllBytes(path));
        }
        public static string Encrypt(string key, string text)
        {
            return string.Format("{0}{0}", Convert.ToBase64String(EncryptBytes(key, Encoding.ASCII.GetBytes(text))));
        }

        public static byte[] EncryptBytes(string key, byte[] content)
        {
            return EncryptStream(key, content).ToArray();
        }

        public static MemoryStream EncryptStream(string key, byte[] content)
        {
            System.Security.Cryptography.SymmetricAlgorithm rijn = System.Security.Cryptography.SymmetricAlgorithm.Create();

            using (MemoryStream ms = new MemoryStream())
            {
                byte[] rgbIV = Encoding.ASCII.GetBytes("polychorepolycho");
                byte[] rgbKey = Encoding.ASCII.GetBytes(key);
                System.Security.Cryptography.CryptoStream cs = new System.Security.Cryptography.CryptoStream(ms, rijn.CreateEncryptor(rgbKey, rgbIV), System.Security.Cryptography.CryptoStreamMode.Write);

                cs.Write(content, 0, content.Length);
                cs.Close();

                return ms;
            }
        }

        public static byte[] DecryptFile(string key, string path)
        {
            return DecryptBytes(key, System.IO.File.ReadAllBytes(path));
        }
        public static string Decrypt(string key, string text)
        {
            return DecryptBytes(key, Convert.FromBase64String(text)).ToString();
        }

        public static byte[] DecryptBytes(string key, byte[] content)
        {
            return DecryptStream(key, content).ToArray();
        }

        public static MemoryStream DecryptStream(string key, byte[] content)
        {
            using (MemoryStream ms = new MemoryStream())
            {
                System.Security.Cryptography.SymmetricAlgorithm rijn = System.Security.Cryptography.SymmetricAlgorithm.Create();

                byte[] rgbIV = Encoding.ASCII.GetBytes("polychorepolycho");
                byte[] rgbKey = Encoding.ASCII.GetBytes(key);

                System.Security.Cryptography.CryptoStream cs = new System.Security.Cryptography.CryptoStream(ms, rijn.CreateDecryptor(rgbKey, rgbIV),
                System.Security.Cryptography.CryptoStreamMode.Write);

                cs.Write(content, 0, content.Length);
                cs.Close();

                return ms;
            }
        }

        public static string GetToken(Guid id, string key)
        {
            if (string.Equals(id.ToString(), new Guid().ToString()))
                throw new Exception("Guid was not set !");
            return Encrypt(key, id.ToString()).Substring(0, 8);
        }
    }
}
