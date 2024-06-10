pipeline {
    agent { 
        dockerfile {
            filename 'abobaboba'  
        } 
        
    }
    stages {
        stage('Test') {
            steps {
                sh 'node --version'
                sh 'svn --version'
            }
        }
    }
}