# Setup Dev Environment

## Setting .terraformrc in home directory with content

```terraform
provider_installation {
  filesystem_mirror {
    path    = "/usr/share/terraform/providers"
    include = ["terraform.opsta.com/*/*"]
  }
  direct {
    exclude = ["terraform.opsta.com/*/*"]
  }
}
```
