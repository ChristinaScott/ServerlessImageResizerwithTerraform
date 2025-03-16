# Detailed Instructions

## Prerequisites
- AWS CLI installed and configured
- Terraform installed
- AWS account with appropriate permissions

---

## Step 1: Create an S3 Bucket

### Using AWS Console:
1. Go to **AWS Console** → Navigate to **S3** → Click **Create Bucket**.
2. Choose a **globally unique** bucket name.
3. Click **Create bucket** with default settings.

### Using AWS CLI:
```sh
aws s3 mb s3://your-unique-bucket-name
```

Verify bucket creation:
```sh
aws s3 ls
```

---

## Step 2: Create an IAM Role for Lambda

### Using AWS Console:
1. Navigate to **IAM** → Click **Roles** → Click **Create Role**.
2. Choose **AWS Service** → **Lambda**.
3. Attach policies:
   - `AmazonS3FullAccess`
   - `CloudWatchLogsFullAccess`
4. Click **Create Role** and note the **ARN**.

### Using AWS CLI:
Create the IAM role:
```sh
aws iam create-role --role-name lambda_exec_role --assume-role-policy-document file://trust-policy.json
```

Attach policies:
```sh
aws iam attach-role-policy --role-name lambda_exec_role --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess
aws iam attach-role-policy --role-name lambda_exec_role --policy-arn arn:aws:iam::aws:policy/CloudWatchLogsFullAccess
```

---

## Step 3: Deploy the Lambda Function

### Using AWS Console:
1. Go to **AWS Lambda** → Click **Create Function**.
2. Select **Author from scratch**.
3. Upload the `.zip` file containing `lambda_function.py` and dependencies.
4. Assign the **IAM role** created earlier.

### Using AWS CLI:
Package the function:
```sh
zip lambda_function.zip lambda_function.py
```

Deploy the function:
```sh
aws lambda create-function --function-name ImageResizerFunction \
    --runtime python3.8 \
    --role arn:aws:iam::123456789012:role/lambda_exec_role \
    --handler lambda_function.lambda_handler \
    --zip-file fileb://lambda_function.zip
```

Verify deployment:
```sh
aws lambda list-functions
```

---

## Step 4: Configure S3 Event Trigger

### Using AWS Console:
1. Open **S3 Bucket** → Click **Properties** → Scroll to **Event Notifications**.
2. Create a new event notification.
3. Set **event type** to **PUT (Object Created)**.
4. Choose **Lambda function** as the destination.
5. Save the configuration.

### Using AWS CLI:
```sh
aws s3api put-bucket-notification-configuration --bucket your-unique-bucket-name \
    --notification-configuration file://s3-event.json
```

---

## Step 5: Test the Setup
Upload an image:
```sh
aws s3 cp test-image.jpg s3://your-unique-bucket-name/
```

Check resized images:
```sh
aws s3 ls s3://your-unique-bucket-name/
```

Verify Lambda logs:
```sh
aws logs describe-log-groups
aws logs tail /aws/lambda/ImageResizerFunction --since 1h
```

---

## Step 6: Cleanup

Delete S3 bucket contents:
```sh
aws s3 rm s3://your-unique-bucket-name --recursive
```

Delete S3 bucket:
```sh
aws s3 rb s3://your-unique-bucket-name
```

Delete Lambda function:
```sh
aws lambda delete-function --function-name ImageResizerFunction
```

Detach IAM policies:
```sh
aws iam detach-role-policy --role-name lambda_exec_role --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess
aws iam detach-role-policy --role-name lambda_exec_role --policy-arn arn:aws:iam::aws:policy/CloudWatchLogsFullAccess
```

Delete IAM role:
```sh
aws iam delete-role --role-name lambda_exec_role
```

Confirm cleanup:
```sh
aws s3 ls
aws lambda list-functions
aws iam list-roles
```

---

This document provides detailed step-by-step instructions to deploy, test, and clean up your AWS serverless image resizing setup. 🚀

