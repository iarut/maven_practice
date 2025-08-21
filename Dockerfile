FROM jenkins/jenkins
LABEL authors="Komputer"
WORKDIR /app
COPY /target/maven_project-1.0-SNAPSHOT.jar /app/maven_project-1.0-SNAPSHOT.jar
CMD ["java", "-jar", "maven_project-1.0-SNAPSHOT.jar"]
EXPOSE 8080