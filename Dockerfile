FROM maven:3.5-jdk-8-alpine AS build 
WORKDIR /usr/app
COPY src /usr/app/src
COPY pom.xml /usr/app/
RUN mvn install

FROM java:8-jdk-alpine
WORKDIR /usr/app
COPY --from=build /usr/app/target/petclinic.war /usr/app/
EXPOSE 9104
ENTRYPOINT ["java", "-jar", "petclinic.war"]
