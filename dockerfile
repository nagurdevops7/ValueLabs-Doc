#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

ARG vers=1.0.0.0

WORKDIR /src

COPY Unity.GraphQL.sln .

RUN mkdir "Unity.GraphQL.Gateway"
COPY "Unity.GraphQL.Gateway/Unity.GraphQL.Gateway.csproj" "Unity.GraphQL.Gateway"


RUN mkdir "Unity.GraphQL.Gateway.IntegrationTests"
COPY "Unity.GraphQL.Gateway.IntegrationTests/Unity.GraphQL.Gateway.IntegrationTests.csproj" "Unity.GraphQL.Gateway.IntegrationTests"

RUN mkdir "Unity.GraphQL.Gateway.UnitTests"
COPY "Unity.GraphQL.Gateway.UnitTests/Unity.GraphQL.Gateway.UnitTests.csproj" "Unity.GraphQL.Gateway.UnitTests"


RUN dotnet restore --disable-parallel --locked-mode "Unity.GraphQL.sln"

COPY . .

WORKDIR /src/Unity.GraphQL.Gateway

ENV versenv=${vers}

RUN dotnet build "Unity.GraphQL.Gateway.csproj" /p:AssemblyVersion=1.0.0.0 -c Release -o /app/build

FROM build AS publish

RUN dotnet publish "Unity.GraphQL.Gateway.csproj" /p:AssemblyVersion=1.0.0.0 -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Unity.GraphQL.Gateway.dll"]
