# Serverless Image Resizing with AWS Lambda & S3

## Overview
This project provides a serverless image resizing solution using AWS Lambda and S3. When an image is uploaded to an S3 bucket, a Lambda function automatically resizes it and stores the modified image in the same bucket.

## Prerequisites
- AWS CLI installed & configured
- Terraform installed
- An AWS account with permissions to create S3, Lambda, and IAM resources

## Setup Instructions
1. **Clone the repository**
   ```sh
   git clone <repo-url>
   cd <repo-folder>
   ```

2. **Initialize Terraform**
   ```sh
   terraform init
   ```

3. **Apply Terraform configuration**
   ```sh
   terraform apply -auto-approve
   ```
   This will create the necessary S3 bucket, Lambda function, and IAM roles.

4. **Upload an Image to Test**
   ```sh
   aws s3 cp test-image.jpg s3://your-unique-bucket-name/
   ```

5. **Verify the Resized Image**
   After a few seconds, check the S3 bucket for a new resized version of the image.

## Cleanup
To delete all resources:
```sh
terraform destroy -auto-approve
```
This will remove the Lambda function, IAM roles, and S3 bucket (ensure it's empty first).


