pipeline {
    agent any
    environment {
        // Define application server details
        REMOTE_HOST = '3.148.173.123'
        REMOTE_USER = 'root'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'master', url: 'https://github.com/11harshsharma/docker-webapp.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t flask-app .'
            }
        }

        stage('Tag Docker Image') {
            steps {
                sh 'docker tag flask-app:latest 370857112107.dkr.ecr.us-east-2.amazonaws.com/demo:latest'
            }
        }

        stage('Push to ECR') {
            steps {
                withCredentials([
                    string(credentialsId: 'AWS_ACCESS_KEY', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'AWS_SECRET_KEY', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh '''
                    export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
                    export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
                    aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 370857112107.dkr.ecr.us-east-2.amazonaws.com
                    docker push 370857112107.dkr.ecr.us-east-2.amazonaws.com/demo:latest
                    '''
                }
            }
        }
        stage('Stop Container') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'ssh-key', keyFileVariable: 'SSH_KEY')]) {
                script {
                    sh '''
                    ssh -i $SSH_KEY -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} 'docker stop flask-app-container && docker rm -f flask-app-container'
                    '''
                }
            }
            }
        }

        stage('Deploy on Application Server') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'ssh-key', keyFileVariable: 'SSH_KEY')]) {
                script {
                    sh '''
                    echo "Deploying docker container on application server..."
                    ssh -i $SSH_KEY -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} 'aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 370857112107.dkr.ecr.us-east-2.amazonaws.com && docker pull 370857112107.dkr.ecr.us-east-2.amazonaws.com/demo:latest && docker run --name flask-app-container -d -p 5000:5000 370857112107.dkr.ecr.us-east-2.amazonaws.com/demo:latest'
                    '''
                }
            }
            }
        }
    }
}

