FROM maven:3.5.0-jdk-8-alpine AS builder

# add pom.xml and source code
ADD . /

WORKDIR /

# package jar
RUN mvn clean package

# Second stage: minimal runtime environment
From alpine

# copy jar from the first stage
COPY --from=builder /jmx_prometheus_javaagent/target/jmx_prometheus_javaagent-*-SNAPSHOT.jar /jmx/jmx-prom-agent.jar
