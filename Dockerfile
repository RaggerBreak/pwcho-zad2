# Build
FROM maven:3.8.4-eclipse-temurin-17 AS build
COPY pom.xml /app/
COPY src /app/src
RUN mvn -f /app/pom.xml clean package -DskipTests

# Run
FROM adoptopenjdk/openjdk11:jre-11.0.11_9-debian
EXPOSE 8080
MAINTAINER ragger.break@gmail.com
COPY --from=build /app/target/pwcho-zad2.jar /app/app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom", "-jar","/app/app.jar"]
