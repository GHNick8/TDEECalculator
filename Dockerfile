# Stap 1: Gebruik een officiële en stabiele Maven + OpenJDK 17 image
FROM maven:3.8.8-eclipse-temurin-17 AS build

WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stap 2: Gebruik een lichtere Java runtime voor de eindcontainer
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target/tdee-calculator.jar app.jar
CMD ["java", "-jar", "app.jar"]
