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

### Creating IAM User with AWS CLI


```
aws iam create-group --group-name kops

aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonRoute53FullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/IAMFullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess --group-name kops

aws iam create-user --user-name kops

aws iam add-user-to-group --user-name kops --group-name kops

aws iam create-access-key --user-name kops

```


# configure the aws client to use your new IAM user
aws configure           # Use your new access and secret key here
aws iam list-users      # you should see a list of all your IAM users here

# Because "aws configure" doesn't export these vars for kops to use, we export them now
export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)


## Testing the DNS Setup

dig ns subdomain.example.com

## Creating an s3 bucket

aws s3api create-bucket --bucket kubernots --region us-east-1


## Setting up the Cluster.

export NAME=kubernots.deepintent.com.
export KOPS_STATE_STORE=s3://kubernots

# Defines the Size of the Nodes (m4.large)
export NODE_SIZE=${NODE_SIZE:-m4.large}

# Define the Size of the Master
export MASTER_SIZE=${MASTER_SIZE:-m4.large}

# Define Multiple Availibility Zones
export ZONES=${ZONES:-"us-east-1d,us-east-1b,us-east-1c"}

--api-loadbalancer-type - Set the API Loadbalancer type
                            Examples: public or internal.

--authorization -   Used to set the Authorization types
                    AlwaysAllow or RBAC, RBAC is default


--cloud - Defines the cloud provider to use
          Example: aws, gce, vsphere, openstack

--cloud-labels - List of the key,value pair which can be assigned to the resources.

--dns   -   Type of DNS Hosted Zone to use.
            Example: public, private. Default: public


--dns-zone  - Name of the DNS Zone

--dry-run  - its used to go ahead and test what changes will be applied before actually applying the changes to the cluster.
            --dry-run -oyaml
            --dry-run -ojson

--associate-public-ip                           which means assigning public address to the Nodes (master/nodes). Default is true.

--networking 

--topology

--bastion                                       Enable bastion instance group



--master-count                                  Set the number of masters

--master-public-name                            Set the master nodes public name

--master-security-groups                        Set the security group for Master

--master-volume-size int32                      Set instance volume size (in GB) for masters

--master-zones                                  Defines the Zones in which the Master needs to run.

--master-tenancy                                Tenancy of the Master node in AWS, can be default or dedicated.


--node-count int32                              Set the number of nodes

--node-security-groups strings                  Add precreated additional security groups to nodes.

--node-size string                              Set instance size for nodes

--node-tenancy string                           The tenancy of the node group on AWS. Can be either default or dedicated.

--node-volume-size int32                        Set instance volume size (in GB) for node      s      


--network-cidr                                  Setting the Network CIDR block, which will override the default settings.


--image                                         Image to use for all instances


--kubernetes-version                            Kubernetes Version to use


--zones strings                    Zones in which to run the cluster





Example:

kops create cluster  --zones us-west-2a   ${NAME}

kops create cluster --cloud=aws --zones=us-east-1d --name=useast1.k8s.appychip.vpc --dns-zone=appychip.vpc --dns private

kops create cluster  --dns-zone $DNS_NAME $NAME


kops create cluster --name=kubernetes-cluster.example.com  --state=s3://kops-state-1234 --zones=eu-west-1a --node-count=2