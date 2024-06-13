pipeline {
    agent {
        docker {
            image 'gcr.io/kaniko-project/executor:latest'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        DOCKER_IMAGE_BASE = 'gradlebuilder' // Name of the base Docker image
        DOCKER_IMAGE_FINAL = 'final-image' // Name of the final Docker image with Gradle application
        DOCKER_TAG = 'latest'
        DOCKERFILE_BASE_PATH = 'gradlebuilder' // Dockerfile for base image
        DOCKERFILE_FINAL_PATH = 'Dockerfile' // Dockerfile for final image
    }

    stages {
        stage('Build Base Docker Image') {
            steps {
                script {
                    // Use Kaniko to build the base Docker image
                    def baseImageFingerprint = docker.build("${DOCKER_IMAGE_BASE}:${DOCKER_TAG}", "-f ${DOCKERFILE_BASE_PATH} .").id
                    echo "Base image fingerprint: ${baseImageFingerprint}"
                }
            }
        }

        stage('Build Gradle Application') {
            agent {
                docker {
                    image 'gradlebuilder:latest'
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
                    // Use the Gradle image to build the final Docker image
                    def finalImageFingerprint = docker.build("${DOCKER_IMAGE_FINAL}:${DOCKER_TAG}", "--build-arg GRADLE_IMAGE=${DOCKER_IMAGE_GRADLE}:${DOCKER_TAG} -f ${DOCKERFILE_FINAL_PATH} .").id
                    echo "Final image fingerprint: ${finalImageFingerprint}"
                }
            }
        }
        stage('Archive') {
            steps {
                archiveArtifacts artifacts: '**/build/libs/*.jar', fingerprint: true
                sh "docker save helloworldq:${env.BUILD_ID} > helloworld.tar"
                archiveArtifacts artifacts: 'helloworld.tar', fingerprint: true
            }
        }
    }
}