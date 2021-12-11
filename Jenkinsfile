pipeline {
    agent any
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'maven:3.8.4-openjdk-11'
                    args '-v $HOME/.m2:/root/.m2'
                    reuseNode true
                }
            }
            steps {
                sh 'mvn -B clean package surefire-report:report'
            }
            post {
                always {
                    junit '**/target/**/*.xml'
                }
            }
        }
        stage('Building image') {
            steps{
                script {
                    docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
    }
}