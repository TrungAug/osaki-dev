#Build
FROM maven AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests
#Run
FROM tomcat:10.1-jre21
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
ENV SPRING_PROFILES_ACTIVE=docker
CMD [ "catalina.sh","run" ]