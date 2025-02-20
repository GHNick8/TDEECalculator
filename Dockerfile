# Stap 1: Gebruik Maven met OpenJDK 17 om het project te bouwen
FROM maven:3.8.6-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stap 2: Gebruik een lichtere Java runtime om de applicatie te draaien
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/tdee-calculator.jar app.jar
CMD ["java", "-jar", "app.jar"]
