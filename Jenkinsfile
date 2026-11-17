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
                sh '''
                    kubectl port-forward service/product-details-service 8089:80 > /dev/null 2>&1 &
                    PF=$!
                    sleep 5
                    RESULT=0
                    curl -sf http://localhost:8089 | grep "Product Details" || RESULT=1
                    kill $PF
                    exit $RESULT
                '''
            }
        }
    }
    post {
        success { echo 'Deployed! Run: kubectl port-forward service/product-details-service 8081:80 and open http://localhost:8081' }
        failure { echo 'Pipeline failed - check the Console Output' }
    }
}