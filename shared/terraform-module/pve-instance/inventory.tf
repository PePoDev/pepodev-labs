# data "template_file" "k8s_master_hosts" {
#   count    = "${length(module.instances_k8s_master)}"
#   template = "$${hostname} ansible_user=$${host_user} ansible_host=$${host_ip}"

#   vars = {
#     hostname  = "${module.instances_k8s_master[count.index].hostname}"
#     host_ip   = "${module.instances_k8s_master[count.index].ssh_ip}"
#     host_user = "${module.instances_k8s_master[0].ssh_username}"
#   }
# }

# data "template_file" "k8s_worker_hosts" {
#   count    = "${length(module.instances_k8s_worker)}"
#   template = "$${hostname} ansible_user=$${host_user} ansible_host=$${host_ip}"

#   vars = {
#     hostname  = "${module.instances_k8s_worker[count.index].hostname}"
#     host_ip   = "${module.instances_k8s_worker[count.index].ssh_ip}"
#     host_user = "${module.instances_k8s_worker[0].ssh_username}"
#   }
# }

# resource "local_file" "kubespray_inventory" {
#   content  = <<EOF
# [all]
# ${join("\n", data.template_file.k8s_master_hosts.*.rendered)}
# ${join("\n", data.template_file.k8s_worker_hosts.*.rendered)}
# [kube-master]
# ${join("\n", module.instances_k8s_master[*].hostname)}
# [etcd]
# ${join("\n", module.instances_k8s_master[*].hostname)}
# [kube-node]
# ${join("\n", module.instances_k8s_worker[*].hostname)}
# [k8s-cluster:children]
# kube-master
# kube-node
#             EOF
#   filename = "ansible/invnetories/k8s_cluster.ini"

#   depends_on = [module.instances_k8s_masters, module.instances_k8s_workers]
# }
