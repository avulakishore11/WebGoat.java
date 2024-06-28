FROM docker.io/maven:3.9.8-eclipse-temurin-21

WORKDIR /app

COPY WebGoat.java/pom.xml .
COPY WebGoat.java/src .

RUN mvn clean package

# Copy the JAR file from the builder stage
FROM openjdk:21-slim

WORKDIR /app

COPY --from=builder /app/target/*.jar .

CMD ["java", "-jar", "*.jar"]
