# kops
Everything about kops

- kops is official and offering from Kubernetes to setup, production grade kubernetes cluster on AWs.
- kops & kubectl both specifically dont do the same job.
- kops is used to build-up kubernetes cluster, while as kubectl is used to provision workload on the existing kubernetes cluster
- kops helps alot in terms of setting up Kubernetes Cluster on AWS
- kops helps setting up a Kubernetes cluster on AKS with ease.
- Kubernetes as a Cluster involves various layers and components, in which we have various nodes/machine which have various components, which together work towards building up Kubernetes, Kubernetes cluster can be deployed on local machine or machine which are present on Cloud vendors like AWS, Microsoft Azure or GCP.
- When Kuberntes CLuster needs to be setup in the cloud let say AWS, on various 
- kops is used to bootstrap and making setting up Kuberntes Cluster easier
- Can be used to Horizontally scale the kubernetes cluster.
- Deploying Kubernetes Cluster to existing VPC or create a new VPC in which we can deploy the Kubernetes Cluster
- Deploy a Single or Mult-Master Kubernetes Cluster.
- Configure Bastion Machine/Jump-Back Machine which allow to SSH into each nodes accordingly.


## Getting Started with KOPS

### Pre-requisites:
- AWS account
- IAM Account with the required permission
- kubectl (Kubernetes Command tool to manage Workloads)
- kops
- AWS CLI tool


### Installed the Required tools on MAC-OS

- Brew Installer 
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
*  After installing Brew, we can go ahead and download the other tools by running the below commands.

- Kubernetes CLI
```
brew install kubectl 
```

- Installing AWS CLI 
https://docs.aws.amazon.com/cli/latest/userguide/install-macos.html

- KOPS CLI

```
brew install kops
```

### Creating IAM User with Required Permission

- Login to AWS Console, and create IAM user with the below mentioned permissions along with grab a hold of Access Key ID, Key to authenticate to AWS CLI.

```
AmazonEC2FullAccess
AmazonRoute53FullAccess
AmazonS3FullAccess
IAMFullAccess
AmazonVPCFullAccess
```






