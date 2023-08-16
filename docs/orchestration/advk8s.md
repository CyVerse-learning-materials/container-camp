
## Deploying your own Kubernetes clusters

We are going to be using Jetstream-2 for this section and will rely on their [documentation for Kubernetes deployment](https://docs.jetstream-cloud.org/general/kubernetes/){target=_blank}

### :material-ship-wheel: Helm

[Helm](https://helm.sh/){target=_blank} is the package manager that allows users to define, install, and manage K8s applications using [Helm Charts](https://helm.sh/docs/topics/charts/), which are packages of pre-configured Kubernetes resources.

Similarly to how Docker users can create their own containers and share them collaborators through DockerHub, Helm Charts are built by users and shared through repositories such as [artifacthub](https://artifacthub.io/). This allows for streamlining deployment and management for complex K8s orchestrations.

#### Helm example: [Zero2JupyterHub](https://z2jh.jupyter.org/en/latest/index.html)

1. Install Helm
    - Users can install Helm on their own machines by following the [official documentation](https://helm.sh/docs/intro/install/). For this example, we are going to assume that students are using a Unix OS. In that case, the following commands should work:
    ```
    curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
    sudo apt-get install apt-transport-https --yes
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
    sudo apt-get update
    sudo apt-get install helm
    ```
    !!! info
        If you are using the Virtual Machines provided by the CyVerse team, Helm is already installed.

2. Add the JupyterHub Helm repository, which contains the charts needed to deploy JupyterLab.
    ```
    helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
    helm repo update
    ```
    You can check if the help repository list by doing `help repo list`. You should see something like 
    ```
    NAME            URL
    jupyterhub      https://jupyterhub.github.io/helm-chart/
    ```
3. Obtain the `config.yaml`
    - One can write their own config file, but these take extensive work and deep understanding of charts. What we can do instead, is to *pull* the values that we need from Jupyterhub and save its output to a file. We can do that with the following command:
    ```
    helm show values jupyterhub/jupyterhub > jupyter.yaml
    ```
    - If you were to look inside this yaml file, you will see a long list of configurable lines. These values need not to be changed to execute the jupyterhub, apart from `secretToken`.
    - Generate the secret token with `openssl rand -hex 32`, copy the hex string and replace the `secretToken` line from the `jupyter.yml` file using a text editor (e.g., nano or vim). 
4. From within the folder, deploy the jupyterhub using the following command (installation should only take a minute):
    ```
    helm install jupyterhub jupyterhub/jupyterhub --values jupyter.yaml
    ```
5. Access the JupyterHub through your VM IP address!

??? tip "Uninstalling the chart"
    To uninstall the chart simply do
    ```
    helm uninstall jupyterhub
    ```

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