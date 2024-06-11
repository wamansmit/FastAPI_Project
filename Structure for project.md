Deploy and Monitor a FastAPI "Hello World" application using Prometheus on a Minikube cluster:

### Step 1: Dockerize the FastAPI "Hello World" Application
1. Create a `main.py` file with the FastAPI code:
    ```python
    from fastapi import FastAPI

    app = FastAPI()

    @app.get("/")
    def read_root():
        return {"Hello": "World"}
    ```
2. Create a `requirements.txt` file with the necessary dependencies:
    ```
    fastapi
    uvicorn[standard]
    ```
3. Write a `Dockerfile` to containerize the application:
    ```Dockerfile
    FROM python:3.9

    WORKDIR /app

    COPY requirements.txt .

    RUN pip install --no-cache-dir -r requirements.txt

    COPY . .

    EXPOSE 80

    CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
    ```
4. Build the Docker image:
    ```bash
    docker build -t my-fastapi-helloworld .
    ```
5. Tag and push the image to Docker Hub:
    ```bash
    docker tag my-fastapi-helloworld username/my-fastapi-helloworld
    docker push username/my-fastapi-helloworld
    ```
   Replace `username` with your Docker Hub username.

### Step 2: Install Minikube Cluster
1. Install Minikube following the official [instructions](^16^).
2. Start the Minikube cluster:
    ```bash
    minikube start
    ```

### Step 3: Create Deployment of FastAPI on Minikube
1. Point your Docker CLI to the Docker daemon inside Minikube:
    ```bash
    eval $(minikube docker-env)
    ```
2. Rebuild the Docker image so it's available to Minikube:
    ```bash
    docker build -t my-fastapi-helloworld .
    ```
3. Create a deployment YAML file `fastapi-deployment.yaml`:
    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: fastapi-deployment
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: fastapi
      template:
        metadata:
          labels:
            app: fastapi
        spec:
          containers:
          - name: fastapi
            image: username/my-fastapi-helloworld
            ports:
            - containerPort: 80
    ```
4. Deploy the FastAPI application:
    ```bash
    kubectl apply -f fastapi-deployment.yaml
    ```
5. Expose the deployment using a NodePort service:
    ```bash
    kubectl expose deployment fastapi-deployment --type=NodePort --port=80
    ```

### Step 4: Create Deployment of Prometheus to Monitor FastAPI Container
1. Install Prometheus using Helm:
    ```bash
    kubectl create namespace monitoring
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm install prometheus-stack prometheus-community/kube-prometheus-stack -n monitoring
    ```
2. Configure Prometheus to scrape metrics from the FastAPI application by editing the `prometheus.yml` file within the Prometheus deployment to include the FastAPI service endpoint.

3. Access the Prometheus dashboard to view metrics:
    ```bash
    kubectl port-forward svc/prometheus-stack-prometheus -n monitoring 9090
    ```
   Then, navigate to `http://localhost:9090` in your browser.

By following these steps, you will have a FastAPI "Hello World" application running in a Minikube cluster, with Prometheus set up to monitor the application's metrics. Remember to replace placeholders like `username` with your actual Docker Hub username and adjust the service endpoint in the Prometheus configuration to match your FastAPI service.

Source: Conversation with Copilot, 11/06/2024
(1) minikube start | minikube - Kubernetes. https://minikube.sigs.k8s.io/docs/start/.
(2) FastAPI in Containers - Docker - FastAPI - tiangolo. https://fastapi.tiangolo.com/deployment/docker/.
(3) Using FastAPI inside Docker containers - LogRocket Blog. https://blog.logrocket.com/using-fastapi-inside-docker-containers/.
(4) How to Deploy Fastapi Application with Docker · Blowfish. https://jdhao.github.io/post/fastapi-app-deployment-docker/.
(5) How to Dockerize and Deploy a Fast API Application to Kubernetes .... https://dev.to/bravinsimiyu/how-to-dockerize-and-deploy-a-fast-api-application-to-kubernetes-cluster-35a9.
(6) Dockerize FastAPI project like a pro - Step-by-step Tutorial. https://dev.to/rajeshj3/dockerize-fastapi-project-like-a-pro-step-by-step-tutorial-7i8.
(7) Deploy an api application in Kubernetes using Minikube. https://www.youtube.com/watch?v=i7PFg6aVcdI.
(8) Deploy ML models with FastAPI, Docker, and Heroku | Tutorial. https://www.youtube.com/watch?v=h5wLuVDr0oc.
(9) How to setup your web application in local minikube Kubernetes cluster. https://www.youtube.com/watch?v=qFhzu7LolUU.
(10) How to Deploy a Fast API Application to a Kubernetes Cluster using .... https://dev.to/louisalexandrelaguet/how-to-deploy-a-fast-api-application-to-a-kubernetes-cluster-using-podman-and-minikube-168e.
(11) FastAPI Kubernetes Service on Minikube - GitHub. https://github.com/SzilvasiPeter/fastapi-kubernetes-minikube.
(12) Getting Started: Monitoring a FastAPI App with Grafana and Prometheus .... https://dev.to/ken_mwaura1/getting-started-monitoring-a-fastapi-app-with-grafana-and-prometheus-a-step-by-step-guide-3fbn.
(13) Getting started with Prometheus: Setting up and monitoring a FastAPI .... https://ikespand.github.io/posts/PrometheusBeginnerGuide/.
(14) A demo of Prometheus+Grafana for monitoring an ML model served with FastAPI. https://pythonawesome.com/a-demo-of-prometheus-grafana-for-monitoring-an-ml-model-served-with-fastapi/.
(15) Build and monitor your FastAPI microservice with Docker, Prometheus and .... https://medium.com/@ct.onyemaobi/build-and-monitor-your-fastapi-microservice-with-docker-prometheus-and-grafana-part-2-37472157a2b.
(16) GitHub - brunobritorj/grafana-prometheus-fastapi: A docker-compose .... https://github.com/brunobritorj/grafana-prometheus-fastapi.
(17) Install Tools | Kubernetes. https://kubernetes.io/docs/setup/minikube/.
(18) How to Start a Local Kubernetes Cluster With Minikube. https://www.howtogeek.com/devops/how-to-start-a-local-kubernetes-cluster-with-minikube/.
(19) Minikube and Kubectl Installation Guide: Deploy ... - DEV Community. https://dev.to/mohammadtb/minikube-and-kubectl-installation-guide-deploy-kubernetes-clusters-in-a-few-simple-steps--306g.
(20) Steps to install Kubernetes Cluster with minikube - GoLinuxCloud. https://www.golinuxcloud.com/install-kubernetes-minikube/.
(21) undefined. https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64.
(22) undefined. http://127.0.0.1:8000.
(23) undefined. https://github.com/KenMwaura1/Fast-Api-example.git.
(24) undefined. https://prometheus-community.github.io/helm-charts.