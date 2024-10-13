FROM docker.io/maven:3.9.8-eclipse-temurin-21 AS builder

WORKDIR /app

COPY . ./


RUN mvn clean package

# Stage 2: Create the image for runtime
FROM eclipse-temurin:21-jre-jammy

# Set the working directory


# Copy the jar file from the build stage
COPY --from=builder /app/target/webgoat-*.jar ./


# Expose the application port
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "webgoat.jar"]
