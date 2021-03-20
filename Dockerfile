FROM maven:3.5.0-jdk-8-alpine AS builder

# add pom.xml and source code
ADD pom.xml /
ADD jmx_prometheus_javaagent /
ADD jmx_prometheus_httpserver /

WORKDIR /

# package jar
RUN mvn clean package

# Second stage: minimal runtime environment
From alpine

# copy jar from the first stage
COPY --from=builder /jmx_prometheus_javaagent/target/*-SNAPSHOT.jar /jmx/jmx-prom-agent.jar
