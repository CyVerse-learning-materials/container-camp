Introduction to Docker
-----------------------

Prerequisites
=============

There are no specific skills needed for this tutorial beyond a basic comfort with the command line and using a text editor. Prior experience in developing web applications will be helpful but is not required.

Docker Installation
====================

Getting all the tooling setup on your computer can be a daunting task, but not with Docker. Getting Docker up and running on your favorite OS (Mac/Windows/Linux) is very easy.

The getting started guide on Docker has detailed instructions for setting up Docker on (`Mac <https://docs.docker.com/docker-for-mac/install/>`_/`Windows <https://docs.docker.com/docker-for-windows/install/>`_/`Linux <https://docs.docker.com/install/linux/docker-ce/ubuntu/>`_).

.. Note:: 

	If you're using Docker for Windows make sure you have `shared your drive <https://docs.docker.com/docker-for-windows/#shared-drives>`_. 
	If you're using an older version of Windows or MacOS you may need to use `Docker Machine <https://docs.docker.com/machine/overview/>`_ instead. 
	All commands work in either bash or Powershell on Windows.

Testing Docker installation
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Once you are done installing Docker, test your Docker installation by running the following:

.. code-block:: bash

	$ docker

You should see a whole bunch of lines showing the different options available with `docker`. Alternatively you can test by running the following:

.. code-block:: bash

	$ docker run hello-world
	Unable to find image 'hello-world:latest' locally
	latest: Pulling from library/hello-world
	03f4658f8b78: Pull complete
	a3ed95caeb02: Pull complete
	Digest: sha256:8be990ef2aeb16dbcb9271ddfe2610fa6658d13f6dfb8bc72074cc1ca36966a7
	Status: Downloaded newer image for hello-world:latest

	Hello from Docker.
	This message shows that your installation appears to be working correctly.

	To generate this message, Docker took the following steps:
	 1. The Docker client contacted the Docker daemon.
	 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
	 3. The Docker daemon created a new container from that image which runs the
	    executable that produces the output you are currently reading.
	 4. The Docker daemon streamed that output to the Docker client, which sent it
	    to your terminal.
	.......

Running Docker containers from prebuilt images
==============================================

Now that you have everything setup, it's time to get our hands dirty. In this section, you are going to run an `Alpine Linux <http://www.alpinelinux.org/>`_ container (a lightweight linux distribution) on your system and get a taste of the docker run command.

But wait, what exactly is a container and image?

*Containers* - Running instances of Docker images — containers run the actual applications. A container includes an application and all of its dependencies. It shares the kernel with other containers, and runs as an isolated process in user space on the host OS. You created a container using docker run which you did using the alpine image that you downloaded. A list of running containers can be seen using the docker ps command

*Images* - The file system and configuration of our application which are used to create containers. To find out more about a Docker image, run `docker inspect alpine`. In the demo above, you used the `docker pull` command to download the alpine image. When you executed the command docker run hello-world, it also did a `docker pull` behind the scenes to download the hello-world image

Now that we know what a container and image is, let's run the following in our terminal:

.. code-block:: bash

	$ docker run alpine

.. Note::

	Depending on how you've installed docker on your system, you might see a `permission denied` error after running the above command. If you're on Linux, you may need to prefix your docker commands with sudo. Alternatively to run docker command without sudo, you need to add your user (who has root privileges) to docker group. 
	For this run `sudo usermod -aG docker $USER` command. Once you have done that, you have to just logout and login again. 

The `pull` command fetches the alpine image from the Docker registry and saves it in our system. You will see more about it later. You can use the `docker images` command to see a list of all images on your system

.. code-block:: bash

	$ docker images
	REPOSITORY              TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
	alpine                 	latest              c51f86c28340        4 weeks ago         1.109 MB
	hello-world             latest              690ed74de00f        5 months ago        960 B

Great! Let's now run a Docker **container** based on this image. To do that you are going to use the `docker run` command.

.. code-block:: bash

	$ docker run alpine ls -l
	total 52
	drwxr-xr-x    2 root     root          4096 Dec 26  2016 bin
	drwxr-xr-x    5 root     root           340 Jan 28 09:52 dev
	drwxr-xr-x   14 root     root          4096 Jan 28 09:52 etc
	drwxr-xr-x    2 root     root          4096 Dec 26  2016 home
	drwxr-xr-x    5 root     root          4096 Dec 26  2016 lib
	drwxr-xr-x    5 root     root          4096 Dec 26  2016 media
	........

