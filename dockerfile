FROM docker.io/maven:3.9.8-eclipse-temurin-21 AS builder

WORKDIR /app

COPY . .


RUN mvn clean package

# Stage 2: Create the image for the application
FROM eclipse-temurin:21-jre-jammy

# Set the working directory
WORKDIR /home/azureuser

# Set permissions for the azureuser
RUN chgrp -R 0 /home/azureuser && \
    chmod -R g=u /home/azureuser

# Copy the jar file from the build stage
COPY --from=builder /app/target/webgoat-*.jar /home/azureuser/webgoat.jar

# Change to the azureuser
USER azureuser

# Expose the application port
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "/home/azureuser/webgoat.jar"]
