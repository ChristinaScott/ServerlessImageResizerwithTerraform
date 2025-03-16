# Defines a variable for the S3 bucket name, making it configurable

variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}