When you run `docker run alpine`, you provided a command `ls -l`, so Docker started the command specified and you saw the listing

Let's try something more exciting.

.. code-block:: bash

	$ docker run alpine echo "Hello world"
	Hello world

OK, that's some actual output. In this case, the Docker client dutifully ran the `echo` command in our `alpine` container and then exited it. If you've noticed, all of that happened pretty quickly. Imagine booting up a virtual machine, running a command and then killing it. Now you know why they say containers are fast!

Try another command.

.. code-block:: bash

	$ docker run alpine sh

Wait, nothing happened! Is that a bug? Well, no. These interactive shells will exit after running any scripted commands, unless they are run in an interactive terminal - so for this example to not exit, you need to `docker run -it alpine sh`. You are now inside the container shell and you can try out a few commands like `ls -l`, `uname -a` and others. 

Ok, now it's time to see the `docker ps` command. The `docker ps` command shows you all containers that are currently running.

.. code-block:: bash

	$ docker ps
	CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES

Since no containers are running, you see a blank line. Let's try a more useful variant: `docker ps -a`

.. code-block:: bash

	$ docker ps -a
	CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                      PORTS               NAMES
	36171a5da744        alpine              "/bin/sh"                5 minutes ago       Exited (0) 2 minutes ago                        fervent_newton
	a6a9d46d0b2f        alpine             "echo 'hello from alp"    6 minutes ago       Exited (0) 6 minutes ago                        lonely_kilby
	ff0a5c3750b9        alpine             "ls -l"                   8 minutes ago       Exited (0) 8 minutes ago                        elated_ramanujan
	c317d0a9e3d2        hello-world         "/hello"                 34 seconds ago      Exited (0) 12 minutes ago                       stupefied_mcclintock

What you see above is a list of all containers that you ran. Notice that the STATUS column shows that these containers exited a few minutes ago. You're probably wondering if there is a way to run more than just one command in a container. Let's try that now:

.. code-block:: bash

	$ docker run -it alpine sh
	/ # ls
	bin    dev    etc    home   lib    media  mnt    proc   root   run    sbin   srv    sys    tmp    usr    var
	/ # uname -a
	Linux de4bbc3eeaec 4.9.49-moby #1 SMP Wed Sep 27 23:17:17 UTC 2017 x86_64 Linux

Running the `run` command with the `-it` flags attaches us to an interactive tty in the container. Now you can run as many commands in the container as you want. Take some time to run your favorite commands.

Exit out of the container by giving the exit command.

.. code-block:: bash

	/ # exit

.. Note::

	If you type `exit` your **container** will exit and is no longer active. To check that, try the following.

.. code-block:: bash

	$ docker ps -a
	CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS                          PORTS                    NAMES
	de4bbc3eeaec        alpine                "/bin/sh"                3 minutes ago       Exited (0) About a minute ago                            pensive_leavitt

If you want to keep the container active, then you can press keys `ctrl +p, q`. To make sure that it is not exited run the same `docker ps -a` command again

.. code-block:: bash

	$ docker ps -a
	CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS                         PORTS                    NAMES
	0db38ea51a48        alpine                "sh"                     3 minutes ago       Up 3 minutes                                            elastic_lewin

Now if you want to get into that container, then you can type `docker attach <container id>`. This way you can save your container

.. code-block:: bash

	$ docker attach 0db38ea51a48

Deploying web applications with Docker 
======================================

Great! So you have now looked at `docker run`, played with a Docker container and also got the hang of some terminology. Armed with all this knowledge, you are now ready to get to the real stuff — deploying web applications with Docker.

Deploying static website
~~~~~~~~~~~~~~~~~~~~~~~~

Let's start by taking baby-steps. First, we'll use Docker to run a static website in a container. The website is based on an existing image and in the next section we will see how to build a new image and run a website in that container. We'll pull a Docker image from Docker Store, run the container, and see how easy it is to set up a web server.

.. Note::
	
	Code for this section is in this repo in the `static-site directory <https://github.com/docker/labs/tree/master/beginner/static-site>`_

