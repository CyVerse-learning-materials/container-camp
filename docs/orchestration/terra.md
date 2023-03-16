# Introduction to Terraform

[:simple-terraform: Terraform](https://www.terraform.io/){target=_blank} is an open-source infrastructure-as-code software tool created by [HashiCorp](https://www.hashicorp.com/){target=_blank}.

Here we will use Terraform to deploy software on virtual machines.

??? Info "What is Infrastructure-as-Code (IaC)?"

    "Infrastructure as code (IaC) is the process of managing and provisioning computer data centers through machine-readable definition files, rather than physical hardware configuration or interactive configuration tools." - [:simple-wikipedia: Wikipedia](https://en.wikipedia.org/wiki/Infrastructure_as_code){target=_blank}

    IaC tools allow you to manage infrastructure with configuration files rather than through a graphical user interface. IaC allows you to build, change, and manage your infrastructure in a safe, consistent, and repeatable way by defining resource configurations that you can version, reuse, and share. -- [:simple-terraform: Terraform Documentation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/infrastructure-as-code){target=_blank}

## Overview

This basic tutorial will guide you through setting up a Terraform project and deploying a simple infrastructure on OpenStack Clouds. By the end of this tutorial, you will have created a VM instance with an associated SSH keypair.

## Pre-requisites

* Basic understanding of [:simple-openstack: OpenStack](https://www.openstack.org/){target=_blank} and virtual machines.
    * An OpenStack cloud ([Jetstream2](https://docs.jetstream-cloud.org/){target=_blank}) with access to the API.
* [:simple-terraform: Terraform](https://developer.hashicorp.com/terraform/downloads){target=_blank} installed on your local machine.
* An SSH key pair to access the VM.

### OpenStack Access

### Terraform installation

Instructions for an Ubuntu 22.04 installation

```bash
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

[:simple-visualstudiocode: VS Code Terraform Extension](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform){target=_blank} - add VS Code extension

## Configuration

Terraform code is written in HCL (Hashicorp Configuration Language), and configuration files typically end in the `.tf` extension. Configurations can either be split into multiple files or maintained in a single file.

### provider.tf

the `provider.tf` is ued to configure the OpenStack or commercial cloud provider:

```javascript
terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.45"
    }
  }
}

provider "openstack" {
  user_name   = var.openstack_user_name
  password    = var.openstack_password
  tenant_name = var.openstack_tenant_name
  auth_url    = var.openstack_auth_url
}
```

### variables.tf

```javascript
variable "openstack_user_name" {
  description = "OpenStack username"
}

variable "openstack_password" {
  description = "OpenStack password"
  sensitive   = true
}

variable "openstack_tenant_name" {
  description = "OpenStack tenant name"
}

variable "openstack_auth_url" {
  description = "OpenStack authentication URL"
}

variable "public_key_path" {
  description = "Path to your public SSH key"
}
```

### main.tf

```javascript
resource "openstack_compute_keypair_v2" "ssh_key" {
  name       = "example_key"
  public_key = file(var.public_key_path)
}

resource "openstack_compute_instance_v2" "example" {
  name            = "example_instance"
  image_name      = "Ubuntu-20.04"
  flavor_name     = "m1.small"
  key_pair        = openstack_compute_keypair_v2.ssh_key.name
  security_groups = ["default"]

  network {
    uuid = var.network_id
  }
}
```

### terraform.tfvars

Add your OpenStack credentials and other required information to terraform.tfvars:

```
openstack_user_name   = "your-openstack-username"
openstack_password    = "your-openstack-password"
openstack_tenant_name = "your-openstack-tenant-name"
openstack_auth_url    = "your-openstack-auth-url"
public_key_path      
```