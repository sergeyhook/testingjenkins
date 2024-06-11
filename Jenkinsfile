pipeline {
    agent { 
        dockerfile {
            filename 'abobaboba'
            args '-v /var/run/docker.sock:/var/run/docker.sock -v /root/.gradle:/root/.gradle'  
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
                    dockerImage = docker.build("HelloWorld")
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
