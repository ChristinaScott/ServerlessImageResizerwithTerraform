# Configures Terraform to store state remotely in an S3 bucket

terraform {
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "lambda-image-resizer/terraform.tfstate"
    region = "us-east-1"
  }
}