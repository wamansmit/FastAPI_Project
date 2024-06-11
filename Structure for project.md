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

