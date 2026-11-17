pipeline {
    agent any
    environment {
        // Jenkins started by brew has a short PATH; add Docker/kubectl locations
        PATH = "/opt/homebrew/bin:/usr/local/bin:/Applications/Docker.app/Contents/Resources/bin:${env.PATH}"
        IMAGE = "product-details"
    }
    stages {
        stage('Checkout') {
            steps { checkout scm }
        }
        stage('Test') {
            steps { sh './tests/test.sh' }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE:latest -t $IMAGE:$BUILD_NUMBER .'
                sh 'docker images | grep $IMAGE'
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl config use-context docker-desktop'
                sh 'kubectl apply -f k8s/'
                sh 'kubectl rollout restart deployment/product-details'
                sh 'kubectl rollout status deployment/product-details --timeout=120s'
            }
        }
        stage('Verify') {
            steps {
                sh 'kubectl get pods,svc'
                sh 'sleep 5; curl -sf http://localhost:30080 | grep "Product Details"'
            }
        }
    }
    post {
        success { echo 'Deployed! Open http://localhost:30080' }
        failure { echo 'Pipeline failed - check the Console Output' }
    }
}
