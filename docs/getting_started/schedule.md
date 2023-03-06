# :material-calendar: Container Camp Basics

**Dates**: Mar 6th-8th 2023

**Time**: 09:00AM–13:00PM  US Mountain Standard Time (8am-12pm PST; 9am-1pm MST/AZ; 10am-2pm CST; 11am-3pm EST)

**Location**: Virtual Zoom

## Day 1 - Introduction to Docker

!!! Note "Content"

        - Introduction to Docker and its uses in reproducible science 
        - Launching development environments on CodeSpaces for container testing
        - Using Docker on the commandline.

!!! Success "Goals"

        - Introduction to containers & [where to find them](../docker/registry.md)
        - Command line containers with CodeSpaces (optional: run locally)
        - Find and use official Docker images

???+ Example "Activities"

    | Time (MST/AZ)| Activity | Instructor | Outcome | 
    |-----------|----------|------------|-------|
    | 09:00 | Welcome | All |
    | 09:05 | Overview of Website | Michele | [Code of Conduct](../getting_started/code_conduct.md) |
    | 09:10 | Why use Containers? | Carlos | What containers are used for in science |
    | 09:25 | [Start CodeSpace :material-microsoft-visual-studio-code: :material-github:](../cloud/codespaces.md) | Tyson | Using Dev Environments to create containers|
    | 09:30 | [:material-docker: Docker Commands and Execution](../docker/intro.md#fundamental-docker-commands) | Carlos | Basic command line use of Docker |
    | 09:55 | Break | |
    | 10:00 | [:material-docker: Docker Commands and Execution](../docker/intro.md#fundamental-docker-commands) | Carlos & Tyson | Basic command line use of Docker | 
    | 10:55 | Break | |
    | 11:00 | [:material-docker: Managing Docker and Data](../docker/intro.md#managing-data-in-docker) | Michele | Volumes and Interactive Use inside containers | 
    | 11:55 | Break | | |
    | 12:00 | [:material-docker: Managing Docker and Data](../docker/intro.md)  | Michele & Tyson | | 
    | 12:55 | Conclude for the day | All | push changes to your GitHub |

!!! Warning "Optional Homework"

        - Test other Docker container images on CodeSpaces or locally

## Day 2 - Building Docker Containers

!!! Note "Content"

        - Use GitHub to browse for public Dockerfiles
        - Build Dockerfiles and push them to public registry
        - Use Version Control to set up automated container builds with GitHub Actions

!!! Success "Goals"

        - Introduction to what Dockerfiles are and what you use them for
        - Start thinking about how to modify them for your own applications

???+ Example "Activities"

    | Time (MST/AZ)| Activity | Instructor | Notes | 
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

## Day 3 - Singularity, Orchestration, and Containers on the HPC

!!! Note "Content"

        - Introduction to Singularity
        - Introduction to Kubernetes

!!! Success "Goals"

        - Being able to execute containers on the HPC
        - Create a small Kubernetes cluster

??? Example "Activities"

    | Time (MST/AZ)| Activity | Instructor | Notes | 
    |-----------|----------|------------|-------|
    | 09:00 | Welcome back | All | |
    | 09:05 | Discuss previous day, answer questions | | |
    | 09:15 | [(re(re))start Dev Environment :material-microsoft-visual-studio-code: :material-github:](../cloud/codespaces.md) | Tyson | |
    | 09:20 | "Obtaining" Singularity | |
    | 09:30 | Obtaining Singularity Images | |
    | 09:55 | Break | |
    | 10:00 | Singularity Commands & Interacting with Singularity Images | |
    | 10:55 | Break ||
    | 11:00 | Running Singularity on the HPC | |
    | 11:55 | Break ||
    | 12:00 | Questions, inquiries | |
    | 12:55 | Conclude | |