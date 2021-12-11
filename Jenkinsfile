pipeline {
    agent any
    stages {
        stage('Build') {
            agent {
                image 'maven:3.8.4-openjdk-11'
                args '-v $HOME/.m2:/root/.m2'
                reuseNode true
            }
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn -B test surefire-report:report'
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