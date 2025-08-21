FROM jenkins/jenkins:lts
LABEL authors="Komputer"
WORKDIR /app
COPY /target/maven_project-1.0-SNAPSHOT.jar /app/maven_project-1.0-SNAPSHOT.jar
CMD ["java", "-jar", "maven_project-1.0-SNAPSHOT.jar"]
EXPOSE 8080
# Устанавливаем плагины
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
# Открываем порт
