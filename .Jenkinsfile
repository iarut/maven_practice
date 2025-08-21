pipeline {
    agent {
        docker {
            image 'maven:3.8.8-openjdk-17' // более свежая версия Maven и Java
            args '-v $HOME/.m2:/root/.m2'  // опционально, кэш Maven
        }
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }
    }
}