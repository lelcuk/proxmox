# Proxmox new VM from iso
# https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/resources/vm_qemu
# ---
#
#
# all the VMs we want to create
variable "vm_config_list" {
    description = "cluster to create."
    type        = map(any)
    default = {
      #  kube-cp-1     = { zone = "pve",  vm_id = "1601"},
      #  kube-cp-2     = { zone = "pve",  vm_id = "1602"},
      #  kube-cp-3     = { zone = "pve2", vm_id = "2601"},
        kube-worker-1 = { zone = "pve",  vm_id = "1603"},
        kube-worker-2 = { zone = "pve2", vm_id = "2602"}
    }
}

resource "proxmox_vm_qemu" "flatcar-vm" {
    for_each = var.vm_config_list 
    
    # VM General Settings
    target_node = each.value.zone
    vmid        = each.value.vm_id
    name        = each.key
    desc        = "just a test"
    iso         = "local:iso/flatcar_production_iso_image.iso"
    bios        = "seabios"
    onboot      = false 
    tablet      = false
    agent       = 0
    

    # VM CPU Settings
    cores   = 4
    sockets = 1
    cpu     = "host"    
    memory  = 4096
    balloon = 1

    # VM Cloud-Init Settings
    os_type = "cloud-init"

    # VM Network Settings
    network {
        bridge = "vmbr100"
        model  = "virtio"
    }

    disk {
        type    = "scsi"
        storage = "local-lvm"
        size    = "40G"
    }

    # Serial is not enabled in flatcar
    #serial {
    #    id   = 0
    #    type = "socket"
    #}

    #    ipconfig0 = "ip=10.10.20.15/24,gw=10.10.10.1"
    #    sshkeys = <<EOF
    #    ${var.vm_ssh_key}
    #    EOF

}
