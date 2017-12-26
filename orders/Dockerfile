FROM java:8-jre
WORKDIR /root
EXPOSE 9626
EXPOSE 8080
COPY build/libs/orders-1.0-SNAPSHOT.jar /root/app.jar
RUN apt-get update
ENTRYPOINT exec java $JAVA_OPTS -jar app.jar