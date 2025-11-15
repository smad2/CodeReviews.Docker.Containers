# CodeReviews.Docker.Containers

## 🔧 Dockerfile Explanation

### **Multi-stage Build**

- **Stage 1 (`build`)**: Uses SDK to compile the application
- **Stage 2 (`final`)**: Uses lighter runtime for execution

### **Line by Line**

```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build  # Image with compilation tools
WORKDIR /src                                    # Working directory
COPY MathGame.csproj .                         # Copy project first (cache optimization)
RUN dotnet restore                             # Restore dependencies
COPY . .                                       # Copy source code
RUN dotnet publish -c Release -o /app/publish  # Compile and publish

FROM mcr.microsoft.com/dotnet/runtime:9.0 AS final  # Lightweight runtime image
WORKDIR /app
COPY --from=build /app/publish .              # Copy from build stage
ENTRYPOINT ["dotnet", "MathGame.dll"]         # Entry point + arguments
```

## 🚀 Commands to Test

### Basic Build and Run

```bash
# Build image
docker build -t mathgame .

# Run container
docker run --rm mathgame
```

### With Versioning

```bash
# Build with different versions
docker build -t mathgame:v1 .
docker build -t mathgame:latest .
docker build -t mathgame:dev .

# Run specific version
docker run --rm mathgame:v1
docker run --rm mathgame:dev
```

## Run the Container

```bash
# Basic execution
docker run --rm mathgame:v1

# With command-line arguments
docker run --rm mathgame:v1 difficulty=hard username=player1
```

## Available Arguments

- `difficulty`: easy, medium, hard
- `username`: Player name
- `mode`: practice, timed, survival
- `level`: beginner, intermediate, advanced

## Image Versions

- `mathgame:v1` - Stable version
- `mathgame:latest` - Latest build
- `mathgame:dev` - Development version

```

## 🎯 Key Points to Remember

1. **Multi-stage builds** reduce final image size
2. **ENTRYPOINT** allows passing arguments when running the container
3. **Image versioning** is essential for maintenance
4. **`--rm`** automatically removes the container when it finishes
5. **Runtime image** is lighter than SDK for production
```
