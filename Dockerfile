FROM maven:3.5-jdk-8-alpine AS build 
WORKDIR /usr/app
COPY src /usr/app/src
COPY pom.xml /usr/app/
RUN mvn install

FROM java:8-jdk-alpine
WORKDIR /usr/app
COPY --from=build /usr/app/target/*.jar /usr/app/petclinic.jar
WORKDIR /deployments
COPY --from=build /usr/app/target/*.jar /deployments/petclinic.jar

RUN ls
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "petclinic.jar"]
