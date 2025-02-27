# Step 1: Use a stable Maven + Java 17 image to build the app
FROM maven:3.8.8-eclipse-temurin-17 AS build

WORKDIR /app
COPY pom.xml . 

# Download dependencies first to speed up subsequent builds
RUN mvn dependency:go-offline

COPY . . 

# Build the JAR file (skip tests to speed up deployment)
RUN mvn clean package -DskipTests

# Debugging: Show the contents of the target folder
RUN ls -lah target/ && find target/ -name "*.jar"

# Step 2: Use a lightweight Java runtime for the final container
FROM eclipse-temurin:17-jdk
WORKDIR /app

# Explicitly copy the built JAR file from the build stage
COPY --from=build /app/target/tdeecalculator-0.0.1-SNAPSHOT.jar app.jar

# Ensure the correct port is exposed for Railway
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar", "--server.port=8080"]
