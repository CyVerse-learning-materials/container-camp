# Creating Terraform Templates on OpenStack

## Overview

This advanced tutorial will guide you through setting up a Terraform project and deploying virtual machines (VMs) with [Docker](https://www.docker.com/){target=_blank} & lightweight Kubernetes ([Rancher K3s](https://www.rancher.com/products/k3s){target=_blank}).

!!! success "Goals"

    :material-play: Understand select terraform advanced language concepts by orchestrating Docker containers

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

    :material-play: have used Terraform to manage Docker containers
    
    :material-play: have launched a [lightweight Kubernetes (K3s)](https://www.rancher.com/products/k3s){target=_blank} cluster

    :material-play: know how to modify the size of cluster to scale up and down with more or less resources

    :material-play: started and stopped a [JupyterHub](https://jupyter.org/hub){target=_blank} using [a public Docker image](https://hub.docker.com/r/jupyter/datascience-notebook){target=_blank}

## Using a Terraform to simply manage Docker

We will use VMs with Docker installed and learn how to launch containers in a declarative way, rather than using the `docker` command. Once you gain access to your VM, perform the following steps

1. ssh into your VM (alternatively, you can declare use the Docker Terraform provider using ssh access)

2. `git clone https://gitlab.com/stack0/terraform-docker-helloworld.git`

3. `cd terraform-docker-hellow-world`

4. Review `input.tf`, `main.tf`, and `terraform.tfvars.example` to get a sense of how to manage a Docker container using Terraform
    1. Review the concept of a Terraform `resource`
    2. How many resources are created?
    3. What is the relationship between the resources?
    4. Is there any question that comes to mind about the port property of `docker_container` resource

5. `cp terraform.tfvars.example terraform.tfvars`

6. edit `terraform.tfvars`
    1. feel free to edit the `image` or `container_name` with a container you prefer, but if you do, please select a container with a port that you can access
    2. if you are using local docker access, use the default value; if you are accessing the docker host remotely, use the string "ssh://myuser@1.2.3.4", where `myuser` is replaced with your vm username and `1.2.3.4` is replaced with your vm's ip address

7. `terraform apply -auto-approve`

??? success "Expected Response"

    ```bash
    Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
    symbols:
    + create

    Terraform will perform the following actions:

    # docker_container.mycontainer will be created
    + resource "docker_container" "mycontainer" {
        + attach                                      = false
        + bridge                                      = (known after apply)
        + command                                     = (known after apply)
        + container_logs                              = (known after apply)
        + container_read_refresh_timeout_milliseconds = 15000
        + entrypoint                                  = (known after apply)
        + env                                         = (known after apply)
        + exit_code                                   = (known after apply)
        + hostname                                    = (known after apply)
        + id                                          = (known after apply)
        + image                                       = (known after apply)
        + init                                        = (known after apply)
        + ipc_mode                                    = (known after apply)
        + log_driver                                  = (known after apply)
        + logs                                        = false
        + must_run                                    = true
        + name                                        = "edwins-container"
        + network_data                                = (known after apply)
        + read_only                                   = false
        + remove_volumes                              = true
        + restart                                     = "no"
        + rm                                          = false
        + runtime                                     = (known after apply)
        + security_opts                               = (known after apply)
        + shm_size                                    = (known after apply)
        + start                                       = true
        + stdin_open                                  = false
        + stop_signal                                 = (known after apply)
        + stop_timeout                                = (known after apply)
        + tty                                         = false
        + wait                                        = false
        + wait_timeout                                = 60
        }

    # docker_image.mydocker will be created
    + resource "docker_image" "mydocker" {
        + id          = (known after apply)
        + image_id    = (known after apply)
        + name        = "nginx:latest"
        + repo_digest = (known after apply)
        }

    Plan: 2 to add, 0 to change, 0 to destroy.
    docker_image.mydocker: Creating...
    docker_image.mydocker: Creation complete after 3s [id=sha256:89da1fb6dcb964dd35c3f41b7b93ffc35eaf20bc61f2e1335fea710a18424287nginx:latest]
    docker_container.mycontainer: Creating...
    docker_container.mycontainer: Creation complete after 1s [id=54f9987cde7fe5b474348ca3e89955c24eb076d6d4ea49aee7e44928f3f8e711]

    Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
    ```

## Increasing the number of containers using count

We will next update Terraform to create multiple containers of the same image.

1. Modify the `input.tf` with a new variable

    ```
    variable "num_containers" {
        type = number
        description = "number, number of containers to launch"
        default = 1
    }
    ```
2. Modify the `main.tf` with the following changes in red:

    <PRE><CODE>
    resource "docker_container" "mycontainer" {
        <SPAN style="color:red">count = var.num_containers</SPAN>
        image = docker_image.mydocker.image_id
        <SPAN style="color:red">name = "\${format("%s%02d", var.container_name, count.index)}"</SPAN>
        ports {
            internal = 80
            <SPAN style="color:red">external = "\${8080 + count.index}" # illustrates using count.index to indicate which port to use</SPAN>
        }
    }

    <SPAN style="color:red">output "docker_containers" {
        value = keys({
            for index, d in docker_container.mycontainer.* : "${format("%s,%s,%s", index, d.name,d.id)}" => d
        })
    }</SPAN>
    </CODE></PRE>

3. Edit your `terraform.tfvars` to include a new `num_containers` input with a reasonable number of containers
4. `terraform apply -auto-approve`
5. Notice some pieces of the codes that were introduced
    1. What is the `count.index`?
    2. What is the format function and why use it?
    3. What will index start at?
    4. Terraform supports math operations
    5. An example of using the keys() method and ad hoc dictionary construction
    
## Increasing the number of containers using for_each

Next we will create multiple docker containers, but using a different method, `for_each`.

1. copy `input.tf`, `main.tf` from `01b-multiple-containers` (overwrite your existing files)
    1. review the differences in `input.tf`
    2. review the differences in `main.tf`
2. remove the `num_containers` from your `terraform.tfvars` and add a new variable called `containers_map`, something like
```
containers_map={
    cat = 8080,
    dog = 8090,
    bird = 9090,
    cow = 9080,
    horse = 9070
}
```
3. `terraform apply -auto-approve`
4. Notice some pieces of the codes that were introduced
    1. Notice the declaration of a `map`, the default value, and how to set it in `terraform.tfvars`
    2. Map keys do not need quoting. What about values?
    3. How would you compare the how ports are configured in between the use of `count` and `for_each`
    4. Why might you use `count` and `for_each`


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

