[:material-kubernetes: Kubernetes](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/){target=_blank}, often abbreviated as `K8s`, is an open-source system for automating deployment, scaling, and management of containerized applications.

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

## Configurations

Kuberenetes uses combinations of JSON and YAML files for configuring a cluster. 