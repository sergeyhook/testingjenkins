# Use a base image with Java runtime
FROM openjdk:17-jdk-alpine

# Set the working directory
WORKDIR /app

# Copy the build files
COPY build/libs/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Define the command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]