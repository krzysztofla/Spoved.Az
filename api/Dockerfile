FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS build-env
WORKDIR /app

COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:7.0-alpine
EXPOSE 8080
WORKDIR /app
COPY --from=build-env /app/out .

ENTRYPOINT ["dotnet", "Spoved.Api.dll"]
