## :material-calendar: Basics

**Dates**: May 12th and 13th 2022

**Time**: 09:00AM–13:00PM  US Pacific Daylight Time (GMT-7)

**Location**: Virtual Zoom

### Day 1 - Introduction to Docker

!!! Example "Activities"

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

!!! Example "Activities"

    | Time (PDT)| Activity | Instructor | Notes | 
    |-----------|----------|------------|-------|
    | 09:00 | Welcome back | All | |
    | 09:05 | Discuss previous day, answer questions | | |
    | 09:15 | [(re)start Dev Environment :material-microsoft-visual-studio-code: :material-github:](../cloud/codespaces.md) | Tyson | |
    | 09:20 | [Finding the right container :material-docker:](../docker/registry.md ) | Tyson | |
    | 09:55 | Break | |
    | 10:00 | [Building Docker Images :material-docker:](../docker/build.md )  | Carlos | |
    | 10:55 | Break | |
    | 11:00 | [Building Docker Images :material-docker:](../docker/build.md ) | Michele | | 
    | 11:55 | Break | | |
    | 12:00 | [Integrating your containers into CyVerse](https://learning.cyverse.org/de/create_apps/){target=_blank} | Tyson | | 
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

## :material-calendar: Advanced

### *Day 0 (2022-05-16) Optional: Container Basics*

*We are offering the Container Basics course in-person on the day before the Advanced Camp begins. Registered Advanced Campers, please contact us if you are interested in attending this optional pre-session.*

### Day 1 (2022-05-17) Continuous Automation

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

**Activity**

- Hands on exercise using SingularityCE in [CodeSpaces](../cloud/codespaces.md)
- Introduction to SingularityCE
- Advanced uses of SingularityCE on HPC/HTC/Cloud
- Guest Speaker(s) TBA

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