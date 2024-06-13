pipeline {
    agent any

    environment {
        DOCKER_IMAGE_BASE = 'gradlebuilder'
        DOCKER_IMAGE_FINAL = 'final-image'
        DOCKER_TAG = 'latest'
        DOCKERFILE_BASE_PATH = 'gradlebuilder'
        DOCKERFILE_FINAL_PATH = 'Dockerfile'
    }

    stages {
        stage('Build Base Docker Image and Gradle Application') {
            steps {
                script {
                    // Use Docker to build the base Docker image
                    def baseImageFingerprint = docker.build("${DOCKER_IMAGE_BASE}:${DOCKER_TAG}", "-f ${DOCKERFILE_BASE_PATH} .").id
                    echo "Base image fingerprint: ${baseImageFingerprint}"

                    // Use the base Docker image to build the Gradle application
                    docker.image("${DOCKER_IMAGE_BASE}:${DOCKER_TAG}").inside {
                        sh 'gradle build'
                        sh 'cp build/libs/*.jar .'
                    }
                }
            }
        }

        stage('Build Final Docker Image') {
            steps {
                script {
                    // Use Docker to build the final Docker image
                    def finalImageFingerprint = docker.build("${DOCKER_IMAGE_FINAL}:${DOCKER_TAG}", "--build-arg GRADLE_IMAGE=${DOCKER_IMAGE_BASE}:${DOCKER_TAG} -f ${DOCKERFILE_FINAL_PATH} .").id
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
