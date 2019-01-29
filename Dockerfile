FROM openjdk:8-jre

ARG JAR_FILE
ENV APP_JAR="/opt/myapp/app.jar"
ENV MONGO_URL mongodb://mongodb:27017

ADD ${JAR_FILE} ${APP_JAR}

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "${APP_JAR}"]
