pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'master', url: 'https://github.com/maheshpalakonda/test-1.git'
            }
        }

        stage('Build & Deploy') {
            steps {
                // Stop containers if running
                sh 'docker-compose down || echo "No containers running"'

                // Start containers
                sh 'docker-compose up -d --build'
            }
        }

        stage('Wait for MySQL') {
            steps {
                script {
                    sh '''
                    echo "Waiting for MySQL to be ready..."
                    until docker exec ecommerce_db mysql -uroot -proot -e "select 1" > /dev/null 2>&1
                    do
                        sleep 5
                        echo "Still waiting..."
                    done
                    echo "MySQL is ready!"
                    '''
                }
            }
        }
    }

    post {
        success { echo '✅ Deployment Successful!' }
        failure { echo '❌ Deployment Failed!' }
    }
}
