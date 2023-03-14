
## Deploying your own Kubernetes clusters

We are going to be using Jetstream-2 for this section and will rely on their [documentation for Kubernetes deployment](https://docs.jetstream-cloud.org/general/kubernetes/){target=_blank}

### :material-ship-wheel: Helm

[Helm](https://helm.sh/){target=_blank} is the package manager for Kubernetes. 

### Zero to JupyterHub

[JupyterHub for Kubernetes](https://zero-to-jupyterhub.readthedocs.io/en/latest/index.html){target=_blank}

Project Jupyter maintains a lesson on deploying K8s and Helm with `minik8s` across a variety of commercial cloud solutions.

The closest example that you can attempt is the [Bare Metal example](https://zero-to-jupyterhub.readthedocs.io/en/latest/kubernetes/other-infrastructure/step-zero-microk8s.html){target=_blank} on JS-2

## Miniaturized versions of Kubernetes

??? Question "Why use mini versions of Kubernetes?"

    There are multiple projects developing "light-weight" Kubernetes.

    The justification for these projects being that full Kubernetes deployments with all of its functionality increases the cognitive load and the number of configurations and parameters that you must work with when running containers and clusters, particularly at the edge.

    Projects that are working on miniaturized versions of K8s:

    | name | functionality | use cases | 
    |------|---------------|-----------|
    | [minikube](https://minikube.sigs.k8s.io/docs/start/){target=_blank} | | |
    | [microK8s](https://microk8s.io/){target=_blank} |  | runs fast, self-healing, and highly available Kubernetes clusters |    
    | [K3s](https://k3s.io/){target=_blank} | | runs production-level Kubernetes workloads on low resourced and remotely located IoT and Edge devices |
    | K3d | lightweight wrapper that runs K3s in a docker container | |

### Install `K3s`

[K3s](){target=_blank}

### Install `minikube`

[Minikube](https://minikube.sigs.k8s.io/docs/start/) is useful for running K8s on a single node or locally -- its primary use is to teach you how to use K8s.

```
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

sudo minikube config set vm-driver none
```

### Installing `microK8s`