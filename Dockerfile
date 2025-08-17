# Use Maven to build the source
FROM maven:3.8.6-openjdk-17 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# Use OpenJDK for optimal runtime (small image)
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy only the final jar from builder
COPY --from=build /app/target/SpringMongoDB-main-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

# Run your Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
