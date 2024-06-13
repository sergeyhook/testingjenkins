pipeline {
    agent any

    environment {
        DOCKER_IMAGE_BASE = 'gradlebuilder'
        DOCKER_IMAGE_FINAL = 'testapp'
        DOCKER_TAG = 'latest'
        DOCKERFILE_BASE_PATH = 'gradlebuilder'
        DOCKERFILE_FINAL_PATH = 'Dockerfile'
        KANIKO_IMAGE = 'gcr.io/kaniko-project/executor:latest'
    }

    stages {
        stage('Build Base Docker Image') {
            steps {
                script {
                    // Use Kaniko to build the base Docker image
                    sh 'docker run -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/workspace -e DOCKER_HOST -e DOCKER_CONFIG=/kaniko/.docker ' + KANIKO_IMAGE + ' --dockerfile ' + DOCKERFILE_BASE_PATH + ' --destination ' + DOCKER_IMAGE_BASE + ':' + DOCKER_TAG
                }
            }
        }

        stage('Build Gradle Application') {
            agent {
                docker {
                    image "${DOCKER_IMAGE_BASE}:${DOCKER_TAG}"
                }
            }
            steps {
                script {
                    // Use the base Docker image to build the Gradle application
                    sh 'gradle build'
                    sh 'cp build/libs/*.jar .'
                }
            }
        }

        stage('Build Final Docker Image') {
            steps {
                script {
                    // Use Docker to build the final Docker image
                    def finalImageFingerprint = docker.build("${DOCKER_IMAGE_FINAL}:${env.BUILD_ID}", "-f ${DOCKERFILE_FINAL_PATH} .").id
                    echo "Final image fingerprint: ${finalImageFingerprint}"
                }
            }
        }

        stage('Archive') {
            steps {
                archiveArtifacts artifacts: '**/build/libs/*.jar', fingerprint: true
                sh "docker save ${DOCKER_IMAGE_FINAL}:${env.BUILD_ID} > helloworld.tar"
                archiveArtifacts artifacts: 'helloworld.tar', fingerprint: true
            }
        }
    }
}
