FROM maven:3.8.6 AS build

WORKDIR /app

COPY /src ./src
COPY pom.xml .

RUN mvn clean install

FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080

CMD java -jar app.jar
