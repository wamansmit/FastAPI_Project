Certainly! Let's create a Kubernetes deployment and a NodePort service for the `smitwaman/fastapi:20240611` application within the "fastapi" namespace. Here are the steps:

1. **Create a Namespace**:
   First, create the "fastapi" namespace if it doesn't already exist:
   ```yaml
   apiVersion: v1
   kind: Namespace
   metadata:
     name: fastapi
   ```
   Save this as `fastapi-namespace.yaml` and apply it using `kubectl apply -f fastapi-namespace.yaml`.

2. **Deployment YAML (fastapi-deployment.yaml)**:
   Create a deployment YAML file (`fastapi-deployment.yaml`) with the following content:
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: fastapi-deployment
     namespace: fastapi
   spec:
     replicas: 3
     selector:
       matchLabels:
         app: fastapi
     template:
       metadata:
         labels:
           app: fastapi
       spec:
         containers:
           - name: fastapi-app
             image: smitwaman/fastapi:20240611
             ports:
               - containerPort: 9009
   ```
   Apply it using `kubectl apply -f fastapi-deployment.yaml`.

3. **Service YAML (fastapi-service.yaml)**:
   Create a NodePort service YAML file (`fastapi-service.yaml`) with the following content:
   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: fastapi-service
     namespace: fastapi
   spec:
     type: NodePort
     selector:
       app: fastapi
     ports:
       - protocol: TCP
         port: 9009
         targetPort: 9009
         nodePort: 30080
   ```
   Apply it using `kubectl apply -f fastapi-service.yaml`.

4. **Access the FastAPI Application**:
   - The FastAPI application will be accessible via any node's IP address and port 30080.
   - Find the IP address of any node in your cluster (e.g., `kubectl get nodes -o wide`).
   - Open your browser and navigate to `http://<node_ip>:30080`.

That's it! You should now be able to access your FastAPI application through the browser using the NodePort. If you have any further questions, feel free to ask! 😊
