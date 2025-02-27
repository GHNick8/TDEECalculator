# Step 1: Use an official Maven image to build the app
FROM maven:3.8.8-eclipse-temurin-17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy Maven project files first to leverage caching
COPY pom.xml .

# Download dependencies to speed up later builds
RUN mvn dependency:go-offline

# Copy the entire project after dependencies are cached
COPY . .

# Build the JAR file (skip tests for faster deployment)
RUN mvn clean package -DskipTests

# Debugging: Show contents of target folder to check if JAR exists
RUN ls -lah target/ && find target/ -name "*.jar"

# Step 2: Use a lightweight JDK image for the final container
FROM eclipse-temurin:17-jdk
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Ensure the correct port is exposed for Railway
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar", "--server.port=8080"]
