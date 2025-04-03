pipeline {
    agent any

    environment {
        NODE_VERSION = '23'
        SONARQUBE_SERVER = 'sonarqube-server'
        APP_NAME = "360-front-ci"
        RELEASE = "1.0.0"
        DOCKER_USER = "mufasa77"
        DOCKER_PASS = 'dockerhub'
        IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
    }

    stages {
        stage("Cleanup Workspace") {
            steps {
                cleanWs()
            }
        }
        
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Setup Node.js') {
            steps {
                script {
                    def nodeHome = tool name: 'Node23', type: 'jenkins.plugins.nodejs.tools.NodeJSInstallation'
                    env.PATH = "${nodeHome}/bin:${env.PATH}"
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        // stage('Run Unit & Integration Tests') {
        //     steps {
        //         sh 'npm test'
        //     }
        // }

        // stage('Run E2E Tests with Cypress') {
        //     steps {
        //         sh 'npx cypress run'
        //     }
        // }

        stage('Build React.js App') {
            steps {
                sh 'npm run build'
            }
        }
        
        // stage('SonarQube Analysis') {
        // steps {
        //     script {
        //         withSonarQubeEnv(credentialsId: 'jenkins-sonarqube-token') {
        //             sh '''
        //                 npx sonar-scanner \
        //                 -Dsonar.projectKey=360-front \
        //                 -Dsonar.sources=src/pages \
        //                 -Dsonar.host.url=http://172.31.13.149:9000 \
        //                 -Dsonar.login=$SONAR_AUTH_TOKEN \
        //                 -Dsonar.branch.name=${BRANCH_NAME} \
        //                 -Dsonar.exclusions=**/*.test.js,**/__tests__/**,**/*.spec.js
        //             '''
        //         }
        //     }
        // }
        // }

        // stage('Quality Gate') {
        //     steps {
        //         script {
        //             waitForQualityGate abortPipeline: false, credentialsId: 'jenkins-sonarqube-token'
        //         }
        //     }
        // }

        stage('Build & Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image = docker.build "${IMAGE_NAME}"
                    }    

                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
                    }
                }
            }
        }
        

        // stage('Build & Push Docker Image') {
        //     steps {
        //         withDockerRegistry([credentialsId: 'dockerhub-credentials', url: '']) {
        //             sh 'docker build -t your-dockerhub-username/nextjs-app .'
        //             sh 'docker push your-dockerhub-username/nextjs-app'
        //         }
        //     }
        // }
    }
}
