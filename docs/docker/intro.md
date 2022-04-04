# Introduction to Docker

![docker](../assets/docker/docker.png){ width="600" }

### Prerequisites

In order to complete these exercises we HIGHLY recommend that you set up a personal [GitHub](https://github.com){target=_blank} and [DockerHub](https://hub.docker.com) account. These are free, but do have options for paid subscriptions and added services.

There are no specific skills needed for this tutorial beyond a basic comfort with the command line and using a text editor.

??? Note "Installing Docker on your personal computer"

    We are going to be using virtual machines on the cloud, but there may be a time when you want to run this on your own computer.

    Installing Docker takes a little time but it is reasonably straight forward and it is a one-time setup.

    Installation instructions from Docker Official docs

	- [Mac OS X](https://docs.docker.com/docker-for-mac/){target=_blank}
	- [Windows](https://docs.docker.com/docker-for-windows){target=_blank}
	- [Ubuntu Linux](https://docs.docker.com/install/linux/docker-ce/ubuntu/){target=_blank}


We are going to be using [GitHub CodeSpaces](https://github.com/features/codespaces) for the hands on portion of the workshop. 

CodeSpaces is a featured product from GitHub and requires a paid subscription or Academic account for access. Your account will temporarily be integrated with the course GitHub Organization for the next steps in the workshop.


## Basic Docker Commands

All Docker based commands on the terminal use the prefix `docker`

### help

Like many other command line applications the most helpful flag is the `help` command which can be used with the Management Commands:

```
$ docker 
$
$ docker --help
```

### search

We talk about the concept of [Docker Registries](registry.md) in the next section, but you can search the public list of registeries by using the `docker search` command to find public containers on the Official [Docker Hub Registry](https://hub.docker/com){target=_blank} 

```
$ docker search  
```

### list

```
$ docker list 
```

### pull

Go to the [Docker Hub](https://hub.docker.com){target=_blank} and type `hello-world` in the search bar at the top of the page. 

Click on the 'tag' tab to see all the available 'hello-world' images. 

Click the 'copy' icon at the right to copy the `docker pull` command, or type it into your terminal:

```
$ docker pull hello-world
```

note: if you leave off the `:` and the tag name, it will by default pull the `latest` image

```
$ docker pull hello-world
Using default tag: latest
latest: Pulling from library/hello-world
2db29710123e: Pull complete 
Digest: sha256:bfea6278a0a267fad2634554f4f0c6f31981eea41c553fdf5a83e95a41d40c38
Status: Downloaded newer image for hello-world:latest
docker.io/library/hello-world:latest
```

Now try to list the files in your current working directory

```
$ ls -l
```

?? Question "Where is the image you just pulled?"

    Docker saves container images to the Docker directory (where Docker is installed). 
    
    You won't ever see them in your working directory.

    Use 'docker images' to see all the images on your computer:

    ```
    $ docker images
    ```

?? Tip "adding yourself to the Docker group on Linux"

	Depending on how and where you've installed Docker, you may see a `permission denied` error after running `$ docker run helo-world` command.
    
    If you're on Linux, you may need to prefix your Docker commands with `sudo`. 
    
    Alternatively to run docker command without `sudo`, you need to add your user name (who has root privileges) to the docker "group".

	Create the docker group:

    ```
	$ sudo groupadd docker
    ```

	Add your user to the docker group::
    
    ```
	$ sudo usermod -aG docker $USER
    ```

	Log out or close terminal and log back in and your group membership will be initiated

### run

The single most common command that you'll use with Docker is `docker run` ([see official help manual](https://docs.docker.com/engine/reference/commandline/run/){target=_blank} for more details.

`docker run` starts a container and executes the default "entrypoint", or any other "command" that follows `run` and any optional flags.

```
$ docker run hello-world:latest
```

?? Tip "Inspecting your containers"

	To find out more about a Docker images, run `docker inspect hello-world:latest`.


In the demo above, you used the `docker pull` command to download the `hello-world:latest` image.

What about if you run a container that you haven't downloaded?


```
$ docker run alpine:latest ls -l
```

When you executed the command `docker run alpine:latest`, Docker first looked for the cached image locally, but did not find it, it then ran a `docker pull` behind the scenes to download the `alpine:latest` image and then execute your command.

When you ran `docker run alpine:latest`, you provided a command `ls -l`, so Docker started the command specified and you saw the listing of the alpine file system (not your host system, this was insice the container!).

You can now use the `docker images` command to see a list of all the cached images on your system:

```
$ docker images	
REPOSITORY              TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
alpine                 	latest              c51f86c28340        4 weeks ago         1.109 MB
hello-world             latest              690ed74de00f        5 months ago        960 B
```

You can change the entrypoint of a container by making any statement after the `registry/containername:tagname`:

```
$ docker run alpine echo "Hello world"
```

In this case, the Docker client dutifully ran the ``echo`` command in our ``alpine`` container and then exited. If you've noticed, all of that happened pretty quickly. 

Imagine booting up a virtual machine, running a command and then killing it. 

Now you know why they say containers are fast!

### ps

Now it's time to see the `docker ps` command which shows you all containers that are currently running on your machine.

```
docker ps
```

Since no containers are running, you see a blank line.

```
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```

 Let's try a more useful variant: `docker ps --all`

```
$ docker ps --all
```

What you see above is a list of all containers that you have ran. 

Notice that the `STATUS` column shows that these containers exited a few minutes ago.

## Interactive Commands with Containers

Lets try another command, this time to access the container as a shell:

```
$ docker run alpine:latest sh
```

Wait, nothing happened, right? 

Is that a bug? 

Well, no.

The container will exit after running any scripted commands such as `sh`, unless they are run in an "interactive" terminal (TTY) - so for this example to not exit, you need to add the `-i` for interactive and `-t` for TTY. 

You can run them both in a single flag as ``-it``, which is the more common way of adding the flag:

```
$ docker run -it alpine:latest sh
```

The prompt should change to something more like `/ # ` -- 

You are now running a shell inside the container! 

Try out a few commands like `ls -l`, `uname -a` and others.

Exit out of the container by giving the `exit` command.

```
/ # exit
```

?? Tip "Making sure you've exited the container"

	If you type ``exit`` your **container** will exit and is no longer active. To check that, try the following:

    ```
	$ docker ps --latest
	CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS                          PORTS                    NAMES
	de4bbc3eeaec        alpine                "/bin/sh"                3 minutes ago       Exited (0) About a minute ago                            pensive_leavitt
    ```

	If you want to keep the container active, then you can use keys `ctrl +p` `ctrl +q`. To make sure that it is not exited run the same `docker ps --latest` command again:

    ```
	$ docker ps --latest
	CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS                         PORTS                    NAMES
	0db38ea51a48        alpine                "sh"                     3 minutes ago       Up 3 minutes                                            elastic_lewin
    ```

	Now if you want to get back into that container, then you can type `docker attach <container id>`. This way you can save your container:

	```
    $ docker attach 0db38ea51a48
    ```

## House Keeping and Cleaning Up exited containers

IMPORTANT: Docker images are cached on your machine in the location where Docker was installed. These image files are not visible in the same directory where you might have used `docker pull <imagename>`.

Some Docker images can be large. Especially data science images with many scientific programming libraries and packages pre-installed.

?? Tip "Checking your system cache"

	Pulling many images from the Docker Registries may fill up your hard disk!

    To inspect your system and disk use:

    ```
	$ docker system info
	$ docker system df
    ```

    To find out how many images are on your machine, type:

    ```
	$ docker images --help
    ```

    To remove images that you no longer need, type:

    ```
	$ docker system prune --help
    ```

    This is where it becomes important to differentiate between *images*, *containers*, and *volumes* (which we'll get to more in a bit). 

    You can take care of all of the dangling images and containers on your system. 

    Note, that `prune` will not remove your cached *images* 

    ```
	$ docker system prune
    	WARNING! This will remove:
	     - all stopped containers
	     - all networks not used by at least one container
	     - all dangling images
	     - all dangling build cache

	Are you sure you want to continue? [y/N]
    ```

    If you added the `-af` flag it will remove "all" `-a` dangling images, empty containers, AND ALL CACHED IMAGES with "force" `-f`.

### Managing Docker images

In the previous example, you pulled the `alpine` image from the registry and asked the Docker client to run a container based on that image. To see the list of images that are available locally on your system, run the ``docker images`` command.

.. code-block:: bash

	$ docker images
	REPOSITORY                 TAG                 IMAGE ID            CREATED             SIZE
	ubuntu                     bionic              47b19964fb50        4 weeks ago         88.1MB
	alpine                     latest              caf27325b298        4 weeks ago         5.53MB
	hello-world                latest              fce289e99eb9        2 months ago        1.84kB
	.........

Above is a list of images that I've pulled from the registry and those I've created myself (we'll shortly see how). You will have a different list of images on your machine. The **TAG** refers to a particular snapshot of the image and the **ID** is the corresponding unique identifier for that image.

For simplicity, you can think of an image akin to a Git repository - images can be committed with changes and have multiple versions. When you do not provide a specific version number, the client defaults to latest.

## Jupyter Lab or RStudio-Server IDE
	
In this section, let's find a Docker image which can run a Jupyter Notebook

Search for official images on Docker Hub which contain the string 'jupyter'


```
$ docker search jupyter
```

It should return something like:

```
NAME                                   DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
jupyter/datascience-notebook           Jupyter Notebook Data Science Stack from htt…   912                  
jupyter/all-spark-notebook             Jupyter Notebook Python, Scala, R, Spark, Me…   374                  
jupyter/scipy-notebook                 Jupyter Notebook Scientific Python Stack fro…   337                  
jupyterhub/jupyterhub                  JupyterHub: multi-user Jupyter notebook serv…   307                  [OK]
jupyter/tensorflow-notebook            Jupyter Notebook Scientific Python Stack w/ …   298                  
jupyter/pyspark-notebook               Jupyter Notebook Python, Spark, Mesos Stack …   224                  
jupyter/base-notebook                  Small base image for Jupyter Notebook stacks…   168                  
jupyter/minimal-notebook               Minimal Jupyter Notebook Stack from https://…   150                  
jupyter/r-notebook                     Jupyter Notebook R Stack from https://github…   44                   
jupyterhub/singleuser                  single-user docker images for use with Jupyt…   43                   [OK]
jupyter/nbviewer                       Jupyter Notebook Viewer                         27                   [OK]
```

Search for images on Docker Hub which contain the string 'rstudio'

```
$ docker search rstudio
```

```
NAME                                           DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
rocker/rstudio                                 RStudio Server image                            389                  [OK]
rstudio/r-base                                 Docker Images for R                             24                   
rocker/rstudio-stable                          Build RStudio based on a debian:stable (debi…   16                   [OK]
rstudio/rstudio-server-pro                     Deprecated Docker images for RStudio Server …   10                   
rstudio/r-session-complete                     Images for sessions and jobs in RStudio Serv…   10                   
rstudio/plumber                                                                                6                    
rstudio/rstudio-connect                        Default Docker image for RStudio Connect        4                    
rstudio/r-builder-images-win                                                                   3                    
rstudio/rstudio-workbench                      Docker Image for RStudio Workbench (formerly…   2                    
saagie/rstudio                                 RStudio with sparklyr, Saagie's addin and ab…   2                    [OK]
ibmcom/rstudio-ppc64le                         Integrated development environment (IDE) for…   2                    
rstudio/checkrs-tew                            Test Environment: Web                           1                    [OK]
rstudio/rstudio-package-manager                Default Docker image for RStudio Package Man…   1                    
rstudio/shinyapps-package-dependencies         Docker images used to test the install scrip…   1                    
rstudio/rstudio-workbench-preview                                                              1                    
```

## Working with Interactive Containers

Let's go ahead and run some basic Integraded Development Environment images from "trusted" organizations on the Docker Hub Registry.

When we want to run a container that runs on the open internet, we need to add a [TCP or UDP port number](https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers){target=_blank} from which we can access the application in a browser using the machine's IP (Internet Protocol) address or DNS (Domain Name Service) location.

To do this, we need to access the container over a separate port address on the machine we're working on.

Docker uses the flag `--port` or `-p` for short followed by two sets of port numbers. 

?? Note "Exposing Ports"

    Docker can in fact expose all ports to a container using the capital `-P` flag

    For security purposes, it is generally NEVER a good idea to expose all ports.

Typically these numbers can be the same, but in some cases your machine may already be running another program (or container) on that open port.

The port has two sides `left:right` separated by a colon. The left side port number is the INTERNAL port that the container software thinks its using. The right side number is the EXTERNAL port that you can access on your computer (or virtual machine).

Here are some examples to run basic RStudio and Jupyter Lab:

```
$docker run --rm -p 8787:8787 -e PASSWORD=cc2022 rocker/rstudio
```

```
$docker run --rm -p 8888:8888 jupyter/base-notebook
```

?? Note "preempting stale containers from your cache"

	We've added the `--rm` flag, which means the container will automatically removed from the cache when the container is exited.

	When you start an IDE in a terminal, the terminal connection must stay active to keep the container alive.

### Detaching your container while it is running

If we want to keep our window in the foreground  we can use the `-d` - the *detached* flag will run the container as a background process, rather than in the foreground. When you run a container with this flag, it will start, run, telling you the container ID:

```
$ docker run --rm -d -p 8888:8888 jupyter/base-notebook
```
Note, that your terminal is still active and you can use it to launch more containers. 

To view the running container, use the `docker ps` command

## Managing Data in Docker

It is possible to store data within the writable layer of a container, but there are some limitations:

- The data doesn’t persist when that container is no longer running, and it can be difficult to get the data out of the container if another process needs it.

- A container’s writable layer is tightly coupled to the host machine where the container is running. You can’t easily move the data somewhere else.

- Its better to put your data into the container **AFTER** it is built - this keeps the container size smaller and easier to move across networks.

Docker offers three different ways to mount data into a container from the Docker host:

  * **volumes**

  * **bind mounts**

  * **tmpfs volumes**

When in doubt, volumes are almost always the right choice.

### Volumes

Volumes are often a better choice than persisting data in a container’s writable layer, because using a volume does not increase the size of containers using it, and the volume’s contents exist outside the lifecycle of a given container. While bind mounts (which we will see later) are dependent on the directory structure of the host machine, volumes are completely managed by Docker. Volumes have several advantages over bind mounts:

- Volumes are easier to back up or migrate than bind mounts.
- You can manage volumes using Docker CLI commands or the Docker API.
- Volumes work on both Linux and Windows containers.
- Volumes can be more safely shared among multiple containers.
- A new volume’s contents can be pre-populated by a container.


?? Tip "using Temporary File System mounts"

	If your container generates non-persistent state data, consider using a ``tmpfs`` mount to avoid storing the data anywhere permanently, and to increase the container’s performance by avoiding writing into the container’s writable layer.

First we need to get some data on our local machine (Atmosphere).

.. code-block:: bash

    $ iinit

    Enter the host name (DNS) of the server to connect to: data.cyverse.org
    Enter the port number: 1247
    Enter your irods user name: your_cyverse_username
    Enter your irods zone: iplant


    $ iget -r /iplant/home/shared/iplant_training/read_cleanup

    $ ls -l 

Choose the -v flag for mounting volumes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

``-v`` or ``--volume``: Consists of three fields, separated by colon characters (:). The fields must be in the correct order, and the meaning of each field is not immediately obvious.

- The first field is the path on your local machine that where the data are.
- The second field is the path where the file or directory are mounted in the container.
- The third field is optional, and is a comma-separated list of options, such as ``ro``.

.. code-block:: bash

   -v /home/username/your_data_folder:/container_folder

.. code-block:: bash

    $ docker run -v /home/amcooksey/read_cleanup:/work alpine:latest ls -l /work


So what if we wanted to work interactively inside the container?

.. code-block:: bash

    $ docker run -it -v /home/amcooksey/read_cleanup:/work alpine:latest sh

.. code-block:: bash

    $ ls -l 

    $ ls -l work

..
	.. Note::
..
	Originally, the ``-v`` or ``--volume`` flag was used for standalone containers and the ``--mount`` flag was used for swarm services. However, starting with Docker 17.06, you can also use ``--mount`` with standalone containers. In general, ``--mount`` is more explicit and verbose. The biggest difference is that the ``-v`` syntax combines all the options together in one field, while the ``--mount`` syntax separates them. Here is a comparison of the syntax for each flag.
..
	.. code-block:: bash
..
	$docker run --rm -v $(pwd):/work -p 8787:8787 -e PASSWORD=cc2020 rocker/rstudio
..
	In the Jupyter Lab example, we use the ``-e`` environmental flag to re-direct the URL of the container at the localhost
..
	.. code-block:: bash
..
	$docker run --rm -v $(pwd):/work -p 8888:8888 -e REDIRECT_URL=http://localhost:8888 jupyter/base-notebook

Once you're in the container, you will see that the ``/work`` directory is mounted in the working directory.

Any data that you add to that folder outside the container will appear INSIDE the container. And any work you do inside the container saved in that folder will be saved OUTSIDE the container as well.

Docker Commands
===============

+----------------+------------------------------------------------+
| Command        |          Usage                                 |
+================+================================================+
| docker pull    |  Download an image from Docker Hub             |
+----------------+------------------------------------------------+
| docker run     |  *Usage:* ``docker run -it user/image:tag``    |
|                |  starts a container with an entrypoint         |
+----------------+------------------------------------------------+
| docker build   | *Usage:* ``docker build -t user/image:tag .``  |
|                |  Builds a docker image from a Dockerfile in    |
|                |  current working directory. ``-t`` for tagname |
+----------------+------------------------------------------------+
| docker images  |  List all images on the local machine          |
+----------------+------------------------------------------------+
| docker tag     |  Add a new tag to an image                     |
+----------------+------------------------------------------------+
| docker login   |  Authenticate to the Docker Hub                |
|                |  requires username and password                |
+----------------+------------------------------------------------+
| docker push    |  *Usage:* ``docker push user/image:tag``       |
|                |  Upload an image to Docker Hub                 |
+----------------+------------------------------------------------+
| docker inspect |  *Usage:* ``docker inspect containerID``       |
|                |  Provide detailed information on constructs    |
|                |  controlled by Docker                          |
+----------------+------------------------------------------------+
| docker ps -a   |  List all containers on your system            |
+----------------+------------------------------------------------+
| docker rm      |  *Usage:* ``docker rm -f <container>``         |
|                |  Deletes a *container*                         |
|                |  ``-f`` remove running container               |
+----------------+------------------------------------------------+
| docker rmi     |  Deletes an *image*                            |
+----------------+------------------------------------------------+
| docker stop    |  *Usage:* ``docker stop <container>``          |
|                |  Stop a running container                      |
+----------------+------------------------------------------------+
| docker system  |  *Usage:* ``docker system prune``		  |
|                |  Remove old images and cached layers		  |
|                |  *Usage:* ``docker system df``		  |
|                |  View system details (cache size)              |
+----------------+------------------------------------------------+

Getting more help with Docker
=============================

- The command line tools are very well documented:

.. code-block:: bash

   $ docker --help
   # shows all docker options and summaries

.. code-block:: bash

   $ docker COMMAND --help
   # shows options and summaries for a particular command

- Learn `more about docker <https://docs.docker.com/get-started/>`_
.. 
 4. Extra Demos
 ==============
..
 4.1 Portainer
 ~~~~~~~~~~~~~
..
 `Portainer <https://portainer.io/>`_ is an open-source lightweight managment UI which allows you to easily manage your Docker hosts or Swarm cluster.
..
 - Simple to use: It has never been so easy to manage Docker. Portainer provides a detailed overview of Docker and allows you to manage containers, images, networks and volumes. It is also really easy to deploy, you are just one Docker command away from running Portainer anywhere.
..
 - Made for Docker: Portainer is meant to be plugged on top of the Docker API. It has support for the latest versions of Docker, Docker Swarm and Swarm mode.
..
 4.1.1 Installation
 ^^^^^^^^^^^^^^^^^^
..
 Use the following Docker commands to deploy Portainer. Now the second line of command should be familiar to you by now. We will talk about first line of command in the Advanced Docker session.
..
 .. code-block:: bash
..
	# on CyVerse Atmosphere:
	$ ezd -p
..
	$ docker volume create portainer_data
..
	$ docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
..
 - If you are on mac, you'll just need to access the port 9000 (http://localhost:9000) of the Docker engine where portainer is running using username ``admin`` and   password ``tryportainer``
..
 - If you are running Docker on Atmosphere/Jetstream or on any other cloud, you can open ``ipaddress:9000``. For my case this is ``http://128.196.142.26:9000``
..
 .. Note::
..
	The ``-v /var/run/docker.sock:/var/run/docker.sock`` option can be used in Mac/Linux environments only.
..
 |portainer_demo|
..
 4.2 Play-with-docker (PWD)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
..
 `PWD <https://labs.play-with-docker.com/>`_ is a Docker playground which allows users to run Docker commands in a matter of seconds. It gives the experience of having a free Alpine Linux Virtual Machine in browser, where you can build and run Docker containers and even create clusters in `Docker Swarm Mode <https://docs.docker.com/engine/swarm/>`_. Under the hood, Docker-in-Docker (DinD) is used to give the effect of multiple VMs/PCs. In addition to the playground, PWD also includes a training site composed of a large set of Docker labs and quizzes from beginner to advanced level available at `training.play-with-docker.com <https://training.play-with-docker.com/>`_.
..
 4.2.1 Installation
 ^^^^^^^^^^^^^^^^^^
..
 You don't have to install anything to use PWD. Just open ``https://labs.play-with-docker.com/`` <https://labs.play-with-docker.com/>`_ and start using PWD
..
 .. Note::
..
	You can use your Dockerhub credentials to log-in to PWD
..
 |pwd|

**Fix or improve this documentation**

- Search for an answer:
   |CyVerse Learning Center|
- Ask us for help:
  click |Intercom| on the lower right-hand side of the page
- Report an issue or submit a change:
  |Github Repo Link|
- Send feedback: `Tutorials@CyVerse.org <Tutorials@CyVerse.org>`_

===================================================================
