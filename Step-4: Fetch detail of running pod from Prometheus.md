To set up Prometheus on your local system to monitor a FastAPI application deployed with NodePort, follow these steps:

### Step 1: Install Prometheus
Download the latest Prometheus release from the [official website](https://prometheus.io/download/). Unzip the package and navigate to the Prometheus directory.

### Step 2: Configure Prometheus to Monitor FastAPI
Create a `prometheus.yml` configuration file in the Prometheus directory. Here's an example configuration to scrape metrics from a FastAPI application:

```yaml
global:
  scrape_interval: 15s  # Set the scrape interval to every 15 seconds.

scrape_configs:
  - job_name: 'fastapi'
    static_configs:
      - targets: ['<Node_IP>:<NodePort>']  # Replace with your Node IP and the NodePort.
```

Replace `<Node_IP>` with the IP address of your Kubernetes node and `<NodePort>` with the port exposed by the NodePort service.

### Step 3: Start Prometheus
Run Prometheus with the following command:

```bash
./prometheus --config.file=prometheus.yml
```

Prometheus will start and begin scraping metrics from the specified endpoint.

### Step 4: Instrument FastAPI for Prometheus
Ensure your FastAPI application is instrumented to expose Prometheus metrics. You can use the `prometheus-fastapi-instrumentator` package for this purpose:

```bash
pip install prometheus-fastapi-instrumentator
```

Then, in your FastAPI application, add the following:

```python
from fastapi import FastAPI
from prometheus_fastapi_instrumentator import Instrumentator

app = FastAPI()

# Instrument the app
Instrumentator().instrument(app).expose(app)

# Your routes go here
```

### Step 5: Deploy FastAPI with NodePort
If you haven't already, deploy your FastAPI application on Kubernetes and expose it via a NodePort service. Here's an example of a Kubernetes service definition:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: fastapi-service
spec:
  type: NodePort
  ports:
    - port: 8000
      nodePort: 30007
      protocol: TCP
  selector:
    app: fastapi-app
```

Make sure the `selector` matches the labels of your FastAPI deployment.

### Step 6: Access Prometheus Dashboard
Open your web browser and go to `http://localhost:9090` to access the Prometheus dashboard. You can now create queries to monitor your FastAPI application's metrics.

By following these steps, you'll have Prometheus running on your local system, configured to monitor your FastAPI application deployed with NodePort. Remember to replace placeholders like `<Node_IP>` and `<NodePort>` with actual values from your environment.

Source: Conversation with Copilot, 11/06/2024
(1) Getting Started: Monitoring a FastAPI App with Grafana and Prometheus .... https://dev.to/ken_mwaura1/getting-started-monitoring-a-fastapi-app-with-grafana-and-prometheus-a-step-by-step-guide-3fbn.
(2) Build and monitor your FastAPI microservice with Docker, Prometheus and .... https://medium.com/@ct.onyemaobi/build-and-monitor-your-fastapi-microservice-with-docker-prometheus-and-grafana-part-1-7e69a2e5fb67.
(3) Build and monitor your FastAPI microservice with Docker, Prometheus and .... https://medium.com/@ct.onyemaobi/build-and-monitor-your-fastapi-microservice-with-docker-prometheus-and-grafana-part-2-37472157a2b.
(4) How to Setup Prometheus Monitoring On Kubernetes Cluster - DevOpsCube. https://devopscube.com/setup-prometheus-monitoring-on-kubernetes/.
(5) Getting started with Prometheus: Setting up and monitoring a FastAPI .... https://ikespand.github.io/posts/PrometheusBeginnerGuide/.
(6) undefined. https://github.com/KenMwaura1/Fast-Api-example.git.
(7) undefined. https://bing.com/search?q=.
