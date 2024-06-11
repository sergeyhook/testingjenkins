pipeline {
    agent { 
        dockerfile {
            filename 'abobaboba'  
        } 
    }
    stages {
        stage('Build with Gradle') {
            steps {
                sh 'ls -la ~/.gradle/native'
                sh 'id'
                sh 'gradle build'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'gradle buildDockerImage'
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
