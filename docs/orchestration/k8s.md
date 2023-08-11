# Lesson 1: Introduction to Kubernetes

!!! info "Learning Objectives"
    * Understand what Kubernetes is and its role in managing containerized applications
    * Recognize the importance and benefits of using Kubernetes in cloud computing
    * Identify reasons why you may need to use Kubernetes for your own research or projects
    * Learn about the existence of Kubernetes clusters and how to leverage them using `kubectl`

[:material-kubernetes: Kubernetes](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/){target=_blank}, or `K8s` for short, is an open-source system designed to automate the deployment, scaling, and management of containerized applications. 

K8s is the most prevalent platform for managing containerized applications at scale in the realm of cloud computing. If you're considering incorporating containers into your research or project portfolio, it's highly likely you'll interact with a K8s Cluster.

??? Info "What is container orchestration?"

    [Container orchestration](https://www.redhat.com/en/topics/containers/what-is-container-orchestration) is the process of automating the deployment, scaling, management, and coordination of containerized applications. In the context of Kubernetes, container orchestration involves managing the lifecycle of containers within a cluster. This includes tasks such as deploying containers, ensuring high availability, distributing network traffic, scaling applications up or down based on demand, and handling updates seamlessly.

In this introductory lesson, we'll focus on how to leverage *existing* Kubernetes Clusters using `kubectl`.

??? Question ":material-scale-balance: Why would you want to build your own K8s Cluster? "

    You're here to learn about containerized applications and container orchestration. We aim to familiarize you with these technologies and help you understand their place in the roadmap of Cloud Native Computing. However, it's crucial to note,

    :warning: __Designing, deploying, and maintaining your own K8s cluster can be a complex and challenging task__ :warning:
    
    - This is partly because there are numerous existing platforms out there, such as managed K8s services. Additionally, managing K8s requires a dedicated DevOps or software engineering team to ensure your platform operates smoothly.

    Still interested in building your own cluster? Here are some reasons why you might need to use K8s for your research or project:

    (1) Your applications consist of multiple services. The K8s API automates the tasks of managing numerous containers and allocating resources. 

    (2) Your work scales dynamically - if your computing needs fluctuate based on workloads, K8s can be useful. Using containers to scale your applications is more efficient than manually launching VMs.

    (3) You have too many containers to manage - K8s excels at its primary function: managing and maintaining containers. 

    (4) Your domain is transitioning to the cloud. If your field is moving towards being cloud-native, it's crucial to develop workflows in anticipation of this shift.

    (5) Consistency is key. K8s' declarative state provides a clear description of how everything is managed.

!!! Info "Kubernetes Terminology"

    **Kubernetes Cluster**: A collection of nodes that run containerized applications. This is the primary unit of organization in Kubernetes.

    **kubectl**: The command-line interface used for interacting with Kubernetes clusters. It enables users to manage various aspects of the cluster.

    **Pod**: The smallest deployable unit in Kubernetes, which can consist of one or more containers that communicate with each other. Pods are run on nodes.

    **Node**: Typically a virtual machine (VM) that runs Kubernetes components, including the kubelet, kube-proxy, and container runtime.

    **Kubelet**: The agent that runs on each node, responsible for managing the pods on its respective VM.

    **Kube-proxy**: A network proxy that runs on each node, used by a Service to handle network communication.

    **Container runtime**: The software that runs containers within pods. Examples include `Docker`, `containerd` (native to Kubernetes), and `CRI-O`.

    **Service**: Assigns a network address to an application, including a persistent IP address and a DNS entry within the cluster. A Service also manages load balancing across pods and can dynamically add or remove them.

    **ReplicaSet**: Allows for the creation of multiple pods simultaneously, ensuring that a specified number of identical pods are running at any given time.

    **Deployment**: Provides declarative updates for Pods and ReplicaSets, allowing for rolling updates and rollbacks.

    **Control Plane**: A node that manages worker nodes. It consists of the API server, cluster store, controller manager, and scheduler.

    **Namespace**: A way to divide cluster resources between multiple users.

    **Ingress**: An API object that manages external access to the services in a cluster, typically HTTP.

    **Persistent Volume (PV)**: A piece of storage in the cluster that has been provisioned by an administrator.

    **Persistent Volume Claim (PVC)**: A request for storage by a user.

    **ConfigMap**: An API object used to store non-confidential data in key-value pairs.

    **Secret**: An API object used to store sensitive data, like passwords and keys.
    

!!! Question "So, what does a K8s Cluster look like?"
    
    In short, this:
    
    [![k8s cluster](https://d33wubrfki0l68.cloudfront.net/2475489eaf20163ec0f54ddc1d92aa8d4c87c96b/e7c81/images/docs/components-of-kubernetes.svg)](https://kubernetes.io/docs/concepts/overview/components/)

    The image above is taken from the official [K8s documentation](https://kubernetes.io/docs/concepts/overview/components/) and depics the relation between each component.

    A K8s cluster comprises of multiple elemets essentially groupable in 2 subsets:
    
    - The **Control Pane** components:
        - **api** (K8s API): the front end of the control pane, it exposes the Kubernentes API. Command line tool: [`kube-apiserver`](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/).
        - **etcd**: a store used for backing cluster data (e.g., cluster cofiguration, state information). Controlled by the [`kube-apiserver`](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/) tool.
        - **sched** (Scheduler): the component that watches for newly created Pods with no assigned node. Once a new Pod is detected, a node is assigned. Controlled by [`kube-scheduler`](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-scheduler/).
        - **c-m** (Controller Manager): controls the [controllers](https://kubernetes.io/docs/concepts/architecture/controller/) processes. Accessible through [`kube-controller-manager`](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-controller-manager/)
        - **c-c-m** (Cloud Controller Manager): lets you to link your cluster to your provider's API, allowing you to choose what components interact with the external platform and which components interact with the internal cluster. Read more on the cloud controller manager [here](https://kubernetes.io/docs/concepts/architecture/cloud-controller/).
    - The **Node** components:
        - **kubelet**: An agent that runs on each node in the cluster. It makes sure that containers are running in a Pod. [`kubelet`](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/)
        - **k-proxy** (kube-proxy): maintains network rules on nodes. These network rules allow network communication to your Pods from network sessions inside or outside of your cluster. [`kube-proxy`](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/)

!!! Question "We keep talking about Pods and Nodes, *what are Pods and Nodes?*"
    
    https://kubernetes.io/docs/concepts/workloads/pods/

    [![pods](https://d33wubrfki0l68.cloudfront.net/fe03f68d8ede9815184852ca2a4fd30325e5d15a/98064/docs/tutorials/kubernetes-basics/public/images/module_03_pods.svg)](https://kubernetes.io/docs/tutorials/kubernetes-basics/explore/explore-intro/)

    [![nodes](https://d33wubrfki0l68.cloudfront.net/5cb72d407cbe2755e581b6de757e0d81760d5b86/a9df9/docs/tutorials/kubernetes-basics/public/images/module_03_nodes.svg)](https://kubernetes.io/docs/tutorials/kubernetes-basics/explore/explore-intro/)



## K8s CLI `kubectl`

The Kubernetes API uses a command-line tool called `kubectl`.

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
    
    ```{yaml}
    apiVersion: v1
    clusters:
    - cluster:
        certificate-authority-data: DATA+OMITTED
        server: https://127.0.0.1:6443
      name: k3s-tutorial
    contexts:
    - context:
        cluster: k3s-tutorial
        namespace: cc2023
        user: participant-name
      name: k3s-tutorial
    current-context: k3s-tutorial
    kind: Config
    preferences: {}
    users:
    - name: participant
      user:
        client-certificate-data: REDACTED
        client-key-data: REDACTED
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