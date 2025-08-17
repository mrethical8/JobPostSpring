# Use OpenJDK base image
FROM openjdk:17-jdk-slim as build

# Set working directory
WORKDIR /app

# Copy Maven wrapper and pom.xml
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Give executable permission to mvnw
RUN chmod +x mvnw

# Download dependencies (helps with caching)
RUN ./mvnw dependency:go-offline -B

# Copy source code
COPY src src

# Build the application
RUN ./mvnw clean package -DskipTests

# --------------------
# Run Stage
# --------------------
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy the jar from build stage
COPY --from=build /app/target/*.jar app.jar

# Expose application port (adjust if needed)
EXPOSE 8080

# Run the Spring Boot app
ENTRYPOINT ["java", "-jar", "app.jar"]
