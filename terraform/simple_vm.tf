# Proxmox new VM from iso
# https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/resources/vm_qemu
# ---

resource "proxmox_vm_qemu" "flatcar-vm" {
    
    # VM General Settings
    target_node = "pve2"
    vmid        = "1601"
    name        = "tera-test"
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

    serial {
        id   = 0
        type = "socket"
    }

    #    ipconfig0 = "ip=10.10.20.15/24,gw=10.10.10.1"
    #    sshkeys = <<EOF
    #    ${var.vm_ssh_key}
    #    EOF

}
