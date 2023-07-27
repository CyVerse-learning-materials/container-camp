# :material-calendar: Container Camp Basics

## Day 1 - Container Orchestration

!!! abstract "Content"

    * Introduction to Kubernetes
    * K8s CLI
    * Deploying K8s clusters

!!! success "Learning Objectives"

    * Comfort working in the terminal with a remote K8s cluster
    * Understanding of K8s as it is used to manage containers
    * Start your own Zero2JupyterHub

!!! Example "Agenda"

    | Time ([PDT](https://time.is/PDT){target=_blank}) | Activity | Instructor | Outcome | 
    |-----------|----------|------------|-------|
    | 09:00 | Welcome | All |
    | 09:05 | Overview of Website | Michele | [Code of Conduct](../getting_started/code_conduct.md) |
    | 09:10 | What is Kubernetes? | Carlos | overview of K8s ecosystem |
    | 09:30 | [:simple-kubernetes: K8s CLI](../orchestration/k8s.md#introduction-to-k8s-cli-with-kubectl) | Carlos | Basic command line use of K8s |
    | 09:55 | Break | |
    | 10:00 | [:simple-kubernetes: K8s CLI cont.](../orchestration/k8s.md#introduction-to-k8s-cli-with-kubectl) | Carlos & Tyson | Connecting to a K8s cluster | 
    | 10:55 | Break | |
    | 11:00 | [:material-docker: Deploying K8s clusters](../orchestration/advk8s.md) | Michele | Jero2JupyterHub | 
    | 11:55 | Break | | |
    | 12:00 | [:simple-kubernetes: Managing K8s clusters](../orchestration/advk8s.md)  | Michele & Tyson | | 
    | 12:55 | Conclude for the day | All | push changes to GitHub |

??? alert "Homework"

    * Consider what type of hardware & container orchestration you're most interested in and come ready with your own ideas for deploying something with Terraform on Day 2.

## Day 2 - Infrastructure as Code 

!!! abstract "Content"

    * Use Terraform to provision hardware and deploy applications & containers
    * Build Terraform templates

!!! success "Learning Objectives"

    * Understanding of what IaC is and how it fits along with the orchestration of containers and cloud
    * Ability to launch your own cloud instances on at least one cloud platform (OpenStack)
    * Ability to provision your instances with Terraform and access them

!!! Example "Agenda"

    | Time ([PDT](https://time.is/PDT){target=_blank}) | Activity | Instructor | Outcome | 
    |-----------|----------|------------|-------|
    | 09:00 | Welcome back | All | |
    | 09:05 | Discuss previous day, answer questions | | |
    | 09:20 | [:simple-terraform: What is Terraform](../orchestration/terra.md ) | Tyson | |
    | 09:55 | Break | |
    | 10:00 | [:simple-terraform: Terraform CLI](../orchestration/terra.md )  | Carlos | |
    | 10:55 | Break | |
    | 11:00 | [:simple-terraform: Writing Terraform Templates](../orchestration/advterra.md ) | Michele | | 
    | 11:55 | Break | | |
    | 12:00 | [:simple-terraform: Provisioning a K3s Cluster with Terraform](../orchestration/advterra.md) | Tyson | | 
    | 12:55 | Conclude | | |

## Day 3 - CACAO

!!! abstract "Content"

        - Introduction to CyVerse CACAO
        - Writing advanced Terraform templates for CACAO

!!! success "Learning Objectives"

        - Being able to execute containers on the HPC
        - Create a small Kubernetes cluster

!!! example "Agenda"

    | Time ([PDT](https://time.is/PDT){target=_blank}) | Activity | Instructor | Outcome | 
    |-----------|----------|------------|-------|
    | 09:00 | Welcome back | All | |
    | 09:05 | Discuss previous day, answer questions | | |
    | 09:20 | [Introduction to CACAO](../orchestration/cacao.md) | Tyson |
    | 09:30 | [Using the CACAO UI](../orchestration/cacao.md) | Tyson |
    | 09:55 | Break | |
    | 10:00 | [Overview of CACAO templates](../orchestration/cacao_terra.md)| Edwin |
    | 10:55 | Break ||
    | 11:00 |  [Creating a CACAO template](../orchestration/cacao_terra.md) | Edwin |
    | 11:55 | Break ||
    | 12:00 | Show and Tell - present your use cases | everyone |
    | 12:55 | Conclude** | |

    * If we still have time, we will also discuss using [Singularity on the HPC](https://container-camp.cyverse.org/singularity/hpc/#how-do-hpc-systems-fit-into-the-development-workflow).
    ** For additional questions and inquiries, we will make time for one-on-ones on either Thursday or Friday (flexible schedule).
