# Use AdoptOpenJDK OpenJDK 11 image as base
FROM adoptopenjdk/openjdk11:alpine-jre

# Set working directory inside the container
WORKDIR /app

# Copy the compiled application JAR file into the container at /app
COPY build/libs/*.jar app.jar

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the application when the container starts
CMD ["java", "-jar", "app.jar"]
