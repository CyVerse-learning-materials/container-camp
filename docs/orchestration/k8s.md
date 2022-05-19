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

### :material-kubernetes: kubeconfig 

K8s uses YAML files for configuring a cluster. 

The `config` file is required to make the handshake between the K8s Cluster and external requests, like the one you're making from your local computer or CodeSpace.

#### `config` yaml

To connect to a running K8s cluster, you need to create a `config` yaml and place it in the `~/.kube/` folder.

??? info " example `config` file"

    Example of the `~/.kube/config` file which is used for K3s
    
    ```
   
    ```

1. Copy the `~/.kube/config` file from your cluster or use our example here over to your localhost or VM and put it into a temporary directory.

2. Make a second copy and put it into your own `~/.kube/config` folder

By default, the `config` file is in the `~/.kube/` directory, but it can be put anywhere or given any name, use the `--kubeconfig` flag to tell `kubectl` where to get the config:

```
kubectl --kubeconfig /custom/path/kube.config get pods
```

#### Setting up the `namespace`

`kubectl` needs to know what the `namespace` is of of the Cluster config you're working with. 

In the first example today, we're going to be working with a cluster with a pre-set `namespace`

To set the context and namespace of the cluster on your localhost:

```
kubectl config set-context cc2022 --namespace=containercamp2022
```

Once the config is set, you should be ready to launch "pods" i.e. containers on the cluster

### :material-kubernetes: pods

We are going to launch pods (w/ containers) on the same K3s cluster which is already running in JS-2.

Create a new file in your VM or localhost called `pod1.yaml` 

```
apiVersion: v1
kind: Pod
metadata:
  name: pod-<change-this-to-your-username>
spec:
  containers:
  - name: mypod
    image: alpine:3.14
    resources:
      limits:
        memory: 100Mi
        cpu: 100m
      requests:
        memory: 100Mi
        cpu: 100m
    command: ["sh", "-c", "sleep infinity"]
```

#### Launching a Pod

Try launching a pod on the cluster

```
kubectl create -f pod1.yaml
```

Check to see that it is running

```
kubectl get pods
```

Do you see any other pods?

If the pod hasn't started yet, you can check the timestamp to see if it was created:

```
kubectl get events --sort-by=.metadata.creationTimestamp
```

Try to connect to your running pod (container)

```
kubectl exec -it pod-<yourusername> -- /bin/sh
```

#### Pod networking

Let's check the networking inside the pod

```
# uncomment if ifconfig is not installed
# apk add net-tools
ifconfig -a
```

Exit the pod (`ctrl`^`D`)

Check the IP with `kubectl`

```
kubectl get pod -o wide pod-<yourname>
```

#### Taking down a Pod

Once you've exited the pod, delete it

```
kubectl delete -f pod1.yaml
```

double check that its gone

```
kubectl get pods
```

## Create a Deployment

While we can create and delete pods on our own, what we realy want is to make our containers have "high availability". 

High availiability means that when a node dies or is restarted, the pod will "come back up" on its own.

## Run a Dashboard

[UpCloud instructions](https://upcloud.com/community/tutorials/deploy-kubernetes-dashboard/){target=_blank}

Once the cluster is up and running, you may choose to create a Dashboard for it

The Dashboard can only run from a `localhost` so we have to do an ssh tunnel to connect to it

```
ssh -L localhost:8001:127.0.0.1:8001 <user>@<master_public_IP>
```

start the dashboard

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
```

check to see the dashboard pods are running

```
kubectl get pods -A
```

#### create an `admin` dashboard user

```
mkdir ~/dashboard && cd ~/dashboard
```

create a `dashboard-admin.yaml`

```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
```

deploy

```
kubectl apply -f dashboard-admin.yaml
```

print the `admin` token so you can log into the dashboard

```
kubectl get secret -n kubernetes-dashboard $(kubectl get serviceaccount admin-user -n kubernetes-dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode
```

#### create a read-only `dashboard-read-only.yaml` user

```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: read-only-user
  namespace: kubernetes-dashboard
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  annotations:
    rbac.authorization.kubernetes.io/autoupdate: "true"
  labels:
  name: read-only-clusterrole
  namespace: default
rules:
- apiGroups:
  - ""
  resources: ["*"]
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - extensions
  resources: ["*"]
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - apps
  resources: ["*"]
  verbs:
  - get
  - list
  - watch
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: read-only-binding
roleRef:
  kind: ClusterRole
  name: read-only-clusterrole
  apiGroup: rbac.authorization.k8s.io
subjects:
- kind: ServiceAccount
  name: read-only-user
  namespace: kubernetes-dashboard
```

deploy it

```
kubectl apply -f dashboard-read-only.yaml
```

print read-only token

```
kubectl get secret -n kubernetes-dashboard $(kubectl get serviceaccount read-only-user -n kubernetes-dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode
```

#### Start the dashboard

```
kubectl proxy
```

```
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
```

Copy/Paste your admin or read-only token

#### delete the dashboard

```
kubectl delete -f dashboard-admin.yaml
kubectl delete -f dashboard-read-only.yaml
kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
```