# Dev VM — Azure Spot GPU VM with Terraform

Provisions a **Standard_NV36ads_A10_v5** (NVIDIA A10 GPU) spot VM in Azure Sweden Central using Terraform and cloud-init.

## What gets created

| Resource | Details |
|---|---|
| Resource Group | `rg-dev-vm` in `swedencentral` |
| VNet + Subnet | `10.0.0.0/16` with `10.0.1.0/24` subnet |
| NSG | SSH (port 22) only |
| Public IP | Static, Standard SKU |
| VM | Spot, deallocate on eviction, max $3/hr |
| OS Disk | 256 GB Premium SSD, Ubuntu 24.04 LTS |
| Auto-shutdown | 03:00 Oslo time (Romance Standard Time) |

## Software installed via cloud-init

- tmux
- neovim (stable PPA)
- Docker CE + Docker Compose (official repo)
- NVIDIA drivers + CUDA toolkit
- NVIDIA Container Toolkit (GPU in Docker)
- [dotfiles](https://github.com/olaals/dotfiles) cloned to `~/dotfiles`

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) (`az`)
- [Task](https://taskfile.dev/installation/) (task runner)
- An Azure subscription with quota for `Standard_NV36ads_A10_v5` in Sweden Central
- SSH key pair at `~/.ssh/dev-vm` and `~/.ssh/dev-vm.pub`

## Quick start

```bash
task login       # Log in to Azure (opens Chrome)
task set-sub     # Write current subscription ID to terraform.tfvars
task deploy      # Init + apply (prompts for confirmation)
task connect     # SSH into the VM
```

## All commands

| Command | Description |
|---|---|
| `task login` | Log in to Azure via Chrome |
| `task set-sub` | Write current subscription ID into `terraform.tfvars` |
| `task init` | Run `terraform init` |
| `task deploy` | Init + apply with confirmation prompt |
| `task connect` | SSH into the VM |
| `task ip` | Show the VM's public IP |
| `task teardown` | Destroy all Azure resources and delete local Terraform state |

## Monitor cloud-init progress

Cloud-init runs on first boot and takes roughly 10-15 minutes (NVIDIA drivers are large).

```bash
task connect
tail -f /var/log/cloud-init-output.log
```

Cloud-init is finished when `/var/log/cloud-init-complete` exists:

```bash
ls /var/log/cloud-init-complete
```

## Manage the VM

```bash
# Stop (deallocate) — stops billing for compute
az vm deallocate --resource-group rg-dev-vm --name dev-vm

# Start again
az vm start --resource-group rg-dev-vm --name dev-vm

# Check the current public IP after restart
task ip
```

> The static public IP persists across deallocations, so the IP stays the same.

## Customization

All defaults are in `variables.tf`. Override them in `terraform.tfvars`:

```hcl
subscription_id = "..."
vm_size         = "Standard_NV36ads_A10_v5"
os_disk_size_gb = 256
spot_max_price  = 3.0
admin_username  = "oalstdevvm"
```
