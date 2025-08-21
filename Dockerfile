FROM jenkins/jenkins:lts

# отключаем мастера при старте
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

USER root

# Установим Maven и Docker CLI
RUN apt-get update -qq && \
    apt-get install -qqy maven apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
    https://download.docker.com/linux/debian bullseye stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update -qq && \
    apt-get install -qqy docker-ce-cli && \
    usermod -aG docker jenkins && \
    rm -rf /var/lib/apt/lists/*

# Копируем список плагинов и ставим их
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

# Скрипты инициализации (например admin user)
COPY init.groovy.d/ /usr/share/jenkins/ref/init.groovy.d/

USER jenkins