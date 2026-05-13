locals {
  # NV-series = vGPU (GRID driver via Azure extension)
  # NC/ND-series = passthrough (standard cuda-drivers via cloud-init)
  use_grid_driver = startswith(var.vm_size, "Standard_NV")
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = var.vm_size
  admin_username      = var.admin_username

  # Spot VM configuration
  priority        = "Spot"
  max_bid_price   = var.spot_max_price
  eviction_policy = "Deallocate"

  network_interface_ids = [azurerm_network_interface.main.id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    name                 = "${var.vm_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = var.os_disk_size_gb
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  custom_data = base64encode(templatefile("${path.module}/cloud-init.yaml.tpl", {
    admin_username      = var.admin_username
    install_cuda_drivers = !local.use_grid_driver
  }))

  # Disable password auth
  disable_password_authentication = true
}

# ── NVIDIA GRID driver (Azure VM extension) ──
# Only created for NV-series vGPU VMs where standard drivers don't work.
resource "azurerm_virtual_machine_extension" "nvidia_gpu" {
  count                = local.use_grid_driver ? 1 : 0
  name                 = "NvidiaGpuDriverLinux"
  virtual_machine_id   = azurerm_linux_virtual_machine.main.id
  publisher            = "Microsoft.HpcCompute"
  type                 = "NvidiaGpuDriverLinux"
  type_handler_version = "1.9"

  auto_upgrade_minor_version = true
}

# ── Auto-shutdown at 03:00 Oslo time ──
resource "azurerm_dev_test_global_vm_shutdown_schedule" "main" {
  virtual_machine_id = azurerm_linux_virtual_machine.main.id
  location           = azurerm_resource_group.main.location
  enabled            = true

  daily_recurrence_time = var.auto_shutdown_time
  timezone              = var.auto_shutdown_timezone

  notification_settings {
    enabled = false
  }
}
