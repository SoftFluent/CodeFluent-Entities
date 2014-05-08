using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SoftFluent.Samples.GED.Utility.Misc
{
    public class Email
    {
        public static void SendMail(string to, string subject, string body, string document, List<System.IO.Stream> files = null)
        {
            System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage("xxx@xx.xx", to);

            message.Subject = subject;
            message.Body = body;
            if (files != null)
            {
                foreach (System.IO.Stream file in files)
                {
                    message.Attachments.Add(new System.Net.Mail.Attachment(file, document, "application/pdf"));
                }
            }

            using (System.Net.Mail.SmtpClient client = new System.Net.Mail.SmtpClient())
            {
                client.Send(message);
            }
        }

    }
}
