FROM openjdk:8-jre

ENV APP_JAR="/opt/myapp/app.jar"
ENV MONGO_URL mongodb://mongodb:27017

ADD target/rd-1.0-SNAPSHOT.jar /opt/myapp/app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/opt/myapp/app.jar"]
