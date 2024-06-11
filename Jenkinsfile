pipeline {
    agent { 
        dockerfile {
            filename 'abobaboba'
            args '-v /root/.gradle:/root/.gradle'  
        } 
        
    }
    stages {
        stage('Build') {
            steps {
                sh './gradlew build'
            }
        }

        stage('Archive') {
            steps {
                archiveArtifacts artifacts: '**/build/libs/*.jar', fingerprint: true
            }
        }
    }
}