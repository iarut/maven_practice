pipeline {
    agent {
        docker {
            image 'maven:3.8.8-openjdk-17' // более свежая версия Maven и Java
//             args '-v $HOME/.m2:/root/.m2'  // опционально, кэш Maven
        }
    }
    stages {
        stage('Version') {
            steps {
                sh 'mvn --version'
            }
        }
        stage ('Build'){
            steps {
                // Выполняем сборку проекта
                // Здесь можно указать дополнительные параметры Maven, если нужно
                // Например, '
                 sh 'mvn clean install'
        }
        stage('Build Docker Image') {
                    agent any  // Используем любой агент с установленным Docker
                    steps {
                        script {
                            // Проверяем, что собран JAR-файл
                            def jarFile = findFiles(glob: 'target/*.jar')[0]?.name
                            if (!jarFile) {
                                error "JAR file not found. Build failed."
                            }

                            // Создаем простой Dockerfile если его нет
//                             if (!fileExists('Dockerfile')) {
                                writeFile file: 'Dockerfile', text: """
        FROM openjdk:17-jdk-slim
        COPY target/*.jar app.jar
        ENTRYPOINT ["java", "-jar", "app.jar"]
        """
//                             }

                            // Собираем Docker-образ
                            docker.build("my-app :${env.BUILD_ID}", "-f Dockerfile .")
                        }
    }


}
post{
success {}
            echo 'Build completed successfully!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}
}