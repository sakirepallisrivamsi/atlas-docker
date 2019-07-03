FROM openjdk:8-jdk-alpine

RUN apk add --no-cache \
    bash \
    su-exec \
    python

ADD https://github.com/michalmiklas/atlas-docker/releases/download/v2.0.0/apache-atlas-2.0.0-bin.tar.gz /

RUN set -x \
    && cd / \
    && tar -xzvf apache-atlas-2.0.0-bin.tar.gz

WORKDIR /apache-atlas-2.0.0

EXPOSE 21000

ENV PATH=$PATH:/apache-atlas-2.0.0

ENV ATLAS_SERVER_HEAP="-Xms15360m -Xmx15360m -XX:MaxNewSize=5120m -XX:MetaspaceSize=100M -XX:MaxMetaspaceSize=512m"
ENV MANAGE_LOCAL_HBASE=false
ENV MANAGE_LOCAL_SOLR=true
ENV MANAGE_EMBEDDED_CASSANDRA=true
ENV MANAGE_LOCAL_ELASTICSEARCH=false

CMD ["/bin/bash", "-c", "/apache-atlas-2.0.0/bin/atlas_start.py; tail -fF /apache-atlas-2.0.0/logs/application.log"]
