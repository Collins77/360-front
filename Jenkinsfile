pipeline {
    agent any

    environment {
        NODE_VERSION = '23'
    }

    stages {
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
