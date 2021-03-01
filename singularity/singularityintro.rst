**Introduction to Singularity**
-------------------------------

|singularity|

1. Prerequisites
================

There are no specific skills needed beyond a basic comfort with the command line and using a text editor. Prior experience installing Linux applications could be helpful but is not required.

.. Note::

      *Important*: `Singularity is compatible with Docker <https://www.sylabs.io/2018/04/singularity-compatibility-with-docker-containers/>`_, but they do have distinct differences.

   Key Differences:

      **Docker**:

      * Inside a Docker container the user has escalated privileges, effectively making them `root` on that host system. This privilege is not supported by *most* administrators of High Performance Computing (HPC) centers. Meaning that Docker is not, and will likely never be, installed natively on your HPC.

      **Singularity**:

      * Same user inside as outside the container
      * User only has root privileges if elevated with `sudo` when container is run
      * Can run (and modify!) existing Docker images and containers

  These key differences allow Singularity to be installed on most HPC centers. Because you can run virtually all Docker containers in Singularity, you can effectively run Docker on an HPC.

Singularity uses a 'flow' whereby you (1) create and modify images on your dev system, (2) build containers using recipes or pulling from repositories, and (3) execute containers on production systems.

|singularityflow|

2. Singularity Installation
===========================

Sylabs Singularity homepage: `https://www.sylabs.io/docs/ <https://www.sylabs.io/docs/>`_

While Singularity is more likely to be used on a remote system, e.g. HPC or cloud, you may want to develop your own containers first on a local machine or dev system (See figure above).

.. Note::

	Singularity exits as two major versions - 2 and 3. In this workshop we will be using version 3

2.1 Install Singularity on Laptop
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To Install Singularity on your laptop or desktop PC follow the instructions from Singularity: https://www.sylabs.io/guides/3.0/user-guide/installation.html#installation

2.2 HPC
~~~~~~~

Load the Singularity module on a HPC

If you are interested in working on HPC, you may need to contact your systems administrator and request they install `Singularity  <https://www.sylabs.io/guides/3.0/user-guide/installation.html#installation>`_. Because singularity ideally needs setuid, your admins may have some qualms about giving Singularity this privilege. If that is the case, you might consider forwarding `this letter <https://www.sylabs.io/guides/3.0/user-guide/installation.html#singularity-on-a-shared-resource>`_ to your admins.

Most HPC systems are running Environment Modules with the simple command `module`. You can check to see what is available:

.. code-block:: bash

  $ module avail singularity

If Singularity is installed:

.. code-block:: bash

	$ module load singularity/3/3.1

2.3 Atmosphere Cloud
~~~~~~~~~~~~~~~~~~~~~

CyVerse staff have deployed an Ansible playbooks called ``ez`` installation which includes `Singularity <https://cyverse-ez-quickstart.readthedocs-hosted.com/en/latest/#>`_ that only requires you to type a short line of code.

Start a featured instance on `Atmosphere <../cyverse/boot.html>_`.

Type in the following:

.. code-block:: bash

    $ ezs -r 3.1.0
	DEBUG: set version to 3.1.0

	* Updating ez singularity and installing singularity (this may take a few minutes, coffee break!)
	Cloning into '/opt/cyverse-ez-singularity'...
	remote: Enumerating objects: 6, done.
	remote: Counting objects: 100% (6/6), done.
	remote: Compressing objects: 100% (5/5), done.
	remote: Total 24 (delta 1), reused 4 (delta 1), pack-reused 18
	Unpacking objects: 100% (24/24), done.
	* singularity was updated successfully

	You shouldn't need to use ezs again on this system, unless you want to update singularity itself

	To test singularity, type: singularity run shub://vsoch/hello-world
	Hint: it should output "RaawwWWWWWRRRR!!")


2.4 Check Installation
~~~~~~~~~~~~~~~~~~~~~~

Singularity should now be installed on your laptop or VM, or loaded on the HPC, you can check the installation with:

.. code-block:: bash

    $ singularity pull shub://vsoch/hello-world
	WARNING: Authentication token file not found : Only pulls of public images will succeed
	 62.32 MiB / 62.32 MiB [===============================================================================================] 100.00% 30.61 MiB/s 2s

Singularity’s command line interface allows you to build and interact with containers transparently. You can run programs inside a container as if they were running on your host system. You can easily redirect IO, use pipes, pass arguments, and access files, sockets, and ports on the host system from within a container.

The help command gives an overview of Singularity options and subcommands as follows:

.. code-block:: bash

	$ singularity --help

	USAGE: singularity [global options...] <command> [command options...] ...

	GLOBAL OPTIONS:
	    -d|--debug    Print debugging information
	    -h|--help     Display usage summary
	    -s|--silent   Only print errors
	    -q|--quiet    Suppress all normal output
	       --version  Show application version
	    -v|--verbose  Increase verbosity +1
	    -x|--sh-debug Print shell wrapper debugging information

	GENERAL COMMANDS:
	    help       Show additional help for a command or container
	    selftest   Run some self tests for singularity install

	CONTAINER USAGE COMMANDS:
	    exec       Execute a command within container
	    run        Launch a runscript within container
	    shell      Run a Bourne shell within container
	    test       Launch a testscript within container

	CONTAINER MANAGEMENT COMMANDS:
	    apps       List available apps within a container
	    bootstrap  *Deprecated* use build instead
	    build      Build a new Singularity container
	    check      Perform container lint checks
	    inspect    Display container's metadata
	    mount      Mount a Singularity container image
	    pull       Pull a Singularity/Docker container to $PWD

	COMMAND GROUPS:
	    image      Container image command group
	    instance   Persistent instance command group


	CONTAINER USAGE OPTIONS:
	    see singularity help <command>

	For any additional help or support visit the Singularity
	website: http://singularity.lbl.gov/

