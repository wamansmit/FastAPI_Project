Certainly! To deploy Prometheus on Kubernetes using Helm, you can follow these steps:
**Create namespace:**
   - If you haven't already, install Helm on your Kubernetes cluster. You can use the following commands:
     ```bash
     kubectl create nns prometheus
     ```

1. **Install Helm:**
   - If you haven't already, install Helm on your Kubernetes cluster. You can use the following commands:
     ```bash
     curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
     chmod 700 get_helm.sh
     ./get_helm.sh
     ```

2. **Add the Prometheus Helm Repository:**
   - Add the Prometheus community Helm repository:
     ```bash
     helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
     helm repo update
     ```

3. **Install Prometheus:**
   - Deploy Prometheus using the Helm chart:
     ```bash
     helm install prometheus-operator prometheus-community/kube-prometheus-stack --namespace monitoring

     ```

4. **Customize Configuration (Optional):**
   - To modify Prometheus configuration, create a custom `prometheus.yaml` file.
   - Copy the default values from the Helm chart and adjust them as needed.
   - Install Prometheus with your custom configuration:
     ```bash
     helm install -f prometheus.yaml prometheus prometheus-community/prometheus
     ```

5. **Verify Deployment:**
   - Check the status of Prometheus components:
     ```bash
     kubectl get pods -n prometheus
     ```
Certainly! Let's break down the steps to create a custom `prometheus.yaml` file by modifying the default values from the Helm chart:

1. **Locate the Default Values:**
   - Helm charts come with default configuration values defined in their `values.yaml` files.
   - You can find the default Prometheus values in the Helm chart repository or by fetching them directly using:
     ```
     helm show values prometheus-community/prometheus > default-prometheus-values.yaml
     ```

2. **Create Your Custom Configuration:**
   - Copy the contents of `default-prometheus-values.yaml` to a new file named `prometheus.yaml`.
   - Edit `prometheus.yaml` to adjust the values according to your requirements.
   - Specify any additional scrape targets, alerting rules, or other settings you need.

3. **Customize the Configuration:**
   - Modify the following sections as needed:
     - `global`: Set global parameters like scrape interval and timeout.
     - Other specific sections for exporters, scrape jobs, and alerting rules.

4. **Install Prometheus with Custom Configuration:**
   - Deploy Prometheus using your custom configuration:
     ```
     helm install prometheus-release-name prometheus-community/prometheus -f prometheus.yaml
     ```
     Replace `prometheus-release-name` with your desired release name.

5. **Verify Deployment:**
   - Check if Prometheus pods are running:
     ```
     kubectl get pods -n prometheus
     ```


