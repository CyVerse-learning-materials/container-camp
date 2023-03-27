# Creating Terraform Templates on OpenStack

## Overview

This advanced tutorial will guide you through setting up a Terraform project and deploying virtual machines (VMs) with [Docker](https://www.docker.com/){target=_blank} & lightweight Kubernetes ([Rancher K3s](https://www.rancher.com/products/k3s){target=_blank}).

!!! success "Goals"

    :material-play: Understand how to install software and provision multiple VMs

    :material-play: Understand how Terraform is used to orchestrate VMs together

    :material-play: Ability to create a Terraform deployment for a multi-node JupyterHub

    :material-play: Ability to re-provisioning an already deployed cluster on OpenStack through Terraform

    ??? Failure "Things we won't cover"

        :material-play: Basic management of Kubernetes clusters (that is a different lesson)
        
        :material-play: All of Terraform's features

## Prerequisites

* Basic understanding of [:simple-openstack: OpenStack](https://www.openstack.org/){target=_blank} and [:simple-terraform: Terraform](https://terraform-docs.io/){target=_blank} as was covered in the [prior lesson](./terra.md)

* Access to an OpenStack cloud (we will use [Jetstream2](https://docs.jetstream-cloud.org/){target=_blank})

* [:simple-terraform: Terraform](https://developer.hashicorp.com/terraform/downloads){target=_blank} installed on your workstation or local machine

!!! success "Outcomes"

    By the end of this tutorial, you will 
    
    :material-play: have launched a [lightweight Kubernetes (K3s)](https://www.rancher.com/products/k3s){target=_blank} cluster

    :material-play: know how to modify the size of cluster to scale up and down with more or less resources

    :material-play: started and stopped a [JupyterHub](https://jupyter.org/hub){target=_blank} using [a public Docker image](https://hub.docker.com/r/jupyter/datascience-notebook){target=_blank}

## Updating Terraform Configurations

We will re-use our configurations from the [:simple-terraform: Terraform basics lesson](./terra.md)

We will update and append the following files:

`variables.tf` - we are going to be adding new variables to include specific features related to our K3s and JupyterHub

`instances.tf` - we are going to be launching multiple VM flavors to support our cluster. We want the server VM to be large enough to manage all of the JupyterHub worker nodes.

`security.tf` - we need to specify all of the new security and networking settings for K3s and JupyterHub

We will create new configuration files for:

`k3s.tf` - we will keep our Kubernetes (Rancher) configuration files here

`docker.tf` - we will specify the JupyterHub Docker image here

`jupyterhub.tf` - we will configure our JupyterHub here

## :simple-terraform: `instances.tf`

Our new cluster is going to be variably sized, meaning we can re-size or re-scale the number of VMs running in our cluster to account for demand by our users.

```bash

```

##  :simple-terraform: `k3s.tf`

```bash

```

##  :simple-terraform: `docker.tf`

We are going to be using the featured Datascience Latest image from the Project Jupyter team

```bash

```

##  :simple-terraform: `jupyterhub.tf`

```bash

```

##  :simple-terraform: `variables.tf`

```bash

```

## Start the Deployment

```bash

```

## Re-sizing the VMs while the Deployment is running

```bash

```

## Adding / Removing VMs from the cluster while it is running

```bash

```

## Managing the K3s configuration


```bash

```

## Restarting the JupyterHub

