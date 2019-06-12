# .NET Core SDK
FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS dotnetcore-sdk

WORKDIR /src

COPY /src/BlazorBoilerplate.sln ./
COPY /src/BlazorBoilerplate.Shared/BlazorBoilerplate.Shared.csproj ./BlazorBoilerplate.Shared/
COPY /src/BlazorBoilerplate.Client/BlazorBoilerplate.Client.csproj ./BlazorBoilerplate.Client/
COPY /src/BlazorBoilerplate.Server/BlazorBoilerplate.Server.csproj ./BlazorBoilerplate.Server/

# .NET Core Restore
RUN dotnet restore ./BlazorBoilerplate.Server/BlazorBoilerplate.Server.csproj

# Copy All Files
COPY . .

# .NET Core Build and Publish
FROM dotnetcore-sdk AS dotnetcore-build
RUN dotnet publish ./src/BlazorBoilerplate.Server/BlazorBoilerplate.Server.csproj -c Release -o /publish

FROM mcr.microsoft.com/dotnet/core/runtime:3.0 AS runtime
WORKDIR /app
COPY --from=dotnetcore-build /publish .
EXPOSE 80
EXPOSE 443
ENTRYPOINT ["dotnet", "blazorboilerplate.server.dll"]