The image that you are going to use is a single-page website that was already created for this demo and is available on the Docker Store as `dockersamples/static-site <https://store.docker.com/community/images/dockersamples/static-site>`_. You can pull and run the image directly in one go using `docker run` as follows.

.. code-block:: bash

	$ docker run -d dockersamples/static-site

.. Note:: 

	The `-d` flag enables detached mode, which detaches the running container from the terminal/shell and returns your prompt after the container starts. 

So, what happens when you run this command?

Since the image doesn't exist on your Docker host (laptop), the Docker daemon first fetches it from the registry and then runs it as a container.

Now that the server is running, do you see the website? What port is it running on? And more importantly, how do you access the container directly from our host machine?

Actually, you probably won't be able to answer any of these questions yet! ☺ In this case, the client didn't tell the Docker Engine to publish any of the ports, so you need to re-run the `docker run` command to add this instruction.

Let's re-run the command with some new flags to publish ports and pass your name to the container to customize the message displayed. We'll use the `-d` option again to run the container in detached mode.

First, stop the container that you have just launched. In order to do this, we need the container ID.

Since we ran the container in detached mode, we don't have to launch another terminal to do this. Run `docker ps` to view the running containers.

.. code-block:: bash

	$ docker ps
	CONTAINER ID        IMAGE                  COMMAND                  CREATED             STATUS              PORTS               NAMES
	a7a0e504ca3e        dockersamples/static-site   "/bin/sh -c 'cd /usr/"   28 seconds ago      Up 26 seconds       80/tcp, 443/tcp     stupefied_mahavira

Check out the CONTAINER ID column. You will need to use this CONTAINER ID value, a long sequence of characters, to identify the container you want to stop, and then to remove it. The example below provides the CONTAINER ID on our system; you should use the value that you see in your terminal.

.. code-block:: bash

	$ docker stop a7a0e504ca3e
	$ docker rm   a7a0e504ca3e

.. Note::

	A cool feature is that you do not need to specify the entire CONTAINER ID. You can just specify a few starting characters and if it is unique among all the containers that you have launched, the Docker client will intelligently pick it up.

Now, let's launch a container in detached mode as shown below:

.. code-block:: bash

	$ docker run --name static-site -d -P dockersamples/static-site
	e61d12292d69556eabe2a44c16cbd54486b2527e2ce4f95438e504afb7b02810

In the above command:

-	`-d` will create a container with the process detached from our terminal
-	`-P` will publish all the exposed container ports to random ports on the Docker host
-	`--name` allows you to specify a container name

Now you can see the ports by running the docker port command.

.. code-block:: bash

	$ docker port static-site
	443/tcp -> 0.0.0.0:32770
	80/tcp -> 0.0.0.0:32771

If you are running Docker for Mac, Docker for Windows, or Docker on Linux, you can open `http://localhost:[YOUR_PORT_FOR 80/tcp]`. For our example this is `http://localhost:32771`.

|static_site_docker|

.. Note::

	`-P` will publish all the exposed container ports to random ports on the Docker host. However if you want to assign a fixed port then you can use `-p` option

.. code-block:: bash

	$ docker run --name static-site2 -d -p 8088:80 dockersamples/static-site
	8ed06daa0d8d8e0b0367bc3c035d2d729e6523c2a41818ebe92589c027d68c9e

If you are running Docker for Mac, Docker for Windows, or Docker on Linux, you can open `http://localhost:[YOUR_PORT_FOR 80/tcp]`. For our example this is `http://localhost:8088`.

Let's stop and remove the containers since you won't be using them anymore.

.. code-block:: bash

	$ docker stop static-site static-site2
	$ docker rm static-site static-site2

Let's use a shortcut to remove the both the containers:

.. code-block:: bash

	$ docker rm -f static-site static-site2

Run docker ps to make sure the containers are gone.

.. code-block:: bash

	$ docker ps
	CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES

Exercise 1 (10 mins)
~~~~~~~~~~~~~~~~~~~~

- Build a static website
- Run it on your machine
- Share your (non-localhost) url on slack

Solution
~~~~~~~~

Deploying dynamic website
~~~~~~~~~~~~~~~~~~~~~~~~~

In this section, let's dive deeper into what Docker images are. Later on we will build your own image and use that image to run an application locally (deploy a dynamic website).

Docker images
^^^^^^^^^^^^^

