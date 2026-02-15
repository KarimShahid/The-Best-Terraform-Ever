terraform {
  backend "s3" {
    bucket  = "sk-thebest-backnd-ever"
    key     = "servers/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

# Key will be passed via workflow