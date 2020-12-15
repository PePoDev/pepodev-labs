# resource "null_resource" "kubeconfig" {
#   provisioner "local-exec" {
#     command = "ansible -i ${module.instances_k8s_master[0].ssh_ip}, -b -u ${module.instances_k8s_master[0].ssh_username} -T 300 -m fetch -a 'src=/etc/kubernetes/admin.conf dest=../dev/kubeconfig.yaml flat=yes' all"
#     environment = {
#       ANSIBLE_HOST_KEY_CHECKING = "False"
#       ANSIBLE_NOCOWS            = 1
#     }
#   }

#   provisioner "local-exec" {
#     command = "sed 's/lb-apiserver.kubernetes.local/${module.instances_haproxy[0].ssh_ip}/g' ../dev/kubeconfig.yaml | tee ../dev/kubeconfig.yaml.new && mv ../dev/kubeconfig.yaml.new ../dev/kubeconfig.yaml && chmod 700 ../dev/kubeconfig.yaml"
#   }

#   provisioner "local-exec" {
#     command = "chmod 600 ../dev/kubeconfig.yaml"
#   }

#   depends_on = [null_resource.kubespray_install]
# }
