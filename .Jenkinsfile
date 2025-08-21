pipeline {
    agent {
        docker {
            image 'maven:3.8.8-openjdk-17'
        }
    }
    stages {
        stage('Version') {
            steps {
                sh 'mvn --version'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Build Docker Image') {
            agent any
            steps {
                script {
                    def jarFile = findFiles(glob: 'target/*.jar')[0]?.name
                    if (!jarFile) {
                        error "JAR file not found. Build failed."
                    }
                    writeFile file: 'Dockerfile', text: """
FROM jenkins/jenkins:dind
COPY target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
"""
                    docker.build("my-app:${env.BUILD_ID}", "-f Dockerfile .")
                }
            }
        }
    }
}
post {
        success {
            steps {
                echo 'Build completed successfully!'
            }
        }
        failure {
            steps {
                echo 'Build failed!'
            }
        }
    }