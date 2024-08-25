#!/bin/bash

set -euo pipefail

# Function to check if a command is successful
check_command() {
    if [ $? -ne 0 ]; then
        echo "Error executing: $1"
        exit 1
    fi
}

# Disable swap and comment out swap entries in /etc/fstab
disable_swap() {
    echo "Disabling swap..."
    swapoff -a
    check_command "swapoff -a"

    echo "Commenting out swap entries in /etc/fstab..."
    sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
    check_command "sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab"
}

# Install Kubernetes components
install_kubernetes() {
    echo "Updating apt package index and installing necessary packages for Kubernetes..."
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl gnupg
    check_command "apt-get install -y apt-transport-https ca-certificates curl gnupg"

    echo "Downloading and adding Kubernetes public signing key..."
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    check_command "curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg"

    echo "Adding Kubernetes apt repository..."
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
    check_command "echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list"

    echo "Installing Kubernetes components..."
    apt-get update
    apt-get install -y kubelet kubeadm kubectl
    apt-mark hold kubelet kubeadm kubectl
    check_command "apt-get install -y kubelet kubeadm kubectl"

    echo "Enabling kubelet service..."
    systemctl enable --now kubelet
    check_command "systemctl enable --now kubelet"
}

# Install Docker and containerd
install_docker_containerd() {
    echo "Adding Docker's GPG key..."
    apt-get update
    apt-get install -y ca-certificates curl
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc
    check_command "curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc"

    echo "Adding Docker repository..."
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    check_command "echo 'deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable' | tee /etc/apt/sources.list.d/docker.list"

    echo "Installing containerd..."
    apt-get update
    apt-get install -y containerd.io
    check_command "apt-get install -y containerd.io"

    echo "Generating default containerd config..."
    containerd config default > /etc/containerd/config.toml
    check_command "containerd config default > /etc/containerd/config.toml"

    echo "Ensuring SystemdCgroup is set to true..."
    sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
    check_command "sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml"

    echo "Restarting containerd service..."
    systemctl restart containerd
    check_command "systemctl restart containerd"
}

# Install CNI plugins
install_cni_plugins() {
    echo "Fetching and installing latest CNI plugins..."
    LATEST_CNI_VERSION=$(curl -s https://api.github.com/repos/containernetworking/plugins/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
    CNI_TAR="cni-plugins-linux-amd64-${LATEST_CNI_VERSION}.tgz"
    wget https://github.com/containernetworking/plugins/releases/download/${LATEST_CNI_VERSION}/${CNI_TAR}
    check_command "wget https://github.com/containernetworking/plugins/releases/download/${LATEST_CNI_VERSION}/${CNI_TAR}"

    mkdir -p /opt/cni/bin
    tar -C /opt/cni/bin -xzvf ${CNI_TAR}
    check_command "tar -C /opt/cni/bin -xzvf ${CNI_TAR}"

    rm ${CNI_TAR}
}

# Install crictl
install_crictl() {
    echo "Fetching and installing latest crictl..."
    LATEST_CRIC_VERSION=$(curl -s https://api.github.com/repos/kubernetes-sigs/cri-tools/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
    CRICTL_TAR="crictl-${LATEST_CRIC_VERSION}-linux-amd64.tar.gz"
    wget https://github.com/kubernetes-sigs/cri-tools/releases/download/${LATEST_CRIC_VERSION}/${CRICTL_TAR}
    check_command "wget https://github.com/kubernetes-sigs/cri-tools/releases/download/${LATEST_CRIC_VERSION}/${CRICTL_TAR}"

    sudo tar zxvf ${CRICTL_TAR} -C /usr/local/bin
    check_command "sudo tar zxvf ${CRICTL_TAR} -C /usr/local/bin"

    rm -f ${CRICTL_TAR}
}

# Configure crictl
configure_crictl() {
    echo "Configuring crictl..."
    cat <<EOF | sudo tee /etc/crictl.yaml
runtime-endpoint: unix:///run/containerd/containerd.sock
image-endpoint: unix:///run/containerd/containerd.sock
timeout: 2
debug: false
pull-image-on-create: false
EOF
}

# Configure sysctl parameters
configure_sysctl() {
    echo "Configuring sysctl parameters..."
    cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
EOF
    check_command "cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf"

    echo "Applying sysctl parameters..."
    sudo sysctl --system
    check_command "sudo sysctl --system"

    echo "Verifying net.ipv4.ip_forward is set to 1..."
    sysctl net.ipv4.ip_forward
}

# Main execution
main() {
    disable_swap
    install_kubernetes
    install_docker_containerd
    install_cni_plugins
    install_crictl
    configure_crictl
    configure_sysctl
}

main
