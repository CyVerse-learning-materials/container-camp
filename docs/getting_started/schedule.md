# Camp Schedule

## :octicons-container-16: Basics

Intro Workshop Days are at the following times: 

09:00AM–13:00PM  US Pacific Daylight Time (12:00PM–16:00PM US Eastern Daylight Time)

Below are the schedule and classroom materials for Container Camp 2022.

This workshop runs under a [Code of Conduct](code_conduct.md)

Please respect it and be excellent to each other!

:material-twitter: Twitter hash tag: #cc2022

### Day 1 (2022-05-12) - Introduction to Docker

**Activity:**

- [Introduction to Docker :material-docker:](../docker/intro.md)
- Hands on exercise using Docker in [:material-microsoft-visual-studio-code: CodeSpaces](../cloud/codespaces.md)

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

## :octicons-container-16: Advanced

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