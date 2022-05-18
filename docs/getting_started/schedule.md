## :material-calendar: Basics

**Dates**: May 12th and 13th 2022

**Time**: 09:00AM–13:00PM  US Pacific Daylight Time (GMT-7)

**Location**: Virtual Zoom

### Day 1 - Introduction to Docker

??? Example "Activities"

    | Time (PDT)| Activity | Instructor | Outcome | 
    |-----------|----------|------------|-------|
    | 09:00 | Welcome | All |
    | 09:05 | Overview of Website | Michele | [Code of Conduct](../getting_started/code_conduct.md) |
    | 09:10 | Why use Containers? | Michael | What containers are used for in science |
    | 09:25 | [Start CodeSpace :material-microsoft-visual-studio-code: :material-github:](../cloud/codespaces.md) | Tyson | Using Dev Environments to create containers|
    | 09:30 | [:material-docker: Docker Commands and Execution](../docker/intro.md#fundamental-docker-commands) | Carlos | Basic command line use of Docker |
    | 09:55 | Break | |
    | 10:00 | [:material-docker: Docker Commands and Execution](../docker/intro.md#fundamental-docker-commands) | Carlos & Tyson | Basic command line use of Docker | 
    | 10:55 | Break | |
    | 11:00 | [:material-docker: Managing Docker and Data](../docker/intro.md#managing-data-in-docker) | Michele | Volumes and Interactive Use inside containers | 
    | 11:55 | Break | | |
    | 12:00 | [:material-docker: Managing Docker and Data](../docker/intro.md)  | Michele & Tyson | | 
    | 12:55 | Conclude for the day | All | push changes to your GitHub |


**Content:**

- Introduction to Docker and its uses in reproducible science 
- Launching development environments on CodeSpaces for container testing
- Using Docker on the commandline.

**Goals:**

- Introduction to containers & [where to find them](../docker/registry.md)
- Command line containers with CodeSpaces (optional: run locally)
- Find and use official Docker images

**Optional Homework:**

- Test other Docker container images on CodeSpaces or locally

### Day 2 (2022-05-13) - Building Docker Containers

??? Example "Activities"

    | Time (PDT)| Activity | Instructor | Notes | 
    |-----------|----------|------------|-------|
    | 09:00 | Welcome back | All | |
    | 09:05 | Discuss previous day, answer questions | | |
    | 09:15 | [(re)start Dev Environment :material-microsoft-visual-studio-code: :material-github:](../cloud/codespaces.md) | Tyson | |
    | 09:20 | [Finding the right container :material-docker:](../docker/registry.md ) | Tyson | |
    | 09:55 | Break | |
    | 10:00 | [Building Docker Images :material-docker:](../docker/build.md )  | Carlos | |
    | 10:55 | Break | |
    | 11:00 | [Using Docker Compose :material-docker:](../docker/compose.md ) | Michele | | 
    | 11:55 | Break | | |
    | 12:00 | [Integrating your Containers into CyVerse](https://learning.cyverse.org/de/create_apps/){target=_blank} | Tyson | | 
    | 12:55 | Conclude | | |


**Activity:**

- [Introduction to Docker :material-docker:](../docker/intro.md) continued
- Hands on exercise using Docker in [:material-microsoft-visual-studio-code: CodeSpaces](../cloud/codespaces.md)

**Content:**

- Use GitHub to browse for public Dockerfiles
- Build Dockerfiles and push them to public registry
- Use Version Control to set up automated container builds with GitHub Actions

**Goals:**

- Introduction to what Dockerfiles are and what you use them for
- Start thinking about how to modify them for your own applications

---

## :material-calendar: Advanced

### *Day 0 (2022-05-16) Optional: Container Basics*

*We are offering the Container Basics course in-person on the day before the Advanced Camp begins. Registered Advanced Campers, please contact us if you are interested in attending this optional pre-session.*

### Day 1 (2022-05-17) Continuous Automation

**Dates**: May 17th 2022

**Time**: 09:00AM–17:00PM  US Pacific Daylight Time (GMT-7)

**Location**: Health Sciences Informatio Building Room 444

<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3374.711519066356!2d-110.94944564904455!3d32.238933218439946!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x86d671a7b5176c53%3A0x67880bc15138eb29!2sHealth%20Sciences%20Innovation%20Building%20(HSIB)!5e0!3m2!1sen!2sus!4v1650459271292!5m2!1sen!2sus" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>

!!! Example "Activities"

    | Time (PDT)| Activity | Instructor | Outcome | 
    |-----------|----------|------------|-------|
    | 09:00 | Welcome | All |
    | 09:05 | Overview of Website | Michele | [Code of Conduct](../getting_started/code_conduct.md) |
    | 09:10 | [:material-microsoft-visual-studio-code:  (re)Start CodeSpace ](../cloud/codespaces.md) | Tyson | Using Dev Environments to create containers|
    | 09:15| [:material-docker: Building Docker images from Dockerfiles (refresh)](../docker/build.md) | Carlos & Michele | Builder Stages, Compose |
    | 09:55 | Break |
    | 10:00 | [:fontawesome-solid-wind: Jetstream-2 Overview](../cloud/js2.md) | Tyson | XSEDE & JS-2 Cloud | 
    | 10:40 | Break | All | Coffee and Snacks in Galley Kitchen |
    | 11:30 | [:fontawesome-solid-wind: Getting Started on Jetstream-2 (Cloud)](../cloud/js2.md) | Tyson | Docker w/ GPUs, X11 | 
    |12:00 | Lunch | | On your own |
    | 13:00 | [:material-github: GitHub Actions](../docker/actions.md)  | Michele & Tyson | Intro to Actions | 
    | 13:55 | Break |  | |
    | 14:00 | [:material-github: GitHub Actions ](../docker/actions.md) | Michele & Tyson | CI/CD with Actions to DockerHub | 
    | 14:40 | Break | | Tea and Snacks in Galley Kitchen|
    | 15:00 | [:material-rocket-launch: Intro to Discovery Environment in CyVerse](https://learning.cyverse.org/de/){target=_blank} | Tyson | |
    | 15:55 | Break | | |
    | 16:00 | [:material-rocket-launch: Create and Deploy Tools and Apps in CyVerse](https://learning.cyverse.org/de/create_apps/){target=_blank} | TBA | || 
    | 16:55 | Conclude for the day | All | Push changes to GitHub, shut down apps |

**Activity:**

- Hands on exercise using Docker in [:material-microsoft-visual-studio-code: CodeSpaces](../cloud/codespaces.md)
- Continuous Integration in GitHub Actions
- Integrate containers into CyVerse Discovery Environment
- Guest Speaker(s) TBA

**Content**

- Introduction to Docker builds from OS base images and when to pursue this.
- Introduction to Docker-Compose
- Using containers on production servers and high performance / high throughput computing environments
- Integration of containers and workflows onto CyVerse Discovery Environment and Jetstream-2

**Goals**

- Understand use cases for building Docker images from the OS
- Setup GitHub Actions for continuous integration of Docker builds
- Familiarize with CyVerse data science workbench

### Day 2 (2022-05-18) - Accelerate Analyses on Cloud and HPC/HTC

!!! Example "Activities"

    | Time (PDT)| Activity | Instructor | Outcome | 
    |-----------|----------|------------|---------|
    | 09:00 | Welcome back | All | |
    | 09:05 | Answer questions about previous day | All |  |
    | 09:10 |  [TACC HPC](https://containers-at-tacc.readthedocs.io/en/latest/singularity/02.singularity_batch.html) | John Fonner | Running Singularity on HPC 
    | 09:55 | Break | |
    | 10:00 | [TACC HPC continued] | | |
    | 10:30 | Break | |
    | 11:00 | [Open Science Grid (OSG)](https://opensciencegrid.org/) | Mats Rynge (USC ISI) | |
    | 12:00 | Lunch | | |
    | 13:00 | [Start CodeSpace :material-microsoft-visual-studio-code: :material-github:](../cloud/codespaces.md) | Tyson | Using Dev Environments to create containers|
    | 13:15 | Intro to Singularity CLI | Tyson | run Singularity commands from the shell | 
    | 13:55 | Break |  | |
    | 14:00 | Writing Singularity files | Tyson | writing Singularity and building .sif images |  
    | 14:30 | Building Singularity on Cloud | Mats | build `*.sif` images on SyLabs.io | 
    | 14:55 | Break | | |
    | 15:00 | BYOC with Singularity (Jetstream-2) |  | | |
    | 15:55 | Break | | |
    | 16:00 |  BYOC cont. | | | | 
    | 16:55 | Conclude for the day | All | push changes to your GitHub |

*  **BYOC = bring your own code**

**Activity**

- Hands on exercise using SingularityCE in [CodeSpaces](../cloud/codespaces.md)
- Introduction to SingularityCE
- Advanced uses of SingularityCE on HPC/HTC/Cloud
- Guest Speaker(s): [Mats Rynge (USC)](https://ci-compass.org/people/mats-rynge/), [John Fonner (TACC)]()

**Content**

- Hands on with SingularityCE. 
- Introduction to distributed computing on the OpenScienceGrid. 
- Introduction to GPU acceleration in containers with official NVIDIA Docker images.

**Goals**

- Introduction to Singularity
- Introduction to OpenScienceGrid (OSG) High Throughput Computing
- Understand OSG applications on CyVerse
- Know where to look for NVIDIA images
- Define use cases for OSG and/or NVIDIA acceleration of analyses

### Day 3 (2022-05-19) - Container Orchestration with Kubernetes

!!! Example "Activities"

    | Time (PDT)| Activity | Instructor | Outcome | 
    |-----------|----------|------------|---------|
    | 09:00 | Welcome back | All | |
    | 09:05 | Answer questions about previous day |  |  |
    | 09:10 |  [Introduction to Kubernetes (K8s)]() | Tyson | 
    | 09:55 | Break | |
    | 10:00 | [Working in K8s]() | Tyson | K3s on JS-2 |
    | 10:45 | Break | |
    | 11:00 | [Deploying containers in K3s]() | | |
    | 12:00 | Lunch | | |
    | 13:00 | [Creating K8s configs] | Tyson | |  
    | 13:55 | Break |  | |
    | 14:00 | [Introduction to CyVerse CACAO] | Edwin | | 
    | 14:55 | Break | | |
    | 15:00 | [Zero to JupyterHub]() |  | | |
    | 15:55 | Break | | |
    | 16:00 |  BYOC () | Tyson | GPU containers in JS-2 | 
    | 16:55 | Conclude workshop | All | |

**Activity**

- Introduction to Orchestration
- Introduction to Kubernetes
- Hands on with Jetstream-2
- BYOC (Build your Own Containers) Hands On time

**Content**

- Managing containers with Kubernetes 
- Working on OpenStack Cloud (Jetstream-2)
- Using Kubernetes to orchestrate containers

**Goals**

- Basic container orchestration
- Allow participants time to create their own containers with support from CyVerse data scientists and software engineers
