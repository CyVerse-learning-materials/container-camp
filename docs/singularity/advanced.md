## Building Singularity `.sif` image files

Similar to Docker, which uses a `Dockerfile` to build its images, Singularity uses a file called `Singularity`.

Singularity images use the `.sif` extension and appear as a single compressed file, versus Docker which uses many cached file layers to create a single image. 

### Create a `.sif` image using a Docker image as the template

As we've learned from the HPC and HTC groups, building Singularity images is not always the best practice. Most groups suggest that you build your containers with Docker, and host them on a Docker Registry first.

The market dominance of Docker and its wide acceptance as a container format, has led us to use Singularity in collaboration with Docker in most cases.

We've already covered how you can pull an existing image from Docker Hub, but we can also build a Singularity image from the Docker Hub using the build command:

```
$ sudo singularity build --sandbox ubuntu-latest/  docker://ubuntu
```

Test the new `.sif` image:

```
$ singularity shell --writable ubuntu-latest/

Singularity ubuntu-latest.sif:~> apt-get update
```

Does it work?

```
$ sudo singularity shell ubuntu-latest.sif

Singularity: Invoking an interactive shell within container...

Singularity ubuntu-latest.sif:~> apt-get update
```

When I try to install software to the image without `sudo` it is denied, because `root` is the owner inside the container. When I use `sudo` I can install software into the container. The software remains in the sandbox container after closing the container and restart.

In order to make these changes permanant, I need to rebuild the sandbox as a `.sif` image

```
$ sudo singularity build ubuntu-latest.sif ubuntu-latest/
```

## Creating Singularity `.sif` from scratch

### Writing the `Singularity` file

[SyLabs User-Guide](https://sylabs.io/guides/3.9/user-guide/)

A `Singularity` file can be hosted on GitHub and will be auto-detected by [Singularity-Hub](https://www.singularity-hub.org/) when you set up your container Collection.

When you are building locally, you can name the `Singularity` file whatever you wish, but a better practice is to put it in a specified directory and name it `Singularity`. 

Building your own containers requires that you have sudo privileges - therefore you'll need to develop these on your local machine or on a VM that you can gain root access on.

#### :material-layers-edit: **Header**

The top of the file, selects the base OS for the container, just like
`FROM` in Docker.

Bootstrap: references another registry (e.g. `docker` for DockerHub,
`debootstrap`, or `shub` for Singularity-Hub).

`From:` selects the tag name.

```
Bootstrap: shub
From: vsoch/hello-world
```

Pulls a container from Singularity Hub (v2.6.1)

Using debootstrap with a build that uses a mirror:

```
BootStrap: debootstrap
OSVersion: xenial
MirrorURL: http://us.archive.ubuntu.com/ubuntu/
```

Using a localimage to build:

```
Bootstrap: localimage
From: /path/to/container/file/or/directory
```

Using CentOS-like container:

```
Bootstrap: yum
OSVersion: 7
MirrorURL: http://mirror.centos.org/centos-7/7/os/x86_64/
Include:yum
```

Note: to use yum to build a container you should be operating on a RHEL
system, or an Ubuntu system with yum installed.

The container registries which Singularity uses are listed in the
[Introduction Section 3.1](https://learning.cyverse.org/projects/container_camp_workshop_2019/en/latest/singularity/singularityintro.html#downloading-pre-built-images).

-   The Singularity file uses sections to specify the dependencies,
    environmental settings, and runscripts when it builds.

The additional sections of a Singularity file include:

-   `%help` - create text for a help menu associated with your container
-   `%setup` - executed on the host system outside of the container, after the base OS has been installed.
-   `%files` - copy files from your host system into the container
-   `%labels` - store metadata in the container
-   `%environment` - loads environment variables at the time the container is run (not built)
-   `%post` - set environment variables during the build
-   `%runscript` - executes a script when the container runs
-   `%test` - runs a test on the build of the container

**Setting up Singularity file system**

#### :material-layers-edit: **help**

`%help` section can be as verbose as you want

```
Bootstrap: docker
From: ubuntu

%help
This is the container help section.
```

#### :material-layers-edit: **setup**

`%setup` commands are executed on the localhost system outside of the
container - these files could include necessary build dependencies. We
can copy files to the `$SINGULARITY_ROOTFS` file system can be done
during setup

#### :material-layers-edit: **files**

`%files` include any files that you want to copy from your localhost into
the container.

#### :material-layers-edit: **post**

`%post` includes all of the environment variables and dependencies that
you want to see installed into the container at build time.

#### :material-layers-edit: **environment**

`%environment` includes the environment variables which we want to be run
when we start the container

#### :material-layers-edit: **runscript**

`%runscript` does what it says, it executes a set of commands when the
container is run.

#### :materials-layers-edit: **label**

Example Singularity file bootstrapping an Ubuntu (22.04) image.

```
Bootstrap: docker
From: ubuntu:22.04

%post
   apt-get -y update
   apt-get -y install fortune cowsay lolcat

%environment
   export LC_ALL=C
   export PATH=/usr/games:$PATH

%runscript
   fortune | cowsay | lolcat

%labels
   Maintainer Your Name
   Version v2022
```

Build the container:

```
singularity build cowsay.sif Singularity
```

Run the container:

```
singularity run cowsay.sif
```

!!! Warning "squashfs"
      If you build a squashfs container, it is immutable (you cannot --writable edit it)

**Cryptographic Security**

[Documentation](https://www.sylabs.io/guides/3.5/user-guide/signNverify.html)