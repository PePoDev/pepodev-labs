# data "archive_file" "init" {
#   type        = "zip"
#   source_dir  = "${path.module}/../../environment/dev-infra/tel-k8s-inventory/tel-cluster/group_vars"
#   output_path = "${path.module}/../../environment/dev-infra/output.zip"
# }

# resource "null_resource" "kubespray_install" {
#   triggers = {
#     zip_vars_output_sha = data.archive_file.init.output_sha
#     k8s_inventory       = local_file.kubespray_inventory.id
#   }

#   provisioner "local-exec" {
#     command = "ansible-playbook -i ansible/inventory/k8s.ini ansible/kubespray/cluster.yml -b"
#     environment = {
#       ANSIBLE_HOST_KEY_CHECKING = "False"
#       ANSIBLE_NOCOWS            = 1
#     }
#   }

#   depends_on = [local_file.kubespray_inventory]
# }
