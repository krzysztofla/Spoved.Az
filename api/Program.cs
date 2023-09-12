using Spoved.Api.Models;
using Spoved.Api.Services;

var MyAllowSpecificOrigins = "_myAllowSpecificOrigins";
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddScoped<IMailService, MailService>();
builder.Services.AddCors();

var app = builder.Build();
app.UseCors(builder => builder
.AllowAnyOrigin()
.AllowAnyMethod()
.AllowAnyHeader()
);
app.MapGet("/", () => "Hello World!");

app.MapPost("/contact", (IMailService mailService, Mail mail) =>
{
    mailService.SendMail(mail);
    return Results.Ok();
});

app.Run();
