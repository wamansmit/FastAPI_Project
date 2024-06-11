
To create a deployment YAML file for your FastAPI application with a replica count of 3 and a NodePort service, follow these steps:

1. **Create the deployment YAML file** (`fastapi-deployment.yaml`):
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: fastapi-deployment
     namespace: deployment-application
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
         - name: fastapi
           image: FastAPI
           ports:
           - containerPort: 8000
   ```
   This YAML defines a deployment named `fastapi-deployment` in the `deployment-application` namespace, with 3 replicas of the FastAPI application, using the image named `FastAPI`.

2. **Create the NodePort service YAML file** (`fastapi-nodeport-service.yaml`):
   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: fastapi-service
     namespace: deployment-application
   spec:
     type: NodePort
     selector:
       app: fastapi
     ports:
     - port: 80
       targetPort: 8000
       nodePort: 30007
   ```
   This YAML defines a NodePort service named `fastapi-service` that will route external traffic on port `30007` to your FastAPI application's container port `8000`. The `nodePort` value can be any from `30000` to `32767`¹.

3. **Apply the YAML files** to your Minikube cluster:
   ```bash
   kubectl apply -f fastapi-deployment.yaml
   kubectl apply -f fastapi-nodeport-service.yaml
   ```

4. **Verify the deployment and service**:
   ```bash
   kubectl get deployments,services -n deployment-application
   ```

5. **Access your FastAPI application**:
   Find out the Minikube node's IP address with `minikube ip`, and then access the application at `http://<minikube-ip>:30007/`.

Remember to replace `FastAPI` with the actual Docker image name and tag that you have pushed to your Docker registry. Adjust the `nodePort` if you wish to use a different port for external access²³.

Source: Conversation with Copilot, 11/06/2024
(1) Kubernetes Deployment - JetBrains Guide. https://www.jetbrains.com/guide/python/tutorials/fastapi-aws-kubernetes/kubernetes_deploy/.
(2) Service - Kubernetes Guide with Examples - Matthew Palmer. https://matthewpalmer.net/kubernetes-app-developer/articles/service-kubernetes-example-tutorial.html.
(3) kubernetes-sample-deployment/sample-service-nodeport.yaml at main .... https://github.com/devops4solutions/kubernetes-sample-deployment/blob/main/sample-service-nodeport.yaml.
(4) Connecting Applications with Services | Kubernetes. https://kubernetes.io/docs/tutorials/services/connect-applications-service/.
(5) Where do I put my NodePort Spec in my deployment.yaml. https://stackoverflow.com/questions/69245492/where-do-i-put-my-nodeport-spec-in-my-deployment-yaml.
(6) undefined. https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64.
(7) undefined. https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/.
(8) undefined. https://dl.k8s.io/release/.
(9) undefined. https://dl.k8s.io/release/stable.txt%29/bin/linux/amd64/kubectl.