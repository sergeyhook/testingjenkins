pipeline {
    agent any
    stages {
        stage('Build with Gradle') {
            agent{ 
                dockerfile {
                    filename 'gradlebuilder'  
                } 
            }
            steps {
                sh 'gradle build'
            }
        }

        stage('Build Docker Image') {
            agent{ 
                dockerfile {
                    filename 'dockerbuilder'
                    args '-v /var/run/docker.sock:/var/run/docker.sock'
                } 
            }
            steps {
                script {
                    sh 'sudo docker build -t HelloWorld .'
                }
            }
        }

        stage('Archive') {
            steps {
                archiveArtifacts artifacts: '**/build/libs/*.jar', fingerprint: true
                sh 'docker save HelloWorld > HelloWorld.tar'
                archiveArtifacts artifacts: 'HelloWorld.tar', fingerprint: true
            }
        }
    }
}
