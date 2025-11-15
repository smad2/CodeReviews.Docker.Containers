# Build stage
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

#Copy project file and restore dependencies
COPY MathGame.csproj .
RUN dotnet restore

#Copy source code and build
COPY . .
RUN dotnet publish -c Release -o /app/publish

#Runtime stage
FROM mcr.microsoft.com/dotnet/runtime:9.0 AS final
WORKDIR /app

#Copy from build stage
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "MathGame.dll"]

