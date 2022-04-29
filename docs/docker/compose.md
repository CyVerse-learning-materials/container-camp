# Running multi-container Applications with Docker Compose

[:material-docker: Docker Compose](https://docs.docker.com/compose){target=_blank} is an extension of Docker which allows you to run multiple containers synchronously and in communication with one another. 

Compose allows you to define and run a multi-container service using a `Dockerfile` and a `docker-compose.yml`. 

!!! Note
        Docker for Mac and Docker Toolbox already include Compose along with
        other Docker apps, so Mac users do not need to install Compose
        separately. Docker for Windows and Docker Toolbox already include
        Compose along with other Docker apps, so most Windows users do not need
        to install Compose separately.

        For Linux users

        ``` bash
        sudo curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

        sudo chmod +x /usr/local/bin/docker-compose
        ```

Main advantages of Docker compose include:

-   Your applications can be defined in a YAML file where all the same
    options required in `docker run` are now defined (reproducibility).
-   It allows you to manage your application(s) as a single entity
    rather than dealing with starting individual containers
    (simplicity).

!!! Note
        For the sake of this example, either create your own `Dockerfile` or use the same Jupyter SciPy Notebook as in the [Advanced Section](advanced.md)

---

## Creating a `docker-compose.yml`

Let's now create a Docker Compose `.yml` that calls Jupyter Lab SciPy

1\.  Copy or create the `jupyter_compose` directory

``` bash
$ mkdir jupyter_compose && cd jupyter_compose
```

We will also create `data/` and `notebooks/` folders to stage our future
data and notebook work

``` bash
$ mkdir jupyter_compose/data
$ mkdir jupyter_compose/notebooks
```

2\.  Copy or create a `entry.sh` and a `jupyter_notebook_config.json` in
    the `jupyter_compose/` directory

`entry.sh` creates an iRODS environment JSON with the user\'s name and
CyVerse (iPlant) zone.

``` bash
#!/bin/bash

echo '{"irods_host": "data.cyverse.org", "irods_port": 1247, "irods_user_name": "$IPLANT_USER", "irods_zone_name": "iplant"}' | envsubst > $HOME/.irods/irods_environment.json

exec jupyter lab --no-browser
```

`jupyter_notebook_config.json` starts the notebook without requiring you
to add the token:

``` bash
{
  "NotebookApp": {
    "allow_origin" : "*",
    "token":"",
    "password":"",
    "nbserver_extensions": {
      "jupyterlab": true
    }
  }
}
```

3\.  create your `docker-compose.yml` in the same directory
    `jupyter_compose/`
4\.  Edit the contents of your `docker-compose.yml`

``` bash
version: "3"
services:
  scipy-notebook:
     build: .
     image:    jupyter/scipy-notebook
     volumes:
      - "./notebooks:/notebooks"
      - "./data:/data"
      - ${LOCAL_WORKING_DIR}:/home/jovyan/work
     ports:
      - "8888:8888"
     container_name:   jupyter_scipy
     command: "entry.sh"
     restart: always
```
4\.  Build the container with `docker-compose` instead of `docker build`

!!! Note
        Handling containers with Docker Compose is fairly simple

        ``` bash
        docker-compose up
        ```

        mounts the directory and starts the container

        ``` bash
        docker-compose down
        ```

        destroys the container

A brief explanation of `docker-compose.yml` is as below:

-   The web service builds from the Dockerfile in the current directory.
-   Forwards the container's exposed port to port 8888 on the host.
-   Mounts the project directory on the host to /notebooks inside the
    container (allowing you to modify code without having to rebuild the
    image).
-   `restart: always` means that it will restart whenever it fails.

---

## Running `docker-compose`

Run the container

``` bash
$ docker-compose up -d
```

And that's it! You should be able to see the application running on
`http://localhost:8888` or `<ipaddress>:8888`

![docker_compose](../assets/docker/dc-1.png)

## Shutting down and restarting `docker-compose`

---

## Examples that use Docker-Compose

!!! Warning
    For the purpose of these following examples it is not suggested to use GitHub Codespaces.

### Example 1: WebODM

[:material-quadcopter: Web Open Drone Map (WebODM)](https://github.com/OpenDroneMap/WebODM/#run-it-on-the-cloud-google-compute-amazon-aws)

OpenDroneMap is an open source photogrammetry toolkit to process aerial imagery into maps and 3D models running on command line. WebODM (Web OpenDroneMap) is an extension of ODM running on multiple Docker Containers provinding a user friendly web interface for easy visualization.

To use WebODM:

!!! Note "Prerequisites"
    WebODM requires `docker`, `docker-compose` to function. Additionally, if you are on Windows, users will be required to have the [Docker Windows Application](https://docs.docker.com/desktop/windows/install/) installed as well as having the [WSL2](https://docs.microsoft.com/en-us/windows/wsl/install) (Windows Subsystem for Linux) operational.
    
1. Ensure your machine is up to date: `sudo apt-get update && sudo apt-get upgrade -y`
2. Clone the WebODM repository: `git clone https://github.com/OpenDroneMap/WebODM --config core.autocrlf=input --depth 1`
3. Move into the WebODM folder: `cd WebODM`
4. Run WebODM: `sudo ./webodm.sh start`
5. The necessary docker images will be downloaded (~2 minutes) and WebODM will be accessible through http://localhost:8000/

!!! Note
    You will be asked to create an account as a formality. Add any *username* and a *password* and select **Create Account**.

6\. Download example data: `clone https://github.com/OpenDroneMap/odm_data_aukerman.git`. This git repository contains 77 HD images usable for WebODM. For other examples refer to [ODMData](https://www.opendronemap.org/odm/datasets/).

7\. In the WebODM portal, click on **Select Images and GCP**, navigate to `odm_data_aukerman/images` and select between 20-50 images (16 is the absolute minimum, whilst 32 is the suggested minimum).

![webodm_1](../assets/docker/WebODM_01.png)

8\. WebODM will process the uploaded images (~5-10 minutes); upon completion, click **View Map**.

![webodm_2](../assets/docker/WebODM_02.png)

9\. A map will open; you can click on **3D** (bottom right) to see the 3D rendered model generated.

![webodm_3](../assets/docker/WebODM_03.png)

### Example 2: OpenSearch

[:material-search-web: OpenSearch](https://opensearch.org/downloads.html#docker-compose)