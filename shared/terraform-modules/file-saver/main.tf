locals {
  main_path   = "${path.module}/${var.main_dir}/${terraform.workspace}"
  target_path = var.project == "" ? "${local.main_path}" : "${local.main_path}/${var.project}"
}

resource "local_file" "this" {
  filename = "${local.target_path}/${var.key}"
  content  = var.content
}
