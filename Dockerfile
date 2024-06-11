FROM openjdk:11-jre-slim

WORKDIR /app

COPY *.jar ./app.jar

EXPOSE 4567

CMD ["java", "-jar", "./app.jar"]
