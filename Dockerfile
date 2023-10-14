FROM maven:3.8.2-amazoncorretto-17 as builder
WORKDIR /app

COPY pom.xml .
COPY ./src ./src
RUN mvn clean install package

FROM amazoncorretto:17-alpine
WORKDIR /app

COPY --from=builder /app/target/*.jar /app/application.jar

ENTRYPOINT java -jar /app/application.jar