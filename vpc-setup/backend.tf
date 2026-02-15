terraform {
  backend "s3" {
    bucket  = "sk-thebest-backnd-ever"
    key     = "vpc/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
