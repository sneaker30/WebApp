using System;
using System.Net.Mail;
using System.Threading.Tasks;

namespace parti.admin.lib
{
    public class SendMail
    {
        public class Result
        {
            public string msg { get; set; }
        }

        public async Task Send(string txt, string reciever)
        {
            await Task.Delay(10000).ContinueWith(task =>
            {
                Result result = new Result();
                MailMessage mail = new MailMessage();
                SmtpClient SmtpServer = new SmtpClient("mail.parti.gov.la");
                try
                {
                    mail.From = new MailAddress("admin@parti.gov.la");
                    mail.To.Add(reciever);
                    mail.Subject = "PARTI Application Notification";
                    mail.Body = txt;
                    mail.IsBodyHtml = true;

                    SmtpServer.Port = 465;
                    SmtpServer.Host = "mail.parti.gov.la";
                    SmtpServer.EnableSsl = true;
                    SmtpServer.DeliveryMethod = SmtpDeliveryMethod.Network;
                    SmtpServer.UseDefaultCredentials = false;
                    SmtpServer.Credentials = new System.Net.NetworkCredential("admin@parti.gov.la", "B33rLa0#@!");
                    //SmtpServer.TargetName = "STARTTLS/smtp.office365.com";

                    SmtpServer.Send(mail);
                    result.msg = "1";
                }
                catch (Exception ex)
                {
                    result.msg = "0";
                }
            });
        }
    }
}