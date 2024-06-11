FROM openjdk:11-jre-slim

WORKDIR /app

COPY -/home/gradle/project/build/libs/*.jar ./app.jar

EXPOSE 4567

CMD ["java", "-jar", "./app.jar"]