Information about subcommand can also be viewed with the help command.

.. code-block:: bash

	$ singularity help pull
	Pull a container from a URI

	Usage:
	  singularity pull [pull options...] [output file] <URI>

	Description:
	  The 'pull' command allows you to download or build a container from a given
	  URI.  Supported URIs include:

	  library: Pull an image from the currently configured library
	      library://[user[collection/[container[:tag]]]]

	  docker: Pull an image from Docker Hub
	      docker://user/image:tag

	  shub: Pull an image from Singularity Hub to CWD
	      shub://user/image:tag

	Options:
	      --docker-login     interactive prompt for docker authentication
	  -F, --force            overwrite an image file if it exists
	  -h, --help             help for pull
	      --library string   the library to pull from (default
	                         "https://library.sylabs.io")
	      --nohttps          do NOT use HTTPS, for communicating with local
	                         docker registry


	Examples:
	  From Sylabs cloud library
	  $ singularity pull alpine.sif library://alpine:latest

	  From Docker
	  $ singularity pull tensorflow.sif docker://tensorflow/tensorflow:latest

	  From Shub
	  $ singularity pull singularity-images.sif shub://vsoch/singularity-images


	For additional help or support, please visit https://www.sylabs.io/docs/

3. Downloading pre-built images
================================
* `shub` - images hosted on Singularity Hub
* `docker` - images hosted on Docker Hub
* `localimage` - images saved on your machine
* `yum` - yum based systems such as CentOS and Scientific Linux
* `debootstrap` - apt based systems such as Debian and Ubuntu
* `arch` - Arch Linux
* `busybox` - BusyBox
* `zypper` - zypper based systems such as Suse and OpenSuse

3.1 Pulling an image from Singularity Hub
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Similar to previous example, in this example I am pulling a base Ubuntu container from Singularity-Hub:

.. code-block:: bash

    $ singularity pull shub://singularityhub/ubuntu
    WARNING: Authentication token file not found : Only pulls of public images will succeed
 	88.58 MiB / 88.58 MiB [===============================================================================================] 100.00% 31.86 MiB/s 2s

You can rename the container using the `--name` flag:

.. code-block:: bash

    $ singularity pull --name ubuntu_test.simg shub://singularityhub/ubuntu
    WARNING: Authentication token file not found : Only pulls of public images will succeed
 	88.58 MiB / 88.58 MiB [===============================================================================================] 100.00% 35.12 MiB/s 2s

The above command will save the alpine image from the Container Library as ``alpine.sif``

3.2 Pulling an image from Docker Hub
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This example pulls an ``ubuntu:16.04`` image from DockerHub and saves it to the working directory.

.. code-block:: bash

	$ singularity pull docker://ubuntu:16.04
	WARNING: Authentication token file not found : Only pulls of public images will succeed
	INFO:    Starting build...
	Getting image source signatures
	Copying blob sha256:7b722c1070cdf5188f1f9e43b8413157f8dfb2b4fe84db3c03cb492379a42fcc
	 41.51 MiB / 41.51 MiB [====================================================] 1s
	Copying blob sha256:5fbf74db61f1459176d8647ba8f53f8e6cf933a2e56f73f0e8da81213117b7e9
	 847 B / 847 B [============================================================] 0s
	Copying blob sha256:ed41cb72e5c918bdbd78e68f02930a3f1cf1d6079402b0a5b19de8508e67b766
	 526 B / 526 B [============================================================] 0s
	Copying blob sha256:7ea47a67709ebea8efed59fbda703dbd00a0d2cae7e2808959744bfa30bfc0e9
	 168 B / 168 B [============================================================] 0s
	Copying config sha256:288b5aca25f70512e5874c289a8a216b60808ecc47f687fa502fd848e5c3f875
	 2.42 KiB / 2.42 KiB [======================================================] 0s
	Writing manifest to image destination
	Storing signatures
	INFO:    Creating SIF file...
	INFO:    Build complete: ubuntu_16.04.sif

.. warning::

	Pulling Docker images reduces reproducibility. If you were to pull a Docker image today and then wait six months and pull again, you are not guaranteed to get the same image. If any of the source layers has changed the image will be altered. If reproducibility is a priority for you, try building your images from the Container Library.

3.3 Pulling an image from Sylabs cloud library
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Let’s use an easy example of ``alpine.sif`` image from the `container library <https://cloud.sylabs.io/library/>`_

.. code-block :: bash

	$ singularity pull library://alpine:latest
	WARNING: Authentication token file not found : Only pulls of public images will succeed
	INFO:    Downloading library image
 	2.08 MiB / 2.08 MiB [==================================================================================================] 100.00% 5.06 MiB/s 0s

.. Tip::

	You can use ``singularity search alpine`` command to locate groups, collections, and containers of interest on the Container Library

4 Interact with images
======================

.. |singularity| image:: ../img/singularity.png
  :height: 200
  :width: 200

.. |singularityflow| image:: http://singularity.lbl.gov/assets/img/diagram/singularity-2.4-flow.png
  :width: 800
