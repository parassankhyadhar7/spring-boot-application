FROM maven:3.6.3-openjdk-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package

FROM tomcat:10.1.20-jdk17-temurin
COPY --from=builder /app/target/demoapp-0.0.1-SNAPSHOT.war .
RUN mv demoapp-0.0.1-SNAPSHOT.war demoapp.war && cp /usr/local/tomcat/demoapp.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD [ "catalina.sh", "run" ]

# If you have the .war file Dockerfile should be updat like below
# FROM tomcat:10.1.20-jdk17-temurin
# WORKDIR /usr/local/tomcat
# COPY ./demoapp.war ./webapps/
# EXPOSE 8080
# CMD [ "catalina.sh", "run" ]