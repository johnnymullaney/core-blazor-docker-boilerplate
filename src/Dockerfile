FROM mcr.microsoft.com/dotnet/core/runtime:3.0 AS runtime
WORKDIR /app
ENV ASPNETCORE_ENVIRONMENT=Production
ENV ASPNETCORE_URLS http://*:8000
EXPOSE 8000

FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build-env
WORKDIR /src

COPY BlazorBoilerplate.sln ./
COPY /BlazorBoilerplate.Shared/BlazorBoilerplate.Shared.csproj ./BlazorBoilerplate.Shared/
COPY /BlazorBoilerplate.Client/BlazorBoilerplate.Client.csproj ./BlazorBoilerplate.Client/
COPY /BlazorBoilerplate.Server/BlazorBoilerplate.Server.csproj ./BlazorBoilerplate.Server/
RUN dotnet restore

# Copy everything else and build
COPY . .
WORKDIR /src/BlazorBoilerplate.Server
RUN dotnet build  -c Release -o /app

FROM build-env AS publish
RUN dotnet publish  -c Release -o /app

# Build runtime image
FROM runtime AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "blazorboilerplate.server.dll"]