Docker images are the basis of containers. In the previous example, you pulled the `dockersamples/static-site` image from the registry and asked the Docker client to run a container based on that image. To see the list of images that are available locally on your system, run the docker images command.

.. code-block:: bash

	$ docker images
	REPOSITORY             		TAG                 IMAGE ID            CREATED             SIZE
	dockersamples/static-site   latest              92a386b6e686        2 hours ago        190.5 MB
	nginx                  		latest              af4b3d7d5401        3 hours ago        190.5 MB
	hello-world             	latest              690ed74de00f        5 months ago       960 B
	.........

Above is a list of images that I've pulled from the registry and those I've created myself (we'll shortly see how). You will have a different list of images on your machine. The TAG refers to a particular snapshot of the image and the ID is the corresponding unique identifier for that image.

For simplicity, you can think of an image akin to a git repository - images can be committed with changes and have multiple versions. When you do not provide a specific version number, the client defaults to latest.

For example you could pull a specific version of ubuntu image as follows:

.. code-block:: bash

	$ docker pull ubuntu:16.04

If you do not specify the version number of the image then, as mentioned, the Docker client will default to a version named latest.

So for example, the docker pull command given below will pull an image named `ubuntu:latest:`

.. code-block:: bash

	$ docker pull ubuntu

To get a new Docker image you can either get it from a registry (such as the Docker hub) or create your own. There are hundreds of thousands of images available on Docker hub. You can also search for images directly from the command line using `docker search`.

.. code-block:: bash

	$ docker search ubuntu


An important distinction with regard to images is between base images and child images and official images and user images (Both of which can be base images or child images.).

.. important::
	**Base images** are images that have no parent images, usually images with an OS like ubuntu, alpine or debian.

	**Child images** are images that build on base images and add additional functionality.

	**Official images** are Docker sanctioned images. Docker, Inc. sponsors a dedicated team that is responsible for reviewing and publishing all Official Repositories content. This team works in collaboration with upstream software maintainers, security experts, and the broader Docker community. These are not prefixed by an organization or user name. In the list of images above, the python, node, alpine and nginx images are official (base) images. To find out more about them, check out the Official Images Documentation.

	**User images** are images created and shared by users like you. They build on base images and add additional functionality. Typically these are formatted as user/image-name. The user value in the image name is your Docker Store user or organization name.

Flask app
^^^^^^^^^

Now that you have a better understanding of images, it's time to create an image that sandboxes a small `Flask <http://flask.pocoo.org/>`_ application. We'll do this by first pulling together the components for a random cat picture generator built with Python Flask, then dockerizing it by writing a Dockerfile. Finally, we'll build the image, and then run it.

- `Create a Python Flask app that displays random cat`_
- `Build the image`_
- `Run your image`_

.. _Create a Python Flask app that displays random cat:

1. Create a Python Flask app that displays random cat

For the purposes of this workshop, we've created a fun little Python Flask app that displays a random cat .gif every time it is loaded - because, you know, who doesn't like cats?

Start by creating a directory called `flask-app` where we'll create the following files:

- `app.py`_
- `requirements.txt`_
- `templates/index.html`_
- `Dockerfile`_

.. code-block:: bash

	$ mkdir flask-app && cd flask-app

.. _app.py:

1.1 **app.py**

Create the `app.py` file with the following content. You can use any of favorite text editor to create this file.

.. code-block:: bash

	from flask import Flask, render_template
	import random

	app = Flask(__name__)

	# list of cat images
	images = [
	    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr05/15/9/anigif_enhanced-buzz-26388-1381844103-11.gif",
	    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr01/15/9/anigif_enhanced-buzz-31540-1381844535-8.gif",
	    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr05/15/9/anigif_enhanced-buzz-26390-1381844163-18.gif",
	    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr06/15/10/anigif_enhanced-buzz-1376-1381846217-0.gif",
	    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr03/15/9/anigif_enhanced-buzz-3391-1381844336-26.gif",
	    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr06/15/10/anigif_enhanced-buzz-29111-1381845968-0.gif",
	    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr03/15/9/anigif_enhanced-buzz-3409-1381844582-13.gif",
	    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr02/15/9/anigif_enhanced-buzz-19667-1381844937-10.gif",
	    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr05/15/9/anigif_enhanced-buzz-26358-1381845043-13.gif",
	    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr06/15/9/anigif_enhanced-buzz-18774-1381844645-6.gif",
	    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr06/15/9/anigif_enhanced-buzz-25158-1381844793-0.gif",
	    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr03/15/10/anigif_enhanced-buzz-11980-1381846269-1.gif"
	]

	@app.route('/')
	def index():
	    url = random.choice(images)
	    return render_template('index.html', url=url)

	if __name__ == "__main__":
	    app.run(host="0.0.0.0")

.. _requirements.txt:

1.2. **requirements.txt**

In order to install the Python modules required for our app, we need to create a file called `requirements.txt` and add the following line to that file:

.. code-block:: bash

	Flask==0.10.1

.. _templates/index.html:

1.3. **templates/index.html**

Create a directory called `templates` and create an `index.html` file in that directory with the following content in it:

.. code-block:: bash

	$ mkdir templates && cd templates

.. code-block:: bash

	<html>
	  <head>
	    <style type="text/css">
	      body {
	        background: black;
	        color: white;
	      }
	      div.container {
	        max-width: 500px;
	        margin: 100px auto;
	        border: 20px solid white;
	        padding: 10px;
	        text-align: center;
	      }
	      h4 {
	        text-transform: uppercase;
	      }
	    </style>
	  </head>
	  <body>
	    <div class="container">
	      <h4>Cat Gif of the day</h4>
	      <img src="{{url}}" />
	      <p><small>Courtesy: <a href="http://www.buzzfeed.com/copyranter/the-best-cat-gif-post-in-the-history-of-cat-gifs">Buzzfeed</a></small></p>
	    </div>
	  </body>
	</html>

.. _Dockerfile:

1.4. **Dockerfile**

We want to create a Docker image with this web app. As mentioned above, all user images are based on a base image. Since our application is written in Python, we will build our own Python image based on `Alpine`. We'll do that using a Dockerfile.

A **Dockerfile** is a text file that contains a list of commands that the Docker daemon calls while creating an image. The Dockerfile contains all the information that Docker needs to know to run the app — a base Docker image to run from, location of your project code, any dependencies it has, and what commands to run at start-up. It is a simple way to automate the image creation process. The best part is that the commands you write in a Dockerfile are almost identical to their equivalent Linux commands. This means you don't really have to learn new syntax to create your own Dockerfiles.

1.4.1 Create a file called Dockerfile, and add content to it as described below.

We'll start by specifying our base image, using the FROM keyword:

.. code-block:: bash

	FROM alpine:3.5

1.4.2. The next step usually is to write the commands of copying the files and installing the dependencies. But first we will install the Python pip package to the alpine linux distribution. This will not just install the pip package but any other dependencies too, which includes the python interpreter. Add the following `RUN` command next:

.. code-block:: bash

	RUN apk add --update py2-pip

1.4.3 Let's add the files that make up the Flask Application. Install all Python requirements for our app to run. This will be accomplished by adding the lines:

.. code-block:: bash

	COPY requirements.txt /usr/src/app/
	RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

Copy the files you have created earlier into our image by using `COPY` command.

.. code-block:: bash

	COPY app.py /usr/src/app/
	COPY templates/index.html /usr/src/app/templates/

1.4.4. Specify the port number which needs to be exposed. Since our flask app is running on 5000 that's what we'll expose.

.. code-block:: bash

	EXPOSE 5000

1.4.5. The last step is the command for running the application which is simply - `python ./app.py`. Use the `CMD` command to do that:

.. code-block:: bash

	CMD ["python", "/usr/src/app/app.py"]

The primary purpose of `CMD` is to tell the container which command it should run by default when it is started.

1.4.6. Verify your Dockerfile.

Our Dockerfile is now ready. This is how it looks:

.. code-block:: bash

	# our base image
	FROM alpine:3.5

	# Install python and pip
	RUN apk add --update py2-pip

	# install Python modules needed by the Python app
	COPY requirements.txt /usr/src/app/
	RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

	# copy files required for the app to run
	COPY app.py /usr/src/app/
	COPY templates/index.html /usr/src/app/templates/

	# tell the port number the container should expose
	EXPOSE 5000

	# run the application
	CMD ["python", "/usr/src/app/app.py"]

.. _Build the image:

2. Build the image

Now that you have your Dockerfile, you can build your image. The docker build command does the heavy-lifting of creating a docker image from a Dockerfile.

.. Note::

	When you run the docker build command given below, make sure to replace `<YOUR_USERNAME>` with your username. This username should be the same one you created when registering on Docker hub. If you haven't done that yet, please go ahead and create an account.

The docker build command is quite simple - it takes an optional tag name with the `-t` flag, and the location of the directory containing the Dockerfile - the `.` indicates the current directory:

.. code-block:: bash

	$ docker build -t <YOUR_DOCKERHUB_USERNAME>/myfirstapp .
	Sending build context to Docker daemon   7.68kB
	Step 1/8 : FROM alpine:3.5
	 ---> 88e169ea8f46
	Step 2/8 : RUN apk add --update py2-pip
	 ---> Using cache
	 ---> 8b1f026c3899
	Step 3/8 : COPY requirements.txt /usr/src/app/
	 ---> Using cache
	 ---> 6923f451ee09
	Step 4/8 : RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt
	 ---> Running in fb6b7b8beb3c
	Collecting Flask==0.10.1 (from -r /usr/src/app/requirements.txt (line 1))
	  Downloading Flask-0.10.1.tar.gz (544kB)
	Collecting Werkzeug>=0.7 (from Flask==0.10.1->-r /usr/src/app/requirements.txt (line 1))
	  Downloading Werkzeug-0.14.1-py2.py3-none-any.whl (322kB)
	Collecting Jinja2>=2.4 (from Flask==0.10.1->-r /usr/src/app/requirements.txt (line 1))
	  Downloading Jinja2-2.10-py2.py3-none-any.whl (126kB)
	Collecting itsdangerous>=0.21 (from Flask==0.10.1->-r /usr/src/app/requirements.txt (line 1))
	  Downloading itsdangerous-0.24.tar.gz (46kB)
	Collecting MarkupSafe>=0.23 (from Jinja2>=2.4->Flask==0.10.1->-r /usr/src/app/requirements.txt (line 1))
	  Downloading MarkupSafe-1.0.tar.gz
	Installing collected packages: Werkzeug, MarkupSafe, Jinja2, itsdangerous, Flask
	  Running setup.py install for MarkupSafe: started
	    Running setup.py install for MarkupSafe: finished with status 'done'
	  Running setup.py install for itsdangerous: started
	    Running setup.py install for itsdangerous: finished with status 'done'
	  Running setup.py install for Flask: started
	    Running setup.py install for Flask: finished with status 'done'
	Successfully installed Flask-0.10.1 Jinja2-2.10 MarkupSafe-1.0 Werkzeug-0.14.1 itsdangerous-0.24
	You are using pip version 9.0.0, however version 9.0.1 is available.
	You should consider upgrading via the 'pip install --upgrade pip' command.
	 ---> 16d47a8073fd
	Removing intermediate container fb6b7b8beb3c
	Step 5/8 : COPY app.py /usr/src/app/
	 ---> 338019e5711f
	Step 6/8 : COPY templates/index.html /usr/src/app/templates/
	 ---> b65ed769c446
	Step 7/8 : EXPOSE 5000
	 ---> Running in b95001d36e4d
	 ---> 0deaa29ca54a
	Removing intermediate container b95001d36e4d
	Step 8/8 : CMD python /usr/src/app/app.py
	 ---> Running in 4a8e82f87e2f
	 ---> 40a121fff878
	Removing intermediate container 4a8e82f87e2f
	Successfully built 40a121fff878
	Successfully tagged upendradevisetty/myfirstapp:latest

If you don't have the alpine:3.5 image, the client will first pull the image and then create your image. Therefore, your output on running the command will look different from mine. If everything went well, your image should be ready! Run docker images and see if your image (<YOUR_USERNAME>/myfirstapp) shows.

.. _Run your image:

3. Run your image

The next step in this section is to run the image and see if it actually works.

.. code-block:: bash

	$ docker run -d -p 8888:5000 --name myfirstapp <YOUR_DOCKERHUB_USERNAME>/myfirstapp

Head over to http://localhost:8888 and your app should be live. 

.. Note::
	
	If you are using Docker Machine, you may need to open up another terminal and determine the container ip address using `docker-machine ip default`.

|catpic|

Hit the Refresh button in the web browser to see a few more cat images.

Exercise 2 (10 mins)
~~~~~~~~~~~~~~~~~~~~

- Build your website with Dockerfile
- Run an instance
- Share your (non-localhost) url on Slack

Solution
~~~~~~~~

Dockerfile commands summary
===========================

Here's a quick summary of the few basic commands we used in our Dockerfile.

- FROM starts the Dockerfile. It is a requirement that the Dockerfile must start with the FROM command. Images are created in layers, which means you can use another image as the base image for your own. The FROM command defines your base layer. As arguments, it takes the name of the image. Optionally, you can add the Docker Cloud username of the maintainer and image version, in the format username/imagename:version.

- RUN is used to build up the Image you're creating. For each RUN command, Docker will run the command then create a new layer of the image. This way you can roll back your image to previous states easily. The syntax for a RUN instruction is to place the full text of the shell command after the RUN (e.g., RUN mkdir /user/local/foo). This will automatically run in a /bin/sh shell. You can define a different shell like this: RUN /bin/bash -c 'mkdir /user/local/foo'

- COPY copies local files into the container.

- CMD defines the commands that will run on the Image at start-up. Unlike a RUN, this does not create a new layer for the Image, but simply runs the command. There can only be one CMD per a Dockerfile/Image. If you need to run multiple commands, the best way to do that is to have the CMD run a script. CMD requires that you tell it where to run the command, unlike RUN. So example CMD commands would be:

.. code-block:: bash

	CMD ["python", "./app.py"]

	CMD ["/bin/bash", "echo", "Hello World"]

- EXPOSE creates a hint for users of an image which ports provide services. It is included in the information which can be retrieved via $ docker inspect <container-id>.

.. Note::

	The EXPOSE command does not actually make any ports accessible to the host! Instead, this requires publishing ports by means of the -p flag when using $ docker run.

- PUSH pushes your image to Docker Cloud, or alternately to a private registry

.. Note::

	If you want to learn more about Dockerfiles, check out Best practices for writing Dockerfiles.

Demo's
======

Portainer
~~~~~~~~~

`Portainer <https://portainer.io/>`_ is an open-source lightweight managment UI which allows you to easily manage your Docker hosts or Swarm cluster.

- Simple to use: It has never been so easy to manage Docker. Portainer provides a detailed overview of Docker and allows you to manage containers, images, networks and volumes. It is also really easy to deploy, you are just one Docker command away from running Portainer anywhere.

- Made for Docker: Portainer is meant to be plugged on top of the Docker API. It has support for the latest versions of Docker, Docker Swarm and Swarm mode.

Installation
^^^^^^^^^^^^

Use the following Docker commands to deploy Portainer. Now the second line of command should be familiar to you by now. We will talk about first line of command in the advanced Docker session.

.. code-block:: bash

	$ docker volume create portainer_data

	$ docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

You'll just need to access the port 9000 of the Docker engine where portainer is running using your browser using username `admin` and password `tryportainer`

.. Note:: 
	
	The `-v /var/run/docker.sock:/var/run/docker.sock` option can be used in mac/linux environments only.

|portainer_demo|

Play-with-docker (PWD)
~~~~~~~~~~~~~~~~~~~~~~

`PWD <http://www.play-with-docker.com/>`_ is a Docker playground which allows users to run Docker commands in a matter of seconds. It gives the experience of having a free Alpine Linux Virtual Machine in browser, where you can build and run Docker containers and even create clusters in `Docker Swarm Mode <https://docs.docker.com/engine/swarm/>`_. Under the hood Docker-in-Docker (DinD) is used to give the effect of multiple VMs/PCs. In addition to the playground, PWD also includes a training site composed of a large set of Docker labs and quizzes from beginner to advanced level available at `training.play-with-docker.com <http://training.play-with-docker.com/>`_.

Installation
^^^^^^^^^^^^

You don't have to install anything to use PWD. Just open https://labs.play-with-docker.com/ and start using PWD

.. Note::

	You can use your Dockerhub credentials to log-in to PWD

|pwd|

.. |static_site_docker| image:: ./img/static_site_docker.png
  :width: 750
  :height: 700

.. |portainer_demo| image:: ./img/portainer_demo.png
  :width: 750
  :height: 700

.. |pwd| image:: ./img/pwd.png
  :width: 750
  :height: 700

.. |catpic| image:: ./img/catpic-1.png
  :width: 750
  :height: 700  