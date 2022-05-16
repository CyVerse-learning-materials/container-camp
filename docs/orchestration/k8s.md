[:material-kubernetes: Kubernetes](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/){target=_blank}, often abbreviated as `K8s`, is an open-source system for automating deployment, scaling, and management of containerized applications.

K8s is the most widely used platform for managing containerized applications at scale in Cloud computing.

Leveraging a K8s Cluster is likely if you adopt containers into your research portfolio.

In these introductory lessons we will be discussing how to leverage *existing* Kubernetes Clusters using `kubectl`

??? Question ":material-scale-balance: Why build your own K8s Cluster? "

    Learning about containerized applications and container orchestration is why you're here afterall. We want to at least expose you to the existence of these technologies and to help you understand how they fit within the roadmap of Cloud Native Computing. With that said,

    :warning: __Designing, deploying and running your own K8s cluster is very likely a bad idea__ :warning:
    
      - Partly because there are so many other existing platforms out there, i.e., other managed K8s services, but also because the engineering and technological understanding of managing K8s requires a dedicated DevOps or software engineering team to keep your platform running.

    Still not deterred?

    Reasons why you may need to use K8s for your research:

    (1) Your applications consist of multiple services. K8s API automates the tasks of managing many containers and provision resources. 

    (2) Your work scales dynamically - if you need more or less quantities of computing depending on workloads, K8s might be useful. The ability to use containers to scale your applications is easier than launching VMs by hand.

    (3) You have too many containers to keep track of - K8s is good at what it was made for, managing and keeping containers up and running. 

    (4) Its all going to the cloud anyway. If your science domain is moving towards being cloud-native, you need to build your workflows for the time of migration.

    (5) Its consistent. K8s declarative state describes exactly how everything is managed.

!!! Info "Kubernetes Terminology"

    **:material-kubernetes: Kubernetes Cluster** is a set of nodes that run containerized applications.

    **:octicons-terminal-24: kubectl** is the command line interface for connecting to K8s clusters

    **:octicons-container-24: Pod** is the smallest deployable unit of Kubernetes, can be one or more containers that talk to one another. *Pods* are run on *Nodes*

    **:fontawesome-solid-share-nodes: Node**: typically run on a virtual machine (VM), a *Nodes* components include *kubelet*, *kube-proxy*, and *Container run-time*
    
    **Kubelet** is the *Node* agent that manages the *Pods* on each VM
    
    **Kube-proxy** is used by a *Service* to run a network proxy on each *Node*
    
    **Container runtime** is the software responsible for running containers in the *Pods*. Example containers that K8s users are: `Docker`, `containerd` (native), and `CRI-O`.
    
    **Service** sets up a network address for an application, including a persistent IP address and a local DNS entry within the *cluster*. *Service* load balances across the *Pods* and can add or remove them.

    **ReplicaSet** is a convenient way to build multiple pods at once.

    **Deployment** provides declarative updates for Pods and ReplicaSets (rolling updates)
    
    **Control Pane** is a node that controls/manages worker nodes. The components of the Control Pane are the *API server*, the *cluster store*, the *controller manager*, and the *scheduler*.
    

## Introduction to K8s CLI with `kubectl`

The Kubernetes API uses a command-line tool called `kubectl`

Using K8s does not require you to own or maintain your own cluster. You can use the `kubectl` tool to connect to running clusters and start your containers.

### Install `kubectl`

[Official Documentation](https://kubernetes.io/docs/tasks/tools/){target=_blank}

`kubectl` is already installed in CodeSpaces.

To install on Linux:

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

### :material-kubernetes: kubconfig 

Kuberenetes uses combinations of JSON and YAML files for configuring a cluster. 

#### generating a `config` yaml

To connect to a running K8s cluster that is managed by someone else, you need to create a `config.yaml` and place it in the `~/.kube/config` folder

!!! info "config example"

    Example of the `~/.kube/config` file used for minikube
    
    ```
    apiVersion: v1
    clusters:
    - cluster:
        certificate-authority: /home/exouser/.minikube/ca.crt
        extensions:
        - extension:
            last-update: Mon, 16 May 2022 15:59:19 UTC
            provider: minikube.sigs.k8s.io
            version: v1.25.2
        name: cluster_info
        server: https://192.168.49.2:8443
    name: minikube
    contexts:
    - context:
        cluster: minikube
        extensions:
        - extension:
            last-update: Mon, 16 May 2022 15:59:19 UTC
            provider: minikube.sigs.k8s.io
            version: v1.25.2
        name: context_info
        namespace: default
        user: minikube
    name: minikube
    current-context: minikube
    kind: Config
    preferences: {}
    users:
    - name: minikube
    user:
        client-certificate: /home/exouser/.minikube/profiles/minikube/client.crt
        client-key: /home/exouser/.minikube/profiles/minikube/client.key
    ```

### :material-kubernetes: pods

#### Launching a Pod

####

