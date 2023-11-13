resource "proxmox_vm_qemu" "monitoring_instance" {
  name            = "pepo-monitoring-lab-aio"
  vmid            = "88000001"
  desc            = "Monitoring Lab"
  target_node     = "pve1"
  clone           = "ubuntu2004-cloudinit-template"
  full_clone      = true
  pool            = "thiwanon"
  additional_wait = 300
  disk {
    type    = "virtio"
    storage = "pve-nfs"
    size    = "30G"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  cores   = 4
  sockets = 2
  memory  = 4096

  os_type   = "cloud-init"
  ipconfig0 = "ip=10.88.0.1/16,gw=10.88.255.254"

  sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDbCvyaOwiYaHsBgK7qEFZ92NAd7RiVk8zNxJqQHu2fIj5WEYKIrbQRKpOu62m6clwiXtV1POdw1o3Me3EFcX82+qIVMkepInHZoZmyqM7OEh1diMdw/urbZymy8q0ylPT4Kchuq0nb18M48+yz1Oq0bElfdSsNFtKcQurv6xlIYvVXZrCSr+mdI1R8wn0ravLsz1v/zQWGKy+8+UZCAMlis0w2U66djv70qV7WFngXyBeCe34ThFwPiJa6ol6RU2+MUQcqpdgwxPBblUoJbnj78WadNVboocqfBp97l00E7DZOR3VK436oI4/AgO7u8fuvHzHn01+IBY1UR8wkWeCx pepodev@DESKTOP-LFIGO5K
EOF
}

resource "local_file" "monitoring_playbook" {
  content  = <<EOF
---
- hosts: all
  gather_facts: yes
  become: true
  roles:
    - cloudalchemy.node-exporter
EOF
  filename = "${local.temp_dir}/ansible/install-monitoring-aio.yaml"
}

resource "local_file" "monitoring_inventories" {
  content  = <<EOF
---
[all]
node ansible_host=${proxmox_vm_qemu.monitoring_instance.ssh_host}
EOF
  filename = "${local.temp_dir}/ansible/inventories/monitoring.ini"
}

resource "null_resource" "ansible_playbook_run" {
  triggers = {
    inventory_hash     = sha512(local_file.monitoring_playbook.content)
    playbook_file_hash = sha512(local_file.monitoring_inventories.content)
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i ${abspath(path.module)}/${local_file.monitoring_inventories.filename} ${local_file.monitoring_playbook.filename}"
  }
}
