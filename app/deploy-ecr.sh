#!/bin/bash
set -e

docker build --platform linux/amd64 -t hello-world-api .

cd ../infrastructure
ECR_REPO=$(terraform output -raw ecr_repository_url)
cd ../app

if [ -z "$ECR_REPO" ]; then
  echo "Error: No ECR repo URL found. Run terraform apply first."
  exit 1
fi

echo "Using ECR repo: $ECR_REPO"

ECR_REGISTRY=$(echo $ECR_REPO | cut -d'/' -f1)
docker tag hello-world-api:latest $ECR_REPO:latest

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_REGISTRY
docker push $ECR_REPO:latest

echo "Done"
