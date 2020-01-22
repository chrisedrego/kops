#!/bin/sh

trail="kops create cluster "

#Functions
find_stable_release () {
    link='https://storage.googleapis.com/kubernetes-release/release/stable.txt'
    stable_release=$(curl -s $link)
}

kubernetes_version () {
    find_stable_release
    echo "Current Stable Kubernetes version: "$stable_release
    echo "Do you want to use $stable_release version (y), or specify a version of your choice (n) ?"
    read stable_version_confirm
    if [ "$stable_version_confirm" = "y" ]
    then
        kubernetes_ver=$stable_release
    else
        echo "Specify a different Version of your choice."
        read kubernetes_ver
    fi
    echo $kubernetes_ver
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
    target_type=''
    echo "Target helps to specify the template that can be output after the resource is created"
    echo "Options:\t\t direct, terraform, cloudformation\t(Default to direct)"
    echo "Do you want to specify any other type(y) OR go with the default.(n)"
    read option_target
    if [ "$option_target" = "y" ]
    then
        echo "Specify the Target Type"
        read target_type
    else
        target_type=''
    fi
    echo $target_type
}

defaults_params () {
    clusterdetails=""
    echo "Name of the Cluster: (Default: $clustername)"
    read l_clustername
    if [ "$l_clustername" = "" ]
    then
        l_clustername=$clustername
        clusterdetails=" --name=$l_clustername"
    fi

    statedetails=""
    echo "Specify the State Store: (Default: $statestore)"
    read l_statestore
    if [ "$l_statestore" = "" ]
    then
        l_statestore=$statestore
        statedetails=" --state=$l_clustername"
    fi

    #Node Count Details
    node_count_details=""
    echo "Specify the Node Count. (Default: $node_count)"
    read l_node_count
    if [ "$l_node_count" = "" ]
    then
        l_node_count=$node_count
        node_count_details=" --node-count=$l_node_count"
    fi

    #Node Size Details
    node_size_details=""
    echo "Specify the Node Size. (Default: $node_size)"
    read l_node_size
    if [ "$l_node_size" = "" ]
    then
        l_node_size=$node_size
        node_size_details=" --node-size=$l_node_size"
    fi

    #Node Tenancy Details
    node_tenancy_details=""
    echo "Specify the Node Tenancy. (Default: $node_tenancy)"
    read l_node_tenancy
    if [ "$l_node_tenancy" = "" ]
    then
        l_node_tenancy=$node_tenancy
        node_tenancy_details=" --node-tenancy=$l_node_tenancy"
    fi

    #Node Security Groups
    node_sg_details=""
    sg_names=""
    echo "Do you want to provide the details for Node's Security Groups (y or n) ?"
    read node_sg_choice
    if [ "$node_sg_choice" = "y" ]
    then
        echo "Specify the name of the security Groups"
        read sg_names
        node_sg_details=" --node-security-groups=$sg_names"
    fi

    #Node Volumes Size (int32)
    node_volume_size_details=""
    echo "Do you want to provide the details for Node's Volume Size (y or n) ?"
    read node_volume_choice
    if [ "$node_volume_choice" = "y" ]
    then
        echo "Specify the Size of the Volumes for the Nodes"
        read node_volume_size
        node_volume_size_details=" --node-volume-size=$node_volume_size"
    fi

    # Master Configuration
    # Master Count Details
    master_count_details=""
    echo "Specify the Master Count. (Default: $master_count)"
    read l_master_count
    if [ "$l_master_count" = "" ]
    then
        l_master_count=$master_count
        master_count_details=" --master-count=$l_master_count"
    fi

    #Master Size Details
    master_size_details=""
    echo "Specify the Master Size. (Default: $master_size)"
    read l_master_size
    if [ "$l_master_size" = "" ]
    then
        l_master_size=$master_size
        master_size_details=" --node-size=$l_master_size"
    fi

    # Master Security Groups
    master_sg_details=""
    sg_names=""
    echo "Do you want to provide the details for Master's Security Groups (y or n) ?"
    read node_sg_choice
    if [ "$node_sg_choice" = "y"]
    then
        echo "Specify the name of the security Groups"
        read sg_names
        node_sg_details=" --master-security-groups=$sg_names"
    fi

    #Master Tenancy Details
    master_tenancy_details=""
    echo "Specify the Master Size. (Default: $master_tenancy)"
    read l_master_tenancy
    if [ "$l_master_tenancy" = "" ]
    then
        l_master_tenancy=$node_tenancy
        master_tenancy_details=" --master-tenancy=$l_master_tenancy"
    fi

    #Master Volume Size Details
    master_volume_size_details=""
    echo "Do you want to provide the details for Master's Volume Size (y or n) ?"
    read master_volume_choice
    if [ "$master_volume_choice" = "y" ]
    then
        echo "Specify the Size of the Volumes for the Master"
        read master_volume_size
        master_volume_size_details=" --master-volume-size=$master_volume_size"
    fi

    echo "Specify Cloud Stack: \naws\tgcp\tvsphere\n(Default: aws)"
    read l_cloudstack
    cloudstack=l_cloudstack

    echo "Kubernetes Version"
    kubernetes_version

    echo "Target Options:"
    target_output
    target_valve=""
    if [ "$target_output" = "" ]
    then
        target_valve=""
    else
        target_valve='--target='target_type
    fi
    trail="${trail} --name=$clustername --state=$statestore $target_valve"
    echo $trail
}

defaults_params