[:material-kubernetes: Kubernetes](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/){target=_blank}, often abbreviated as `K8s`, is an open-source system for automating deployment, scaling, and management of containerized applications.

K8s is the most widely used platform for managing containerized applications in cloud.

Leveraging K8s for your research is highly likely as you adopt containers into your research. 

??? Question ":material-scale-balance: Why build your own K8s? "

    Learning about containerized applications and container orchestration is why you're here and we wanted to expose you to these technologies. 

    With that said,

    :warning: __Designing, deploying and running your own K8s cluster is very likely a bad idea__ :warning:
    
    This is partly because there are so many other options out there for you to use, i.e., other managed K8s platforms, but also because the engineering and technological understanding of managing K8s requires a dedicated DevOps or software engineering team to keep your platform running.

    Still not deterred?

    Reasons why you may need to use K8s for your research:

    (1) Your applications consist of multiple services. K8s API automates the tasks of managing many containers and provision resources. 

    (2) Your work scales dynamically - if you need more or less quantities of computing depending on workloads, K8s might be useful. The ability to use containers to scale your applications is easier than launching VMs by hand.

    (3) You have too many containers to keep track of - K8s is good at what it was made for, managing and keeping containers up and running. 

    (4) Its all going to the cloud anyway. If your science domain is moving towards being cloud-native, you need to build your workflows for the time of migration.

    (5) Its consistent. K8s declarative state describes exactly how everything is managed.

!!! Info "Kubernetes Terminology"

    **:octicons-container-24: Pod** is the smallest deployable unit of Kubernetes, can be one or more containers that talk to one another. *Pods* are run on *Nodes*
    
    **:fontawesome-solid-share-nodes: Node**: typically run on a virtual machine (VM), a *Nodes* components include *kubelet*, *kube-proxy*, and *Container run-time*
    
    **Kubelet** is the *Node* agent that manages the *Pods* on each VM
    
    **Kube-proxy** is used by a *Service* to run a network proxy on each *Node*
    
    **Container runtime** is the software responsible for running containers in the *Pods*. Example containers that K8s users are: `Docker`, `containerd` (native), and `CRI-O`.
    
    **Service** sets up a network address for an application, including a persistent IP address and a local DNS entry within the *cluster*. *Service* load balances across the *Pods* and can add or remove them.

    **ReplicaSet** is a convenient way to build multiple pods at once.

    **Deployment** provides declarative updates for Pods and ReplicaSets (rolling updates)
    
    **Control Pane** is a node that controls/manages worker nodes. The components of the Control Pane are the *API server*, the *cluster store*, the *controller manager*, and the *scheduler*.
    
## :material-ship-wheel: Helm

[Helm](https://helm.sh/){target=_blank} is the package manager for Kubernetes. 

## Deploy a Kubernetes cluster

We are going to be using Jetstream-2 for this section and will rely on their [documentation for Kubernetes deployment](https://docs.jetstream-cloud.org/general/kubernetes/){target=_blank}

### Zero to JupyterHub

[JupyterHub for Kubernetes](https://zero-to-jupyterhub.readthedocs.io/en/latest/index.html){target=_blank}

Project Jupyter maintains a lesson on deploying K8s and Helm with `minik8s` across a variety of commercial cloud solutions.

The closest example that you can attempt is the [Bare Metal example](https://zero-to-jupyterhub.readthedocs.io/en/latest/kubernetes/other-infrastructure/step-zero-microk8s.html){target=_blank} on JS-2

## Configurations

Kuberenetes uses combinations of JSON and YAML files for configuring a cluster. 
