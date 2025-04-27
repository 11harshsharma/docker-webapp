Jenkins Pipeline for Dockerized Flask Application Deployment
This pipeline automates the process of cloning a repository, building and tagging a Docker image, pushing it to AWS Elastic Container Registry (ECR), stopping an existing container, and deploying a new container on the application server.

Pipeline Workflow
1. Clone Repository
The pipeline pulls the source code from the master branch of the GitHub repository: docker-webapp.

2. Build Docker Image
The pipeline creates a Docker image named flask-app from the repository's contents.

3. Tag Docker Image
Tags the Docker image with the latest tag in AWS ECR: 370857112107.dkr.ecr.us-east-2.amazonaws.com/demo:latest.

4. Push Docker Image to ECR
Authenticates using AWS credentials.

Pushes the tagged Docker image to AWS ECR.

5. Stop Existing Container
Authenticates to the application server using SSH.

Stops and removes the existing Docker container flask-app-container (if running).

6. Deploy New Container
Pulls the latest Docker image from AWS ECR onto the application server.

Deploys the new container named flask-app-container and exposes it on port 5000.
