using Spoved.Api.Models;

namespace Spoved.Api.Services
{
    public class MailService : IMailService
    {
        public void SendMail(Mail mail)
        {
            mail.FirstName = "mail.FirstName;";
        }
    }
}