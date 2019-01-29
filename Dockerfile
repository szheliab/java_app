FROM openjdk:8-jre

ENV JAVA_OPTS="-Xmx256m -Xms256m" \
    JAR_DIR="/opt/myapp/" \
    JAR_NAME="app.jar"

COPY docker-entrypoint.sh /
COPY target/*.jar ${JAR_DIR}${JAR_NAME}

VOLUME ["/tmp", "/var/log"]

EXPOSE 8080

WORKDIR $JAR_DIR
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD ["java", "${JAVA_OPTS}", "-jar", "${JAR_DIR}${APP_NAME}"]
