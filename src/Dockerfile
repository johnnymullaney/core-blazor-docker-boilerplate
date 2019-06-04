FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
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

WORKDIR /app
RUN dotnet publish  -c Release -o /app

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/runtime:3.0 AS runtime
WORKDIR /app
COPY --from=build-env /app ./
ENTRYPOINT ["dotnet", "blazorboilerplate.server.dll"]