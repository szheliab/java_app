FROM openjdk:8-jre

ENV JAVA_OPTS="-Xmx256m -Xms256m"
ENV APP_JAR="/opt/myapp/app.jar"

ADD target/*.jar ${APP_JAR}

EXPOSE 8080

ENTRYPOINT ["java", "${JAVA_OPTS}", "-jar", "${APP_JAR}"]
