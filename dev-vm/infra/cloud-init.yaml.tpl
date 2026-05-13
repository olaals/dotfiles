#cloud-config

package_update: true
package_upgrade: true

packages:
  - tmux
  - git
  - curl
  - wget
  - unzip
  - build-essential
  - ca-certificates
  - gnupg
  - lsb-release
  - software-properties-common
  - apt-transport-https

runcmd:
  # ── Neovim (stable PPA, latest stable release) ──
  - add-apt-repository -y ppa:neovim-ppa/stable
  - apt-get update
  - apt-get install -y neovim

  # ── Docker CE (official repo) ──
  - install -m 0755 -d /etc/apt/keyrings
  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  - chmod a+r /etc/apt/keyrings/docker.asc
  - echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" > /etc/apt/sources.list.d/docker.list
  - apt-get update
  - apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  - systemctl enable docker
  - systemctl start docker
  - usermod -aG docker ${admin_username}

  # ── NVIDIA drivers ──
  - apt-get install -y linux-headers-$(uname -r)
  - curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb -o /tmp/cuda-keyring.deb
  - dpkg -i /tmp/cuda-keyring.deb
  - apt-get update
%{ if install_cuda_drivers }
  # Standard NVIDIA driver (passthrough VMs: NC/ND-series)
  - apt-get install -y cuda-drivers
%{ else }
  # GRID driver installed via Azure VM extension (vGPU VMs: NV-series)
  # Only install CUDA toolkit (userspace), driver handled externally
  # Create a systemd oneshot to restart k3s after the GRID driver is installed and VM reboots
  - |
    cat > /etc/systemd/system/nvidia-k3s-restart.service <<'UNIT'
    [Unit]
    Description=Restart k3s after NVIDIA GRID driver becomes available
    After=k3s.service
    Requires=k3s.service
    ConditionPathExists=/usr/bin/nvidia-smi

    [Service]
    Type=oneshot
    ExecStartPre=/bin/bash -c 'until nvidia-smi; do sleep 5; done'
    ExecStart=/bin/systemctl restart k3s
    RemainAfterExit=true

    [Install]
    WantedBy=multi-user.target
    UNIT
  - systemctl daemon-reload
  - systemctl enable nvidia-k3s-restart.service
%{ endif }
  - apt-get install -y cuda-toolkit

  # ── NVIDIA Container Toolkit (GPU in Docker + containerd) ──
  - curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
  - curl -fsSL https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' > /etc/apt/sources.list.d/nvidia-container-toolkit.list
  - apt-get update
  - apt-get install -y nvidia-container-toolkit
  - nvidia-ctk runtime configure --runtime=docker
  - systemctl restart docker

  # ── k3s (no Flannel, no network policy, no Traefik, no servicelb) ──
  - curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC='--flannel-backend=none --disable-network-policy --disable=traefik --disable=servicelb --write-kubeconfig-mode=0644' sh -
  - until k3s kubectl get nodes; do sleep 2; done

  # ── Configure k3s containerd for NVIDIA runtime ──
  - mkdir -p /var/lib/rancher/k3s/agent/etc/containerd
  - nvidia-ctk runtime configure --runtime=containerd --config=/var/lib/rancher/k3s/agent/etc/containerd/config.toml.tmpl --set-as-default
  - systemctl restart k3s
  - until k3s kubectl get nodes; do sleep 2; done

  # ── Helm ──
  - curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

  # ── Cilium CNI via Helm ──
  - ["sh", "-c", "KUBECONFIG=/etc/rancher/k3s/k3s.yaml helm repo add cilium https://helm.cilium.io/"]
  - ["sh", "-c", "KUBECONFIG=/etc/rancher/k3s/k3s.yaml helm repo update"]
  - ["sh", "-c", "KUBECONFIG=/etc/rancher/k3s/k3s.yaml helm install cilium cilium/cilium --namespace kube-system --set ipam.operator.clusterPoolIPv4PodCIDRList=10.42.0.0/16 --set cni.exclusive=false --set kubeProxyReplacement=false --wait --timeout 5m"]
  - k3s kubectl wait --for=condition=Ready node --all --timeout=5m

  # ── NVIDIA device plugin (GPU scheduling in k8s) ──
  - k3s kubectl apply -f https://raw.githubusercontent.com/NVIDIA/k8s-device-plugin/v0.17.0/deployments/static/nvidia-device-plugin.yml

  # ── Istio ambient mode ──
  - ["sh", "-c", "cd /opt && curl -fsSL https://istio.io/downloadIstio | sh -"]
  - ["sh", "-c", "cp /opt/istio-*/bin/istioctl /usr/local/bin/"]
  - ["sh", "-c", "KUBECONFIG=/etc/rancher/k3s/k3s.yaml istioctl install --set profile=ambient --set values.cni.cniConfDir=/etc/cni/net.d --set values.cni.cniBinDir=/opt/cni/bin --skip-confirmation"]
  - k3s kubectl wait --for=condition=Ready pods --all -n istio-system --timeout=5m

  # ── k9s ──
  - curl -fsSL -L "https://github.com/derailed/k9s/releases/latest/download/k9s_linux_amd64.deb" -o /tmp/k9s.deb
  - dpkg -i /tmp/k9s.deb

  # ── Clone dotfiles repo ──
  - su - ${admin_username} -c 'git clone https://github.com/olaals/dotfiles.git /home/${admin_username}/dotfiles'

  # ── OpenCode ──
  - su - ${admin_username} -c 'curl -fsSL https://opencode.ai/install | bash'

  # ── User setup: kubeconfig + aliases ──
  - mkdir -p /home/${admin_username}/.kube
  - cp /etc/rancher/k3s/k3s.yaml /home/${admin_username}/.kube/config
  - chown -R ${admin_username}:${admin_username} /home/${admin_username}/.kube
  - |
    cat >> /home/${admin_username}/.bashrc <<'EOF'
    alias kubectl="k3s kubectl"
    alias k="k3s kubectl"
    export KUBECONFIG=~/.kube/config
    EOF

  # ── Signal cloud-init completion ──
  - touch /var/log/cloud-init-complete

# Reboot to load NVIDIA kernel modules.
# k3s, Cilium, Istio all survive reboot. The NVIDIA device plugin
# pod will retry and succeed once the driver is loaded.
power_state:
  mode: reboot
  message: "Rebooting to load NVIDIA kernel modules"
  timeout: 30
  condition: true

final_message: "Cloud-init completed in $UPTIME seconds"
