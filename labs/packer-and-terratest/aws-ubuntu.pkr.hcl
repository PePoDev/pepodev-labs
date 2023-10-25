packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "ubuntu-hirsute" {
  ami_name      = "${var.ami_prefix}-hirsute-${local.timestamp}"
  instance_type = var.instance_type
  region        = var.aws_region

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-hirsute-21.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }

  force_deregister      = false
  force_delete_snapshot = false

  communicator = "ssh"
  ssh_username = "ubuntu"

  tag {
    key   = "Name"
    value = "${var.ami_prefix}-hirsute-${local.timestamp}"
  }
}

build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu-hirsute",
  ]

  provisioner "file" {
    source      = "node-exporter.systemd.service"
    destination = "/tmp/node_exporter.service"
  }

  provisioner "shell" {
    inline = [
      "sudo wget https://github.com/prometheus/node_exporter/releases/download/v${var.node_exporter_version}/node_exporter-${var.node_exporter_version}.linux-amd64.tar.gz",
      "sudo tar -xvf node_exporter*",
      "sudo mv node_exporter*/node_exporter /usr/local/bin",
      "sudo useradd -rs /bin/false node_exporter",
      "sudo rm -rf node_exporter*",

      "sudo mv /tmp/node_exporter.service /etc/systemd/system/node_exporter.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl start node_exporter",
      "sudo systemctl enable node_exporter",
      "sudo systemctl status node_exporter",
    ]
  }

  post-processors {
    post-processor "vagrant" {}
    post-processor "compress" {}
  }

  post-processor "vagrant" {}
}

variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}

variable "instance_type" {
  type    = string
  default = "c4.large"
}

variable "ami_prefix" {
  type    = string
  default = "learn-packer-aws-ubuntu"
}

variable "node_exporter_version" {
  type    = string
  default = "1.3.1"
}
