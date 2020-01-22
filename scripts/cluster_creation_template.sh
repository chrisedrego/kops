#!/bin/sh   
kops create cluster --name=cluster.di-devops.com \
 --state=s3://di-devops \
 --zones=us-east-1a \
 --node-count=1


# Create a cluster in AWS with HA masters. This cluster
  # has also been configured for private networking in a kops-managed VPC.
  # The bastion flag is set to create an entrypoint for admins to SSH.
  export NODE_SIZE=${NODE_SIZE:-m4.large}
  export MASTER_SIZE=${MASTER_SIZE:-m4.large}
  export ZONES=${ZONES:-"us-east-1d,us-east-1b,us-east-1c"}
  export KOPS_STATE_STORE="s3://my-state-store"
  kops create cluster k8s-clusters.example.com \
  --node-count 3 \
  --zones $ZONES \
  --node-size $NODE_SIZE \
  --master-size $MASTER_SIZE \
  --master-zones $ZONES \
  --networking weave \
  --topology private \
  --bastion="true" \
  --yes

  kops create cluster \ 
    --name=k8s-cluster.di-devops.com \
    --state "s3"
    --zones "us-east-1a" \
    --topology calico \
    --master-count 1 \
    --master-size=t2.micro \
    --master-tenancy=default \
    --node-count 1 \
    --bastion="true" \
    --yes


kops create cluster --name cluster-devops
