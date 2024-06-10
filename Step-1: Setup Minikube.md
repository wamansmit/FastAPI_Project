Step 1: Setup Miniqube on lcal system 

list of commands to install Minikube on a Linux system:

1. **Update your system** (optional but recommended):
   ```bash
   sudo apt-get update
   sudo apt-get upgrade
   ```

2. **Install a Hypervisor** (if not already installed, VirtualBox is used as an example here):
   ```bash
   sudo apt-get install -y virtualbox virtualbox-ext-pack
   ```

3. **Install kubectl** (Kubernetes command-line tool):
   ```bash
   curl -LO "https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl"
   chmod +x ./kubectl
   sudo mv ./kubectl /usr/local/bin/kubectl
   ```

4. **Download Minikube**:
   ```bash
   curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
   ```

5. **Make the Minikube binary executable**:
   ```bash
   chmod +x minikube
   ```

6. **Move the Minikube binary to your path**:
   ```bash
   sudo mv minikube /usr/local/bin/
   ```

7. **Start Minikube**:
   ```bash
   minikube start
   ```

8. **Check the status of Minikube** (to confirm it's running):
   ```bash
   minikube status
   ```

9. **Access the Kubernetes Dashboard** (optional):
   ```bash
   minikube dashboard
   ```


