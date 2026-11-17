# Product Details Webpage - Git, GitHub, Jenkins, Docker, Kubernetes
Run locally: open index.html in a browser.
Docker: docker build -t product-details:latest . && docker run -d -p 8081:80 product-details:latest
Kubernetes: kubectl apply -f k8s/  ->  http://localhost:30080
CI/CD: see Jenkinsfile (Checkout, Test, Build, Deploy, Verify)
