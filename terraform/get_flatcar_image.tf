# get flatcar images from
# https://stable.release.flatcar-linux.net/amd64-usr/current/
# several posibilities:
# iso: flatcar_production_iso_image.iso
# packet flatcar_production_packet_image.bin.bz2
# qemu flatcar_production_qemu_image.img.bz2

resource "null_resource" "flatcar_image" {
  #  triggers = {
  #  on_version_change = "${var.lambda_archive_version}"
  #}

  provisioner "local-exec" {
    command = "curl -o image.img.bz2 https://stable.release.flatcar-linux.net/amd64-usr/current/flatcar_production_qemu_image.img.bz2; bzips -d flatcar_production_qemu_image.img.bz2"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm image.img"
  }
}
