Here are the steps to deploy Prometheus using `apiVersion: apps/v1` and `kind: Deployment`, along with setting up Minikube and Prometheus ConfigMap:

### Setting up Minikube

1. **Install Minikube**:
   Follow the instructions in the [official Minikube documentation](https://minikube.sigs.k8s.io/docs/start/) for your operating system.

2. **Start Minikube**:
   ```bash
   minikube start
   ```

3. **Check Minikube Status**:
   ```bash
   minikube status
   ```

### Setting up Prometheus

1. **Create a Namespace for Prometheus**:
   ```bash
   kubectl create namespace prometheus
   ```

2. **Create the Prometheus Configuration File**:
   Create a `prometheus.yml` file. Here's a basic example:
   ```yaml
   global:
     scrape_interval: 15s

   scrape_configs:
     - job_name: 'prometheus'
       static_configs:
         - targets: ['localhost:9090']
   ```

3. **Create a ConfigMap for Prometheus**:
   ```bash
   kubectl create configmap prometheus-server-config --from-file=prometheus.yml -n prometheus
   ```

4. **Deploy Prometheus**:
   Create a `prometheus-deployment.yml` file with the following content:
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: prometheus-server
     namespace: prometheus
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: prometheus
     template:
       metadata:
         labels:
           app: prometheus
       spec:
         containers:
         - name: prometheus
           image: prom/prometheus
           args:
             - "--config.file=/etc/prometheus/prometheus.yml"
           ports:
             - containerPort: 9090
           volumeMounts:
             - name: prometheus-config-volume
               mountPath: /etc/prometheus
     volumes:
       - name: prometheus-config-volume
         configMap:
           name: prometheus-server-config
   ```

5. **Apply the Deployment**:
   ```bash
   kubectl apply -f prometheus-deployment.yml
   ```

6. **Expose Prometheus Service**:
   Create a `prometheus-service.yml` file with the following content:
   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: prometheus-service
     namespace: prometheus
   spec:
     type: NodePort
     ports:
       - port: 9090
         targetPort: 9090
         nodePort: 30000
     selector:
       app: prometheus
   ```

7. **Apply the Service**:
   ```bash
   kubectl apply -f prometheus-service.yml
   ```

8. **Access Prometheus**:
   Once Prometheus is deployed and the service is exposed, you can access Prometheus through Minikube:
   ```bash
   minikube service prometheus-service -n prometheus
   ```





Deployment using values.yaml




To integrate the provided `values.yaml` file from the Prometheus Helm chart with your custom configuration using a ConfigMap and ensuring the deployment uses `apiVersion: apps/v1` and `kind: Deployment`, you need to follow these steps:

1. **Download the `values.yaml` File**:
   ```bash
   wget https://raw.githubusercontent.com/prometheus-community/helm-charts/main/charts/kube-prometheus-stack/values.yaml -O prometheus-values.yaml
   ```

2. **Modify the `values.yaml` File**:
   You will need to integrate your ConfigMap into the `values.yaml` file and ensure the deployment configuration uses `apiVersion: apps/v1` and `kind: Deployment`.

3. **Create a ConfigMap for Prometheus**:
   Create a `prometheus-configmap.yaml` file:
   ```yaml
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: prometheus-server-config
     namespace: prometheus
   data:
     prometheus.yml: |
       global:
         scrape_interval: 15s
       scrape_configs:
         - job_name: 'prometheus'
           static_configs:
             - targets: ['localhost:9090']
   ```

4. **Apply the ConfigMap**:
   ```bash
   kubectl apply -f prometheus-configmap.yaml
   ```

5. **Customize the `values.yaml` for Deployment**:
   Edit the `prometheus-values.yaml` file to ensure the Prometheus server uses the ConfigMap created. Specifically, under the Prometheus server configuration section, you'll need to refer to the ConfigMap for the `prometheus.yml` configuration. Here's a simplified approach to do this:

   ```yaml
   prometheus:
     server:
       configMapOverrideName: prometheus-server-config
       configMapOverrideKey: prometheus.yml
   ```

   Ensure other necessary configurations are set correctly according to your requirements. You can directly edit the `values.yaml` file and add the above lines under the appropriate section.

6. **Deploy Prometheus Using Helm**:
   Use the modified `values.yaml` to deploy the Prometheus stack:
   ```bash
   helm install prometheus prometheus-community/kube-prometheus-stack -f prometheus-values.yaml -n prometheus
   ```

7. **Verify the Deployment**:
   Check the status of the deployed resources:
   ```bash
   kubectl get all -n prometheus
   ```

### Final Configuration Example

Your `prometheus-values.yaml` should now include references to the custom ConfigMap and ensure the deployment uses the correct `apiVersion` and `kind`.

Here is a condensed version of the relevant sections you might modify:

```yaml
# prometheus-values.yaml

prometheus:
  server:
    configMapOverrideName: prometheus-server-config
    configMapOverrideKey: prometheus.yml

# Other configurations remain as per the default or your custom needs
```

With this setup, Prometheus will use your custom ConfigMap configuration for `prometheus.yml`, and Helm will ensure the deployment is created with the specified `apiVersion: apps/v1` and `kind: Deployment`.