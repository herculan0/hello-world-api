terraform {
  backend "s3" {
    bucket         = "terraform-state-hello-world-api"
    key            = "hello-world-api/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}