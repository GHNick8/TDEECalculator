# Gebruik een officiële Java 17 image met Maven
FROM maven:3.8.6-openjdk-17 AS build

# Stel de werkdirectory in
WORKDIR /app

# Kopieer de projectbestanden
COPY . .

# Build het Spring Boot project
RUN mvn clean package

# Gebruik een lichtere JDK runtime voor de eindcontainer
FROM openjdk:17-jdk-slim

# Stel de werkdirectory in
WORKDIR /app

# Kopieer het gebouwde JAR-bestand uit de eerste fase
COPY --from=build /app/target/tdee-calculator.jar app.jar

# Stel de standaard startopdracht in
CMD ["java", "-jar", "app.jar"]
