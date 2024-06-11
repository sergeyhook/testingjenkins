pipeline {
    agent none
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
            agent any
            /*agent{ 
                dockerfile {
                    filename 'dockerbuilder'
                    args '--privileged -v /var/run/docker.sock:/var/run/docker.sock'
                } 
            }*/
            steps {
                sh "docker build -t HelloWorld:${env.BUILD_ID} ."
            }
        }

        stage('Archive') {
            steps {
                archiveArtifacts artifacts: '**/build/libs/*.jar', fingerprint: true
                sh "docker save HelloWorld:${env.BUILD_ID} > HelloWorld.tar"
                archiveArtifacts artifacts: 'HelloWorld.tar', fingerprint: true
            }
        }
    }
}
