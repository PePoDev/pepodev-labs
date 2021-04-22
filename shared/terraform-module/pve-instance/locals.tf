locals {
  username    = "pepodev"
  ssh_pubkeys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDbCvyaOwiYaHsBgK7qEFZ92NAd7RiVk8zNxJqQHu2fIj5WEYKIrbQRKpOu62m6clwiXtV1POdw1o3Me3EFcX82+qIVMkepInHZoZmyqM7OEh1diMdw/urbZymy8q0ylPT4Kchuq0nb18M48+yz1Oq0bElfdSsNFtKcQurv6xlIYvVXZrCSr+mdI1R8wn0ravLsz1v/zQWGKy+8+UZCAMlis0w2U66djv70qV7WFngXyBeCe34ThFwPiJa6ol6RU2+MUQcqpdgwxPBblUoJbnj78WadNVboocqfBp97l00E7DZOR3VK436oI4/AgO7u8fuvHzHn01+IBY1UR8wkWeCx pepodev"]

  pve_nameserver     = "10.88.255.254"
  pve_gateway        = "10.88.255.254"
  pve_template_clone = "ubuntu1804-cloudinit-template"
  pve_pool_name      = "thiwanon"

  vsphere_dc_name        = "site2-dc"
  vsphere_cluster_name        = "site2-cluster"
  vsphere_network_name        = "dswitch-internal"
  vsphere_datastore_vsan_name = "esx-vsan-storage"
  vsphere_datastore_ssd_names = ["esx1-ssd-storage","esx2-ssd-storage","esx3-ssd-storage"]
  vsphere_pool_name      = "PePoDev"
  vsphere_template_clone = "ubuntu-18.04-server-cloudimg-amd64"
}
