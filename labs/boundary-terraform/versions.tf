terraform {
  required_providers {
    boundary = {
      source  = "hashicorp/boundary"
      version = "~> 1.0"
    }
  }
}

provider "boundary" {
  addr                            = "https://f762d985-b1ed-4f34-902e-7dc59aeff791.boundary.hashicorp.cloud"
  auth_method_id                  = "ampw_EX8Lg2627R"
  password_auth_method_login_name = "admin"
  password_auth_method_password   = "pepo0616670989"
}
