
There is a high likelihood that the Docker image you need already exists for the application you use in your research. 

Rather than starting from scratch and creating your own *image* from a `Dockerfile`, you should first go searching for one that already exists. This will save you time writing and compiling your own image.

First, you will need to know where to look for existing images. Docker images are hosted across the internet on libraries that are called **Registries**.

!!! Info "Container Terminology"

	- **:octicons-container-16: Container**: when an *image* is run it becomes the *container*; A container shares its kernel with other containers using the same image and each runs as an isolated process on the host. 
    - **:material-archive: Registry**: an online library of container images
    - **:octicons-file-badge-16: Name**: the name of the image
	- **:material-tag: Tag**: identifies exact version of the image, following a `:` in the name. If no tag name is given, by default Docker will assign the ``latest`` tag name to an image.
	- **:material-layers: Layer**: an intermediate image, the result of a single set of build commands. An image is built upon layers starting with a base operating system.
	- **:material-file-edit: Dockerfile**: a text file that contains a list of commands that the Docker daemon calls while creating the layers of an image. 
    - **:material-file: Image**: images are compressed files in a cache on a host and can be built locally or downloaded from a *registry*
	- **:material-file-code: Base image**: has no parent layers, usually base images are a basic Linux operating system like `alpine`, `debian`, or `ubuntu`.
	- **:material-file-tree: Child image**: any image built from a base image that has added layers.
 	- **:material-file-check: Official images**: verified (:material-shield-check:) images hosted on a public container registry. Safe to use, built by the professionals who know them best.
    - **:material-file-star: Publisher image**: certified images that also include support and guarantee compatibility.
	- **:material-file-question: User image**: images created and shared by users like you. Their contents may be a mystery and therefore are not to be trusted. 

---

## Docker Registries

Docker uses the concept of "Registries", online libraries where container images are cached for public utilization.

??? Question "What *EXACTLY* is a Container Registry?"

    A Registry is a storage and distribution system for named Docker images
            
    Organized by owners into "repositories" with compiled *images* that users can download and run 
            
Things you can do with registries:

- Search for public images;
- Pull official images;
- Host and share private images;
- Push your images.

You must have an account on each registry in order to create repositories and to host your own images.

- You can create multiple repositories; 
- You can create multiple tagged images in a repository;
- You can set up your own private registry using a *Docker Trusted Registry*.

---

## Search image registries

!!! Warning 

    Only use images from trusted sources or images for which you can see the `Dockerfile`. Any image from an untrusted source could contain something other than what's indicated. If you can see the Dockerfile you can see exactly what is in the image.

Docker looks into the [Docker Hub](https://hub.docker.com/) public registry by default. 

Examples of public/private registries to consider for your research needs:

| Registry Name | Container Types |
|---------------|-----------------|
| [:material-docker: Docker Hub](https://hub.docker.com/) | Official Images for Docker |
| [:material-aws: Amazon Elastic Container Registry](https://aws.amazon.com/ecr/) | run containers on AWS |
| [:material-google-cloud: Google Container Registry](https://cloud.google.com/container-registry) | run containers on Google Cloud | 
| [:material-microsoft-azure: Azure Container Registry](https://docs.microsoft.com/en-us/azure/container-registry/) | run containers on Azure |
| [:material-graph: NVIDIA GPU Cloud](https://www.nvidia.com/en-us/gpu-cloud/) | containers for GPU computing |
| [:material-github: GitHub Container Registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry) | managed containers on GitHub |
| [:material-gitlab: GitLab Container Registry](https://docs.gitlab.com/ee/user/packages/container_registry/) | managed containers on GitLab | 
| [:material-redhat: RedHat Quay.io](https://cloud.redhat.com/products/quay) | containers managed by RedHat |
| [:material-dna: BioContainers Registry](https://biocontainers.pro/) | bioinformatics containers

### :material-docker: DockerHub

Docker Hub is a service provided by Docker for finding and sharing container images with your team. Docker Hub is the most well-known and popular image registry for Docker containers.

!!! Info

	- **Registry**: a storage and distribution system for named Docker images
	- **Repository**: collection of "images" with individual "tags".
   	- **Teams & Organizations:** Manages access to private repositories.
	- **Builds:** Automatically build container images from GitHub or Bitbucket on the Docker Hub.
    - **Webhooks:** Trigger actions after a successful push to a repository to integrate Docker Hub with other services.

### :material-dna: BioContainers

BioContainers is a community-driven project that provides the infrastructure and basic guidelines to create, manage and distribute bioinformatics containers with **special focus in proteomics, genomics, transcriptomics and metabolomics**. BioContainers is based on the popular frameworks of Docker.

Although anyone can create a BioContainer, the majority of BioContainers are created by the Bioconda project. Every Bioconda package has a corresponding BioContainer available at Quay.io.

### :material-redhat: RedHat Quay.io 

Quay is another general image registry. It works the same way as Docker Hub. However, Quay is home to all BioContainers made by the Bioconda project. Now we will find a BioContainer image at Quay, pull that image and run it on cloud virtual machine.

### :material-graph: NVIDIA GPU Cloud

NVIDIA is one of the leading makers of graphic processing units (GPU). GPU were established as a means of handling graphics processing operations for video cards, but have been greatly expanded for use in generalized computing applications, Machine Learning, image processing, and matrix-based linear algebras.

NVIDIA have created their own set of Docker containers and Registries for running on CPU-GPU enabled systems.

- [NVIDIA-Docker](https://github.com/NVIDIA/nvidia-docker) runs atop the NVIDIA graphics drivers on the host system, the NVIDIA drivers are imported to the container at runtime.
- [NVIDIA Docker Hub](https://hub.docker.com/u/nvidia) hosts numerous NVIDIA Docker containers, from which you can build your own images.
- [NVIDIA GPU Cloud](https://ngc.nvidia.com) hosts numerous containers for HPC and Cloud applications. You must register an account with them (free) to access these. 

NVIDIA GPU Cloud hosts three [registry spaces](https://docs.nvidia.com/ngc/ngc-user-guide/ngc-spaces.html#ngc-spaces){target=_blank}

  - `nvcr.io/nvidia` - catalog of fully integrated and optimized deep learning framework containers.
  - `nvcr.io/nvidia-hpcvis` - catalog of HPC visualization containers (beta).
  - `nvcr.io/hpc` -  popular third-party GPU ready HPC application containers.

NVIDIA Docker can be used as a base-image to create containers running graphical applications remotely. High resolution 3D screens are piped to a remote desktop platform.