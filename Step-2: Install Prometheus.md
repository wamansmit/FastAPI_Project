
To install Prometheus on your Ubuntu system, you can follow these steps:

1. **Update the system**:
   ```bash
   sudo apt update
   ```

2. **Install necessary packages** (like `wget` to download Prometheus):
   ```bash
   sudo apt install wget tar -y
   ```

3. **Download the latest Prometheus release**:
   ```bash
   mkdir -p /tmp/prometheus && cd /tmp/prometheus
   curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest | grep browser_download_url | grep linux-amd64 | cut -d '\"' -f 4 | wget -qi -
   ```

4. **Extract the downloaded file**:
   ```bash
   tar xvf prometheus*.tar.gz
   cd prometheus*/
   ```

5. **Move the Prometheus binaries**:
   ```bash
   sudo mv prometheus promtool /usr/local/bin/
   ```

6. **Create a user and group for Prometheus**:
   ```bash
   sudo useradd --no-create-home --shell /bin/false prometheus
   sudo mkdir /etc/prometheus
   sudo mkdir /var/lib/prometheus
   sudo chown prometheus:prometheus /etc/prometheus
   sudo chown prometheus:prometheus /var/lib/prometheus
   ```

7. **Move the Prometheus configuration files**:
   ```bash
   sudo mv prometheus.yml /etc/prometheus/prometheus.yml
   sudo mv consoles/ console_libraries/ /etc/prometheus/
   ```

8. **Set ownership of the Prometheus files**:
   ```bash
   sudo chown -R prometheus:prometheus /etc/prometheus
   sudo chown -R prometheus:prometheus /var/lib/prometheus
   ```

9. **Create a systemd service file for Prometheus**:
   ```bash
   sudo nano /etc/systemd/system/prometheus.service
   ```
   Then paste the following configuration:
   ```ini
   [Unit]
   Description=Prometheus
   Wants=network-online.target
   After=network-online.target

   [Service]
   User=prometheus
   Group=prometheus
   Type=simple
   ExecStart=/usr/local/bin/prometheus \
       --config.file /etc/prometheus/prometheus.yml \
       --storage.tsdb.path /var/lib/prometheus/ \
       --web.console.templates=/etc/prometheus/consoles \
       --web.console.libraries=/etc/prometheus/console_libraries

   [Install]
   WantedBy=multi-user.target
   ```

10. **Reload systemd to apply the new service**:
    ```bash
    sudo systemctl daemon-reload
    ```

11. **Start Prometheus**:
    ```bash
    sudo systemctl start prometheus
    ```

12. **Enable Prometheus to start on boot**:
    ```bash
    sudo systemctl enable prometheus
    ```

13. **Check the status of Prometheus**:
    ```bash
    sudo systemctl status prometheus
    ```

You should now have Prometheus running on your Ubuntu system. You can access the Prometheus web interface by navigating to `http://localhost:9090` in your web browser.