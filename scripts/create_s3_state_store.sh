#!/bin/sh
BUCKET_NAME='didevops-state-store'
REGION='us-east-1'
aws s3api create-bucket --bucket $BUCKET_NAME --region $REGION

aws s3api put-bucket-versioning --bucket $BUCKET_NAME  --versioning-configuration Status=Enabled

aws s3api put-bucket-encryption --bucket $BUCKET_NAME --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'
