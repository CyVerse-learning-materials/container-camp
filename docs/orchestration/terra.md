# Introduction to Terraform

[:simple-terraform: Terraform](https://www.terraform.io/){target=_blank} is an open-source infrastructure-as-code (IaC) software tool created by [HashiCorp](https://www.hashicorp.com/){target=_blank}.

??? Info "What is Infrastructure-as-Code (IaC)?"

    "Infrastructure as code (IaC) is the process of managing and provisioning computer data centers through machine-readable definition files, rather than physical hardware configuration or interactive configuration tools." - [:simple-wikipedia: Wikipedia](https://en.wikipedia.org/wiki/Infrastructure_as_code){target=_blank}

    IaC tools allow you to manage infrastructure with configuration files rather than through a graphical user interface. IaC allows you to build, change, and manage your infrastructure in a safe, consistent, and repeatable way by defining resource configurations that you can version, reuse, and share. -- [:simple-terraform: Terraform Documentation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/infrastructure-as-code){target=_blank}

## Overview

This basic tutorial will guide you through setting up a Terraform project and deploying virtual machines (VMs) as infrastructure on OpenStack Clouds.  

By the end of this tutorial, you will have created a VM instance with an associated SSH keypair.

!!! Success "Goals"

    :material-play: Understand orchestration for deployment to OpenStack cloud (Jetstream2)

    :material-play: Understand the benefits of Terraform

    :material-play: Ability to perform basic deployments on OpenStack using Terraform

    :material-play: Ability to perform provisioning of deployed OpenStack resources through Terraform

    ??? Failure "Things we won't cover"

        :material-play: OpenStack API
        
        :material-play: All of Terraform's features


## Pre-requisites

* Basic understanding of [:simple-openstack: OpenStack](https://www.openstack.org/){target=_blank} and VMs

  * Access to an OpenStack cloud (we will use [Jetstream2](https://docs.jetstream-cloud.org/){target=_blank})

  * Optional: your own allocation to Jetstream2 on [NSF ACCESS-CI](https://allocations.access-ci.org/){target=_blank}

* [:simple-terraform: Terraform](https://developer.hashicorp.com/terraform/downloads){target=_blank} installed on your local machine

* Ability to create an SSH key pair to access the VM

??? Info "Terminology"

    **:material-play: Ansible** - is a suite of software tools that enables infrastructure as code

    **:material-play: Deploy** - to create a cloud resource or software
   
    **:material-play: Infrastructure** - is the collection of hardware and software elements such as computing power, networking, storage, and virtualization resources needed to enable cloud computing

    **:material-play: Orchestration** - is the automated configuring, coordinating, and managing of computer systems and software

    **:material-play: Playbook** - are a list of tasks that automatically execute against a host

    **:material-play: Provision** - making changes to a VM including updating the operating system, installing software, adding configurations

    **:material-play: Terraform** - is an infrastructure as code tool that lets you build, change, and version cloud and on-prem resources safely and efficiently


### Getting onto :simple-openstack: OpenStack Cloud

??? Info "What is OpenStack?"

    [:simple-openstack: OpenStack](https://www.openstack.org/){target=_blank} is an open source cloud computing infrastructure software project and is one of the three most active open source projects in the world.

    OpenStack clouds are managed by individuals and institutions on their own bare-metal hardware. 

[![ACCESS](../assets/terraform/access-logo.svg){width=200}](https://allocations.access-ci.org/){target=_blank} 

If you do not have an account, go to [https://allocations.access-ci.org/](https://allocations.access-ci.org/){target=_blank} and begin the process by requesting an "Explore" start-up allocation. 

ACCESS is the NSF's management layer for their research computing network (formerly called TerraGrid and XSEDE) which includes high performance computing, high throughput computing, and research clouds like Jetstream2. 

[![JS2](../assets/terraform/js2-logo.png){width=200}](https://docs.jetstream-cloud.org/general/access/){target=_blank} 

Jetstream2 is a public research cloud which uses OpenStack as its management layer. 

CyVerse is developing a User Interface for Jetstream2 called [CACAO (Cloud Automation & Continuous Analysis Orchestration)](https://cacao.jetstream-cloud.org/help){target=_blank}. Beneath its hood is Terraform. CACAO can also be used from the CLI (which we will [show in a later lesson](./cacao_terra.md)).

### :simple-terraform: Terraform installation

[:simple-terraform: Official Documentation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-terraform){target=_blank}

??? Tip "Mac OS X Installation"

    Instructions for Mac OS X installation

    If you're on OS X, you can use [brew](https://brew.sh/) to install with the following commands:

    ```bash
    # install terraform -- taken from https://learn.hashicorp.com/tutorials/terraform/install-cli
    brew tap hashicorp/tap && brew install hashicorp/tap/terraform

    # install ansible and jq (for processing terraform's statefile into an ansible inventory)
    brew install ansible jq
    ```

??? Tip "Linux Installation"

    Instructions for Ubuntu 22.04 installation

    ```bash
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install terraform
    ```

    Install Ansible & J Query

    ```bash
    sudo apt-add-repository ppa:ansible/ansible
    sudo apt update & sudo apt install -y ansible jq
    ```

Confirm installation

```bash
terraform
```

## Generate OpenStack credential

Log into OpenStack's Horizon Interface

**Step 1** Log into OpenStack's Horizon Interface and create application credentials

Generate an `openrc.sh` file in Jetstream2 Horizon Interface ([https://js2.jetstream-cloud.org](https://js2.jetstream-cloud.org)), 

Select the "Identity" then "Application Credentials" option in the menu (left side)

Select "+ Create Application Credential" button on right

![create application credential](../assets/terraform/create_app_cred.png)

Give your new credentials a name and description, leave most of the fields blank

![create description application credential](../assets/terraform/description_app_cred.png)

Download the new crededential `openrc.sh` file to your local

!!! Tip "**Important**" 
    
    Do not close the Application Credentials window without copying the `secret` or downloading the `openrc.sh` file.

    ![download credential](../assets/terraform/download_app_cred.png)

## Initialize your Terraform project

```bash
mkdir terraform
cd terraform
terraform init
```

Expected output:

`Terraform initialized in an empty directory!`

`The directory has no Terraform configuration files. You may begin working with Terraform immediately by creating Terraform configuration files.`

### Configurations

Terraform code is written in HCL (Hashicorp Configuration Language), and its configuration files typically end in the `.tf` file extension. 

Configurations can either be split into multiple files or maintained in a single file.

#### File Organization

```css
terraform-project/
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
└── modules/
    ├── network/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── compute/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

**Main Configuration File (`main.tf`):** - contains the primary infrastructure resources and configurations for virtual machines, networks, and storage.

**Variables File (`variables.tf`):** - defines all the input variables used in the configuration. Declare variables with default values or leave them empty for required user input. Include descriptions for each variable to provide context.

**Outputs File (`outputs.tf`):** - defines the outputs Terraform displays after applying the Main and Variables configuration. Includes: IP addresses, DNS names, or information for resources.

**Provider Configuration File (`provider.tf`):** - includes the provider(s) used in the configuration, such as OpenStack (on commerical cloud: Amazon Web Services (AWS), Azure, or Google Cloud Platform(GCP)) along with their authentication and regional settings.

**Modules and Reusable Configurations:** - create separate `.tf` files for reusable modules and configurations. Reuse across multiple projects or within the same project on multiple VMs.


### File Examples

#### `main.tf`

```bash
terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.47.0"
    }
  }
}

provider "openstack" { }
```

#### `provider.tf`

the `provider.tf` is ued to configure the OpenStack or commercial cloud provider:

```bash
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

#### `variables.tf`

```bash
variable "vm_number" {
  default = "1"
}

variable "public_key" {
  # replace this with the name of the public ssh key you uploaded to Jetstream 2
  # https://docs.jetstream-cloud.org/ui/cli/managing-ssh-keys/
  default = "!!! REPLACE WITH YOUR SSH PUBLIC KEY NAME"
}

variable "image_id" {
  # replace this with the image id of the ubuntu iso you want to use
  default = " !!! REPLACE WITH IMAGE NAME !! "
}

variable "network_id" {
  # replace this with the id of the public interface on JS
  default = "!!! REPLACE WITH INTERFACE !!!"
}
```

#### `terraform.tfvars`

 A `terraform.tfvars` file is used to define the values of input variables. 
 
 It serves as a convenient way to store and manage variable values that you don't want to hardcode in your .tf files or provide via command-line arguments. 
 
 By using a `terraform.tfvars` file, you can easily customize and update the variable values for different environments or scenarios.

 The file should contain key-value pairs, where the key is the variable name and the value is the corresponding variable value. 
 
 The syntax for defining variables in the `terraform.tfvars` file can be either HCL or JSON.

Add your OpenStack credentials and other required information to `terraform.tfvars`:

In HCL:

```bash
openstack_user_name   = "your-openstack-username"
openstack_password    = "your-openstack-password"
openstack_tenant_name = "your-openstack-tenant-name"
openstack_auth_url    = "your-openstack-auth-url"         
```

In JSON:
```json
{
  "openstack_user_name": "your-openstack-username",
  "openstack_password": "your-openstack-password",
  "openstack_tenant_name": "your-openstack-tenant-name",
  "openstack_auth_url": "your-openstack-auth-url"
}         
```

When you run `terraform apply` or `terraform plan`, Terraform will automatically load the values from the `terraform.tfvars` file if it exists in the working directory. 

You can also create multiple `.tfvars` files and specify which one to use by passing the `-var-file` flag when executing Terraform commands:

```bash
terraform apply -var-file="custom.tfvars"
```

## Commands

### :simple-terraform: init

[`terraform init`](https://developer.hashicorp.com/terraform/cli/commands/init) - initializes a working directory containing terraform files

### :simple-terraform: apply

[`terraform apply`]

### :simple-terraform: destroy

### :simple-terraform: plan
