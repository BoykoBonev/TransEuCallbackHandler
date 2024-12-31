# Use the official .NET runtime image for running the application
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

# Use the official .NET SDK image for building the application
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["TransEuCallbackHandler.csproj", "./"]
RUN dotnet restore "TransEuCallbackHandler.csproj"
COPY . .
WORKDIR "/src"
RUN dotnet publish "TransEuCallbackHandler.csproj" -c Release -o /app/publish

# Final stage: Build a runtime image
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "TransEuCallbackHandler.dll"]
