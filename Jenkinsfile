pipeline {
    agent { 
        dockerfile {
            filename 'abobaboba'
            args '--privileged'  
        } 
    }
    stages {
        stage('Build with Gradle') {
            steps {
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
