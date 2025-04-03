pipeline {
    agent any

    environment {
        NODE_VERSION = '23'
        SONARQUBE_SERVER = 'sonarqube-server'
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
        
        // stage('SonarQube Analysis') {
        // steps {
        //     script {
        //         withSonarQubeEnv(credentialsId: 'jenkins-sonarqube-token') {
        //             sh '''
        //                 npx sonar-scanner \
        //                 -Dsonar.projectKey=360-front \
        //                 -Dsonar.sources=. \
        //                 -Dsonar.host.url=http://172.31.13.149:9000 \
        //                 -Dsonar.login=$SONAR_AUTH_TOKEN \
        //                 -Dsonar.branch.name=${BRANCH_NAME}
        //             '''
        //         }
        //     }
        // }
        // }

        stage("Sonarqube Analysis") {
           environment {
            SCANNER_HOME = tool 'sonarqube-scanner'  // sonar-scanner is the name of the tool in the manage jenkins> tool configuration
           }
           steps {
            withSonarQubeEnv(installationName: 'sonarqube-server') {  //installationName is the name of sonar installation in manage jenkins>configure system
             bat "%SCANNER_HOME%/bin/sonar-scanner \
             -Dsonar.projectKey=sample-proj \
             -Dsonar.token=sqa_85069084ef219ee014c9de0502d0919c98682d2e \
             -Dsonar.sources=. \
             -Dsonar.host.url=http://172.31.13.149:9000 \
             -Dsonar.test.exclusions=App.test.js "
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
