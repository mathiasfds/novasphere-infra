terraform {
  required_version = ">= 1.14"

  backend "s3" {
    bucket       = "novasphere-tfstate-mfe"
    key          = "novasphere/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
