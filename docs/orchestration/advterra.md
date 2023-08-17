# Creating Terraform Templates on OpenStack

## Overview

This advanced tutorial will guide you through setting up a Terraform project with [Docker](https://www.docker.com/){target=_blank}.

!!! success "Goals"

    material-play: Understand how to use registry.terraform.io

    :material-play: Understand practical terraform advanced language concepts by orchestrating Docker containers

    :material-play: Understand how to install software and provision multiple VMs

    :material-play: Understand how Terraform is used to orchestrate VMs together

    :material-play: Undertand how Terraform is used to create a multi-node JupyterHub

    ??? Failure "Things we won't cover"

        :material-play: Basic management of Kubernetes clusters (that is a different lesson)
        
        :material-play: All of Terraform's features

## Using registry.terraform.io

Terraform maintains an active registry site located at [https://registry.terraform.io](https://registry.terraform.io).

This is the Terraform's defacto catalog for
- providers
- modules
- policies (enforcement rules via Terraform Cloud)
- runtasks (integrations with other services via Terraform Cloud)

Examples of providers:
- https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest
- https://registry.terraform.io/providers/kreuzwerker/docker/latest
- https://registry.terraform.io/providers/hashicorp/kubernetes/latest

## Prerequisites in doing Terraform exercises

* Basic understanding of [:simple-openstack: OpenStack](https://www.openstack.org/){target=_blank} and [:simple-terraform: Terraform](https://terraform-docs.io/){target=_blank} as was covered in the [prior lesson](./terra.md)

* Access to an OpenStack cloud (we will use [Jetstream2](https://docs.jetstream-cloud.org/){target=_blank})

* [:simple-terraform: Terraform](https://developer.hashicorp.com/terraform/downloads){target=_blank} installed on your workstation or local machine

!!! success "Outcomes"

    By the end of this tutorial, you will 

    :material-play: have used Terraform to manage Docker containers while learning advanced Terraform concepts

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
8. `terraform destroy -auto-approve`

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
3. Edit your `terraform.tfvars` to include a new `num_containers` input variable with a value `5`
4. `terraform apply -auto-approve`
??? success "Expected Response"

    ```bash
    $ terraform apply -auto-approve

    Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
    + create

    Terraform will perform the following actions:

    # docker_container.mycontainer[0] will be created
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
        + name                                        = "mycontainer00"
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

        + ports {
            + external = 8080
            + internal = 80
            + ip       = "0.0.0.0"
            + protocol = "tcp"
            }
        }

    # docker_container.mycontainer[1] will be created
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
        + name                                        = "mycontainer01"
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

        + ports {
            + external = 8081
            + internal = 80
            + ip       = "0.0.0.0"
            + protocol = "tcp"
            }
        }

    # docker_container.mycontainer[2] will be created
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
        + name                                        = "mycontainer02"
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

        + ports {
            + external = 8082
            + internal = 80
            + ip       = "0.0.0.0"
            + protocol = "tcp"
            }
        }

    # docker_container.mycontainer[3] will be created
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
        + name                                        = "mycontainer03"
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

        + ports {
            + external = 8083
            + internal = 80
            + ip       = "0.0.0.0"
            + protocol = "tcp"
            }
        }

    # docker_container.mycontainer[4] will be created
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
        + name                                        = "mycontainer04"
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

        + ports {
            + external = 8084
            + internal = 80
            + ip       = "0.0.0.0"
            + protocol = "tcp"
            }
        }

    # docker_image.mydocker will be created
    + resource "docker_image" "mydocker" {
        + id          = (known after apply)
        + image_id    = (known after apply)
        + name        = "nginx:latest"
        + repo_digest = (known after apply)
        }

    Plan: 6 to add, 0 to change, 0 to destroy.

    Changes to Outputs:
    + docker_containers = (known after apply)
    docker_image.mydocker: Creating...
    docker_image.mydocker: Creation complete after 3s [id=sha256:89da1fb6dcb964dd35c3f41b7b93ffc35eaf20bc61f2e1335fea710a18424287nginx:latest]
    docker_container.mycontainer[1]: Creating...
    docker_container.mycontainer[4]: Creating...
    docker_container.mycontainer[2]: Creating...
    docker_container.mycontainer[0]: Creating...
    docker_container.mycontainer[3]: Creating...
    docker_container.mycontainer[1]: Creation complete after 1s [id=8c80b558394f62fe004ff156fa1fee06ce723f2b0721cfdfd0f4e64fb6fb28f8]
    docker_container.mycontainer[3]: Creation complete after 1s [id=c0bc456f847a4e403ee4bcd133f79a21f22b4ec8f94db8793160b28807789e06]
    docker_container.mycontainer[0]: Creation complete after 1s [id=4ce1d4e0617994ba225701e5e0ef243daa8762968c8d7202be2612ecaeaca064]
    docker_container.mycontainer[2]: Creation complete after 1s [id=36cf1496a418395408a9d5630c8e1cf8b12fa948ab73fe95a3b1a3d8ce767e99]
    docker_container.mycontainer[4]: Creation complete after 1s [id=46ab03a8cd2616f20d34058d20b298df8ecc84bf5e8cfaf8013086f21ba1f501]

    Apply complete! Resources: 6 added, 0 changed, 0 destroyed.

    Outputs:

    docker_containers = [
    "0,mycontainer00,4ce1d4e0617994ba225701e5e0ef243daa8762968c8d7202be2612ecaeaca064",
    "1,mycontainer01,8c80b558394f62fe004ff156fa1fee06ce723f2b0721cfdfd0f4e64fb6fb28f8",
    "2,mycontainer02,36cf1496a418395408a9d5630c8e1cf8b12fa948ab73fe95a3b1a3d8ce767e99",
    "3,mycontainer03,c0bc456f847a4e403ee4bcd133f79a21f22b4ec8f94db8793160b28807789e06",
    "4,mycontainer04,46ab03a8cd2616f20d34058d20b298df8ecc84bf5e8cfaf8013086f21ba1f501",
    ]
    ```
5. Notice some pieces of the codes that were introduced
    1. What is the `count.index`?
    2. What is the format function and why use it?
    3. What will index start at?
    4. Terraform supports math operations
    5. An example of using the keys() method and ad hoc dictionary construction
6. `terraform destroy -auto-approve`

## When resources change outside of Terraform

In this exercise we'll discover how to use Terraform to handle change.

1. Use `docker stop` and `docker rm` to stop and delete docker containers 2 and 3.
??? success "Expected Response"

    ```bash
    $ docker stop 36cf1496a418395408a9d5630c8e1cf8b12fa948ab73fe95a3b1a3d8ce767e99 c0bc456f847a4e403ee4bcd133f79a21f22b4ec8f94db8793160b28807789e06
    36cf1496a418395408a9d5630c8e1cf8b12fa948ab73fe95a3b1a3d8ce767e99
    c0bc456f847a4e403ee4bcd133f79a21f22b4ec8f94db8793160b28807789e06
    $ docker rm 36cf1496a418395408a9d5630c8e1cf8b12fa948ab73fe95a3b1a3d8ce767e99 c0bc456f847a4e403ee4bcd133f79a21f22b4ec8f94db8793160b28807789e06
    36cf1496a418395408a9d5630c8e1cf8b12fa948ab73fe95a3b1a3d8ce767e99
    c0bc456f847a4e403ee4bcd133f79a21f22b4ec8f94db8793160b28807789e06
    ```
2. Execute a `terraform show` and count the number of instances in the state
3. Execute a `terraform refresh` 
??? success "Expected Response"

    ```bash
    $ terraform refresh
    docker_image.mydocker: Refreshing state... [id=sha256:89da1fb6dcb964dd35c3f41b7b93ffc35eaf20bc61f2e1335fea710a18424287nginx:latest]
    docker_container.mycontainer[3]: Refreshing state... [id=c0bc456f847a4e403ee4bcd133f79a21f22b4ec8f94db8793160b28807789e06]
    docker_container.mycontainer[2]: Refreshing state... [id=36cf1496a418395408a9d5630c8e1cf8b12fa948ab73fe95a3b1a3d8ce767e99]
    docker_container.mycontainer[1]: Refreshing state... [id=8c80b558394f62fe004ff156fa1fee06ce723f2b0721cfdfd0f4e64fb6fb28f8]
    docker_container.mycontainer[4]: Refreshing state... [id=46ab03a8cd2616f20d34058d20b298df8ecc84bf5e8cfaf8013086f21ba1f501]
    docker_container.mycontainer[0]: Refreshing state... [id=4ce1d4e0617994ba225701e5e0ef243daa8762968c8d7202be2612ecaeaca064]

    Outputs:

    docker_containers = [
    "0,mycontainer00,4ce1d4e0617994ba225701e5e0ef243daa8762968c8d7202be2612ecaeaca064",
    "1,mycontainer01,8c80b558394f62fe004ff156fa1fee06ce723f2b0721cfdfd0f4e64fb6fb28f8",
    "2,mycontainer02,36cf1496a418395408a9d5630c8e1cf8b12fa948ab73fe95a3b1a3d8ce767e99",
    "3,mycontainer03,c0bc456f847a4e403ee4bcd133f79a21f22b4ec8f94db8793160b28807789e06",
    "4,mycontainer04,46ab03a8cd2616f20d34058d20b298df8ecc84bf5e8cfaf8013086f21ba1f501",
    ]
    ```
4. Execute a `terraform show` again and recount the instance in the state. Why doesn't the output variable change?
5. Execute a `terraform apply` (without the `-auto-approve`) and review what will be updated. Once you are satisfied with the changes that will happen, enter `yes` at the prompt.
??? success "Expected Response"

    ```bash
    $ terraform apply 
    docker_image.mydocker: Refreshing state... [id=sha256:89da1fb6dcb964dd35c3f41b7b93ffc35eaf20bc61f2e1335fea710a18424287nginx:latest]
    docker_container.mycontainer[0]: Refreshing state... [id=4ce1d4e0617994ba225701e5e0ef243daa8762968c8d7202be2612ecaeaca064]
    docker_container.mycontainer[1]: Refreshing state... [id=8c80b558394f62fe004ff156fa1fee06ce723f2b0721cfdfd0f4e64fb6fb28f8]
    docker_container.mycontainer[4]: Refreshing state... [id=46ab03a8cd2616f20d34058d20b298df8ecc84bf5e8cfaf8013086f21ba1f501]

    Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
    + create

    Terraform will perform the following actions:

    # docker_container.mycontainer[2] will be created
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
        + image                                       = "sha256:89da1fb6dcb964dd35c3f41b7b93ffc35eaf20bc61f2e1335fea710a18424287"
        + init                                        = (known after apply)
        + ipc_mode                                    = (known after apply)
        + log_driver                                  = (known after apply)
        + logs                                        = false
        + must_run                                    = true
        + name                                        = "mycontainer02"
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

        + ports {
            + external = 8082
            + internal = 80
            + ip       = "0.0.0.0"
            + protocol = "tcp"
            }
        }

    # docker_container.mycontainer[3] will be created
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
        + image                                       = "sha256:89da1fb6dcb964dd35c3f41b7b93ffc35eaf20bc61f2e1335fea710a18424287"
        + init                                        = (known after apply)
        + ipc_mode                                    = (known after apply)
        + log_driver                                  = (known after apply)
        + logs                                        = false
        + must_run                                    = true
        + name                                        = "mycontainer03"
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

        + ports {
            + external = 8083
            + internal = 80
            + ip       = "0.0.0.0"
            + protocol = "tcp"
            }
        }

    Plan: 2 to add, 0 to change, 0 to destroy.

    Changes to Outputs:
    ~ docker_containers = [
        - "0,mycontainer00,4ce1d4e0617994ba225701e5e0ef243daa8762968c8d7202be2612ecaeaca064",
        - "1,mycontainer01,8c80b558394f62fe004ff156fa1fee06ce723f2b0721cfdfd0f4e64fb6fb28f8",
        - "2,mycontainer02,36cf1496a418395408a9d5630c8e1cf8b12fa948ab73fe95a3b1a3d8ce767e99",
        - "3,mycontainer03,c0bc456f847a4e403ee4bcd133f79a21f22b4ec8f94db8793160b28807789e06",
        - "4,mycontainer04,46ab03a8cd2616f20d34058d20b298df8ecc84bf5e8cfaf8013086f21ba1f501",
        ] -> (known after apply)

    Do you want to perform these actions?
    Terraform will perform the actions described above.
    Only 'yes' will be accepted to approve.

    Enter a value: 
    ```
6. `terraform destroy -auto-approve`

## Validating your input data

Next we will show how to add validation to your inputs
1. In your `input.tf`, add the following variable
```bash
variable "port_assignment_list" {
  type = list(number)
  description = "list of port assignments, size should = num_containers"
  default = []
  validation {
    condition     = length(var.port_assignment_list) > 0
    error_message = "Port assignment not > 0"
  }
}
```
2. In your `main.tf`, replace your docker_container resource to the following:
```bash
resource "docker_container" "mycontainer" {
  count = var.num_containers
  image = docker_image.mydocker.image_id
  name = "${format("%s%02d", var.container_name, count.index)}"
  ports {
    internal = 80
    external = var.port_assignment_list[count.index] # illustrates using count.index to indicate which port to use
  }
}

```
3. Add/update the following variables in your `terraform.tfvars`
```bash
num_containers=5
port_assignment_list=[]
```
4. `terraform apply -auto-approve`
5. What do you expect?
    - Try updating the condition such that length must equal `num_containers`

Now, let's figure out how to make our validation slightly more useful
1. If necessary, restore your `input.tf` to include the original validation block
```bash
variable "port_assignment_list" {
  type = list(number)
  description = "list of port assignments, size should = num_containers"
  default = []
  validation {
    condition     = length(var.port_assignment_list) > 0
    error_message = "Port assignment not > 0"
  }
}
```
2. Update your `main.tf` to include a validation block like the following:
```bash
resource "docker_container" "mycontainer" {
  count = var.num_containers
  image = docker_image.mydocker.image_id
  name = "${format("%s%02d", var.container_name, count.index)}"
  ports {
    internal = 80
    external = var.port_assignment_list[count.index] # illustrates using count.index to indicate which port to use
  }

  lifecycle {
    precondition {
      condition = length(var.port_assignment_list) == num_containers
      error_message = "length != num_containers"
    }
  }
}
```
3. Update your `terraform.tfvars` with the following settings
```bash
num_containers=5
port_assignment_list=[4040,5050,6060,7070]
```
4. `terraform apply -auto-approve`
5. What do you expect?
    - Try adding another port (or remove a port) so that `num_containers` and the length of the list is equal
6. `terraform destroy -auto-approve`

## Increasing the number of containers using for_each

Next we will create multiple docker containers, but using a different method, `for_each`.

1. copy `input.tf`, `main.tf` from `01c-multiple-containers` (overwrite your existing files)
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
5. `terraform destroy -auto-approve`

## Using dynamic blocks create repeatable nestable blocks in resources

Next we will see an example of resource properties that can be repeated

1. Copy `input.tf`, `main.tf` from `02a-using-ports` (overwrite your existing files)
    2. Review the differences in `main.tf`
2. Edit `input.tf` with a new variable
```bash
variable "container_ports" {
    type = list(object({
      internal=string,
      external=string
    }))
    description = "map(object), port object as defined by https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/container#nestedblock--ports"
    default = []
}
```
3. edit the main.tf with the following `docker_container` resource definition
```bash
resource "docker_container" "mycontainer" {
  image = docker_image.mydocker.image_id
  name  = var.container_name

  dynamic "ports" {
    for_each = var.container_ports
    content {
      internal = ports.value.internal
      external = ports.value.external
    }
  }
}
```
4. Add the following variable in your `terraform.tfvars`
```bash
ports = [
    {internal="80", external="8080"},
    {internal="90", external="9090"}
]
```
4. `terraform apply -auto-approve`
5. Verify the ports were added when you use `docker ps`
6. `terraform destroy -auto-approve`