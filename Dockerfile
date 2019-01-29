FROM openjdk:8-jre

ENV JAVA_OPTS="-Xmx256m -Xms256m" \
    JAVA_PORT="8080" \
    JAR_DIR="/opt/myapp/" \
    JAR_NAME="app.jar"

COPY docker-entrypoint.sh /
COPY target/*.jar ${JAR_DIR}${JAR_NAME}

VOLUME ["/tmp", "/var/log"]

EXPOSE ${JAVA_PORT}

WORKDIR $JAR_DIR
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD ["java", "${JAVA_OPTS}", "-jar", "${JAR_DIR}${APP_NAME}"]
