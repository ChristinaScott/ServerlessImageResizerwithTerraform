# High-Level Instructions

## Overview
This guide outlines the steps to deploy a serverless image resizing system using AWS services. It includes setting up an S3 bucket, configuring AWS Lambda, and defining permissions with IAM roles.

## Steps

### 1. Create an S3 Bucket
- Log in to AWS Console → Navigate to **S3** → Click **Create Bucket**.
- Choose a unique bucket name and default settings.
- Enable event notifications for the bucket.

### 2. Create an IAM Role for Lambda
- Navigate to **IAM** → Roles → Create Role.
- Choose AWS Lambda as the trusted entity.
- Attach `AmazonS3FullAccess` and `CloudWatchLogsFullAccess` policies.
- Save the role and note its ARN.

### 3. Deploy the Lambda Function
- Write a Python script using Pillow to resize images.
- Package the function and dependencies into a `.zip` file.
- Go to **AWS Lambda** → Create function → Upload the zip file.
- Assign the IAM role created earlier.

### 4. Configure S3 Event Trigger
- In the S3 bucket settings, configure an event trigger.
- Set it to invoke the Lambda function on object upload.

### 5. Test the Setup
- Upload an image to the S3 bucket.
- Verify that the resized image appears in the bucket.
- Check AWS CloudWatch for logs and errors.

### 6. Cleanup
- Remove the Lambda function, S3 bucket, and IAM role to clean up resources.

