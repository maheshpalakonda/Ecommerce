pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'master', url: 'https://github.com/maheshpalakonda/Ecommerce.git'
            }
        }

        stage('Build & Deploy') {
            steps {
                sh 'docker-compose down || echo "No containers running"'
                sh 'docker-compose up -d --build'
            }
        }
    }

    post {
        success { echo '✅ Deployment Successful!' }
        failure { echo '❌ Deployment Failed!' }
    }
}

