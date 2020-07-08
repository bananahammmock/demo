FROM openjdk:12-jdk

MAINTAINER Synerise

ADD target/spring-security-login-and-registration.jar /srv/application/app.jar

EXPOSE 8080

ENV JMX_DEBUG_JAVA_OPTS '-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9010 -Dcom.sun.management.jmxremote.rmi.port=9010 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.local.only=false -Djava.rmi.server.hostname=127.0.0.1'
ENV JAVA_OPTS ''

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

CMD exec java \
 $JMX_DEBUG_JAVA_OPTS $JAVA_OPTS \
 -Dfile.encoding=UTF-8 \
 -jar /srv/application/app.jar