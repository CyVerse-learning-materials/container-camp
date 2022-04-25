# Advanced Docker Techniques

## Volumes

When you run a container, you can bring a directory from the host system
into the container, and give it a new name and location using the `-v`
or `--volume` flag.

``` bash
$ mkdir -p ~/local-data-folder
$ echo "some data" >> ~/local-data-folder/data.txt
$ docker run -v ${HOME}/local-data-folder:/data $YOUR_DOCKERHUB_USERNAME/mynotebook:latest cat /data/data.txt
```

In the example above, you can mount a folder from your localhost, in
your home user directory into the container as a new directory named
`/data`.

### Create and manage volumes

Unlike a bind mount, you can create and manage volumes outside the scope
of any container.

A given volume can be mounted into multiple containers simultaneously.
When no running container is using a volume, the volume is still
available to Docker and is not removed automatically. You can remove
unused volumes using `docker volume prune` command.

When you create a Docker volume, it is stored within a directory on the
Docker Linux host (`/var/lib/docker/`).

!!! Note
        File location on Mac OS X is a bit different:
        <https://timonweb.com/posts/getting-path-and-accessing-persistent-volumes-in-docker-for-mac/>

Let's create a volume

``` bash
$ docker volume create my-vol
```

List volumes:

``` bash
$ docker volume ls

local               my-vol
```

Inspect a volume by looking at the Mount section in the `docker volume inspect`

``` bash
$ docker volume inspect my-vol
[
    {
        "Driver": "local",
        "Labels": {},
        "Mountpoint": "/var/lib/docker/volumes/my-vol/_data",
        "Name": "my-vol",
        "Options": {},
        "Scope": "local"
    }
]
```

Remove a volume

``` bash
$ docker volume rm my-vol
$ docker volume ls
```

### Populate a volume using a container

This example starts an `alpine` container and populates the new volume
`output-vol` with the some output created by the container.

``` bash
docker volume create output-vol
docker run --name=data-app --mount source=output-vol,target=/data alpine sh -c 'env >> /data/container-env.txt'
```

Use `docker inspect output-vol` to see where the volume data lives on
your host, and then use `cat` to confirm that it contains the output
created by the container.

``` bash
docker volume inspect output-vol
sudo cat /var/lib/docker/volumes/output-vol/_data/container-env.txt
```

You should see something like:

``` 
HOSTNAME=790e13bba28a
SHLVL=1
HOME=/root
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PWD=/
```

After running either of these examples, run the following commands to
clean up the container and volume.

``` bash
docker rm data-app
docker volume rm output-vol
```

---

## Bind mounts

**Bind mounts:** When you use a bind mount, a file or directory on the
host machine is mounted into a container.

??? Tip
    If you are developing new Docker applications, consider using named
    **volumes** instead. You can't use Docker CLI commands to directly
    manage bind mounts.

![bind_mount](../assets/docker/bind_mount.png)

!!! Warning
        One side effect of using bind mounts, for better or for worse, is that
        you can change the host filesystem via processes running in a container,
        including creating, modifying, or deleting important system files or
        directories. This is a powerful ability which can have security
        implications, including impacting non-Docker processes on the host
        system.

        If you use `--mount` to bind-mount a file or directory that does not yet
        exist on the Docker host, Docker does not automatically create it for
        you, but generates an error.

### Start a container with a bind mount

Create a `bind-data` directory in your home directory.

``` bash
cd ~
mkdir -p ~/bind-data
```

Run a container, mounting this directory inside the container, and the
container should create some data in there.

``` bash
docker run --mount type=bind,source="$(pwd)"/bind-data,target=/data alpine sh -c 'env >> /data/container-env.txt'
```

Check that the output looks right.

``` bash
cat ~/bind-data/container-env.txt
```

### Use a read-only bind mount

For some development applications, the container needs to write into the
bind mount, so changes are propagated back to the Docker host. At other
times, the container only needs read access.

This example modifies the one above but mounts the directory as a
read-only bind mount, by adding `ro` to the (empty by default) list of
options, after the mount point within the container. Where multiple
options are present, separate them by commas.

``` bash
docker run --mount type=bind,source="$(pwd)"/bind-data,target=/data,readonly alpine sh -c 'ls -al /data/ && env >> /data/container-env.txt'
```

You should see an error message about not being able to write to a
read-only file system.

``` bash
sh: can't create /data/container-env.txt: Read-only file system
```