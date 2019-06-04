FROM microsoft/dotnet:3.0-sdk AS build-env
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
RUN dotnet build -c Release -o /app

FROM build-env AS publish
RUN dotnet publish -c Release -o /app

# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "blazorboilerplate.server.dll"]