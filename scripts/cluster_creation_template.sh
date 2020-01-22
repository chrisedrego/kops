#!/bin/sh
kops create cluster --name=cluster.di-devops.com \
 --state=s3://di-devops \
 --zones=us-east-1a \
 --node-count=1

kops create cluster --name=cluster.di-devops.com \
--state=s3://di-devops \
--zones=us-east-1a \
--node-count=1


