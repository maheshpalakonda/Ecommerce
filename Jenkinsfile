pipeline {
    agent any

    environment {
        // Hardcoded DB credentials matching docker-compose.yaml
        DB_HOST = "db"
        DB_USER = "root"
        DB_PASSWORD = "root"
        DB_NAME = "quickcartdb"
        DB_PORT = "3306"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'master', url: 'https://github.com/maheshpalakonda/test-1.git'
            }
        }

        stage('Build & Deploy') {
            steps {
                sh 'docker-compose down -v'      // Remove old containers & volumes
                sh 'docker-compose up -d --build' // Build and start containers
            }
        }

        stage('Wait for MySQL') {
            steps {
                echo "⏳ Waiting for MySQL to be ready..."
                sh '''
                for i in {1..20}; do
                    docker exec mysql_db mysql -uroot -proot -e "SELECT 1;" quickcartdb && break
                    echo "MySQL not ready yet, retrying..."
                    sleep 5
                done
                '''
            }
        }

        stage('Post Deployment') {
            steps {
                echo "✅ Deployment finished successfully!"
            }
        }
    }

    post {
        failure {
            echo "❌ Deployment failed!"
        }
    }
}
