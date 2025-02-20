# Stap 1: Gebruik een stabiele Maven + Java 17 image om de app te bouwen
FROM maven:3.8.8-eclipse-temurin-17 AS build

WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline

COPY . .
RUN mvn clean package -DskipTests

# Controleer of het JAR-bestand correct is gebouwd
RUN ls -l target/ && test -f target/*.jar

# Stap 2: Gebruik een lichtere Java runtime voor de eindcontainer
FROM eclipse-temurin:17-jdk
WORKDIR /app

# Kopieer het juiste JAR-bestand van de buildfase
COPY --from=build /app/target/*.jar app.jar

CMD ["java", "-jar", "app.jar"]
