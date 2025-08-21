FROM jenkins/jenkins:dind
LABEL authors="Komputer"
WORKDIR /app
COPY /target/maven_project-1.0-SNAPSHOT.jar /app/maven_project-1.0-SNAPSHOT.jar
CMD ["java", "-jar", "maven_project-1.0-SNAPSHOT.jar"]


FROM jenkins/jenkins:dind

# Отключаем setup wizard
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Копируем список плагинов и устанавливаем их
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

# Копируем скрипты инициализации
COPY init.groovy.d /usr/share/jenkins/ref/init.groovy.d
# Открываем порт
USER root
RUN apt-get update && \
    apt-get install -y maven && \
    rm -rf /var/lib/apt/lists/*

USER jenkins