
## Deploying your own Kubernetes clusters

We are going to be using Jetstream-2 for this section and will rely on their [documentation for Kubernetes deployment](https://docs.jetstream-cloud.org/general/kubernetes/){target=_blank}

### :material-ship-wheel: Helm

[Helm](https://helm.sh/){target=_blank} is the package manager that allows users to define, install, and manage K8s applications using [Helm Charts](https://helm.sh/docs/topics/charts/), which are packages of pre-configured Kubernetes resources.

Similarly to how Docker users can create their own containers and share them collaborators through DockerHub, Helm Charts are built by users and shared through repositories such as [artifacthub](https://artifacthub.io/). This allows for streamlining deployment and management for complex K8s orchestrations.

#### Helm example: JupyterLab deployment

1. Install Helm
    - Users can install Helm on their own machines by following the [official documentation](https://helm.sh/docs/intro/install/). For this example, we are going to assume that students are using a Unix OS. In that case, the following commands should work:
    ```
    curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
    sudo apt-get install apt-transport-https --yes
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
    sudo apt-get update
    sudo apt-get install helm
    ```
2. Add the JupyterHub Helm repository, which contains the charts needed to deploy JupyterLab.
    ```
    helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
    helm repo update
    ```
3. Create a`config.yml` 
    - Create a folder for the example (e.g., `helm_jh_deployment/`), and populate it with the following `config.yml` configuration file.
    ```
    # config.yml

    # Configure the JupyterHub proxy
    proxy:
      secretToken: "<your own secret token>"

    # Specify the single-user servers (Notebook servers) configuration
    singleuser:
      defaultUrl: "/lab"
      image:
        name: jupyter/datascience-notebook
        tag: latest
      storage:
        type: dynamic
        dynamic:
          storageClass: standard
    ```
    - Generate the secret token with `openssl rand -hex 32`, copy the hex string and replace the `secretToken` line from the `config.yml` file. 
4. From within the folder, deply the jupyterhub using the following command:
    ```
    helm install my-jupyterhub jupyterhub/jupyterhub --version 3.0.1-0.dev.git.6287.hbfb05cd6 --values=config.yaml
    ```
5. Obtain IP address by doing `kubectl --namespace=my-jupyterhub get svc proxy-public` and connecting with <IP ADDRESS>:8080

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