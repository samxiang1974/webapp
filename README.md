This repository will
1. Setting up a Web stack for development.
2. Containerizing the app using Docker.
3. Creating CI/CD pipelines for frontend/backend app.
4. Deploying the app on a Kubernetes cluster by Helm.
5. Monitoring the health of pods.
6. Setting up auto-scaling to handle high load.

Folder structure:   
server: this folder will contain our ExpressJS server and Helm charts to deploy it.  
client: this folder will contain everything React and Helm charts to deploy it.  
mariadb: this folder will contain override parameter to install mariadb.   
