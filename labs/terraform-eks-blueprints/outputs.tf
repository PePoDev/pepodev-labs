output "just_nginx" {
  value = "https://hashitalk.${data.aws_route53_zone.aws_pepo_dev.name}"
}
