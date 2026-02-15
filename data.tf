data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "sk-thebest-backnd-ever"
    key    = "vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

