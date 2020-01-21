#!/bin/sh

trail = "kops create cluster"

#Functions
find_stable_release () {
    link='https://storage.googleapis.com/kubernetes-release/release/stable.txt'
    stable_release=$(curl -s $link)
    echo $stable_release
}

kubernetes_version () {
    kubernetes_version=find_stable_release
    echo "Current Stable Kubernetes version: "find_stable_release
    echo "Do you want to use this version?"

    if [ "$stable_version_confirm" = "y" ]
    then
        kubernetes_version=find_stable_release
    else
        echo "Specify a different Version of your choice"
        read kubernetes_version
    fi
    kubernetes_version
}

## Default values for the parameters
#generic_values
clustername='devopsbytes'
zones='us-east-1'
statestore='devopsbytes'
kubernetes_version=find_stable_release
target_type='direct'

#node_default_values
node_count=1
node_size="t3.micro"
node_tenancy="default"


#master_default_values
master_count=1
master_security_groups=''
master_zones='us-east-1'


labels_specifier () {
    echo 'Would you like to specify Cloud labels?\ny\tn'
    read labels_opt
    if [ "$labels_opt" = "y" ]
    then
        echo $labels_opt
    fi
}

# labels_specifier

#Mapping Function





target_output () {
    echo "Specifying the targets to output"
    echo "direct, terraform, cloudformation\nDefault to direct"
    read target_type
}

defaults_params (){
    echo "Name of the Cluster"
    read clustername
    echo "Specify the State Store"
    read statestore
    echo "Specify the Node Size"
    read nodesize
    echo "Specify the Node Count"
    read nodecount
    echo "Specify the Master Size"
    read mastersize
    echo "Cloud Stack: \naws\tgcp\tvsphere"
    read cloudstack
    echo "Kubernetes Version"
    kubernetes_version
}