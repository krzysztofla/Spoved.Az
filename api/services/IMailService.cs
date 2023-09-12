using Spoved.Api.Models;

namespace Spoved.Api.Services
{
    public interface IMailService
    {
        void SendMail(Mail mail);
    }
}