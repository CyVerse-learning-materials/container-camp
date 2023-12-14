# Lesson 1: Introduction to Kubernetes

!!! info "Learning Objectives"
    * Understand what Kubernetes is and its role in managing containerized applications
    * Recognize the importance and benefits of using Kubernetes in cloud computing
    * Identify reasons why you may need to use Kubernetes for your own research or projects
    * Learn about the existence of Kubernetes clusters and how to leverage them using `kubectl`

[:material-kubernetes: Kubernetes](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/){target=_blank}, or `K8s` for short, is an open-source system designed to automate the deployment, scaling, and management of containerized applications. 

K8s is the most prevalent platform for managing containerized applications at scale in the realm of cloud computing. If you're considering incorporating containers into your research or project portfolio, it's highly likely you have already interacted with or will interact with a K8s cluster in the future.

In this introductory lesson, we'll focus on how to leverage *existing* Kubernetes Clusters using `kubectl`.

??? question ":simple-kubernetes: K8s vs :simple-k3s: K3s"

    We are going to be using a platform developed by a project named [:simple-rancher: Rancher](https://www.rancher.com/){target=_blank}, called [:simple-k3s: K3s](https://k3s.io/){target=_blank}.

    K3s is a lightweight certified Kubernetes distribution designed for edge and production workloads.  

    K3s uses the same `kubectl` and `helm` commands as full K8s. 

    We prefer K3s to K8s for our virtual machines and for workshops for the same reason you might prefer to use [Alpine Linux](https://www.alpinelinux.org/){target=_blank} to [Ubuntu Linux](https://ubuntu.com/){target=_blank} in a simple container deployment.

??? Question "What is container orchestration?"

    [Container orchestration](https://www.redhat.com/en/topics/containers/what-is-container-orchestration) is the process of automating the deployment, scaling, management, and coordination of containerized applications. In the context of Kubernetes, container orchestration involves managing the lifecycle of containers within a cluster. This includes tasks such as deploying containers, ensuring high availability, distributing network traffic, scaling applications up or down based on demand, and handling updates seamlessly.

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
    
    - The **Control Plane** components:
        - **api** (K8s API): the front end of the control plane, it exposes the Kubernentes API. Command line tool: [`kube-apiserver`](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/).
        - **etcd**: a store used for backing cluster data (e.g., cluster cofiguration, state information). Controlled by the [`kube-apiserver`](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/) tool.
        - **sched** (Scheduler): the component that watches for newly created Pods with no assigned node. Once a new Pod is detected, a node is assigned. Controlled by [`kube-scheduler`](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-scheduler/).
        - **c-m** (Controller Manager): controls the [controllers](https://kubernetes.io/docs/concepts/architecture/controller/) processes. Accessible through [`kube-controller-manager`](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-controller-manager/)
        - **c-c-m** (Cloud Controller Manager): lets you to link your cluster to your provider's API, allowing you to choose what components interact with the external platform and which components interact with the internal cluster. Read more on the cloud controller manager [here](https://kubernetes.io/docs/concepts/architecture/cloud-controller/).
    - The **Node** components:
        - **kubelet**: An agent that runs on each node in the cluster. It makes sure that containers are running in a Pod. [`kubelet`](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/)
        - **k-proxy** (kube-proxy): maintains network rules on nodes. These network rules allow network communication to your Pods from network sessions inside or outside of your cluster. [`kube-proxy`](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/)

!!! Question "We keep talking about Pods and Nodes, *what are Pods and Nodes?*"
    
    [**Pods**](https://kubernetes.io/docs/concepts/workloads/pods/)

    [![pods](https://d33wubrfki0l68.cloudfront.net/fe03f68d8ede9815184852ca2a4fd30325e5d15a/98064/docs/tutorials/kubernetes-basics/public/images/module_03_pods.svg)](https://kubernetes.io/docs/tutorials/kubernetes-basics/explore/explore-intro/)

    A Pod is the smallest deployable unit in Kubernetes. It represents a single instance of a running process in a cluster and encapsulates one or more closely related containers. Containers within the same Pod share the same network namespace, IP address, and storage volumes, making them suitable for co-located and tightly coupled applications.

    In the image above, we see 4 different Pods, each having at least one containerized app. Notice how each Pod has its own IP address, and apps within the same Pods share volumes for storage and IP address.

    [**Nodes**](https://kubernetes.io/docs/concepts/architecture/nodes/)

    [![nodes](https://d33wubrfki0l68.cloudfront.net/5cb72d407cbe2755e581b6de757e0d81760d5b86/a9df9/docs/tutorials/kubernetes-basics/public/images/module_03_nodes.svg)](https://kubernetes.io/docs/tutorials/kubernetes-basics/explore/explore-intro/)

    A Node is a physical or virtual machine that runs containers. Nodes are the worker machines in a Kubernetes cluster where Pods are scheduled and executed. Nodes collectively form the computational resources of the cluster, where containers are scheduled and executed. The interaction between Pods and Nodes forms the core of how Kubernetes manages and distributes workloads within a cluster.

    In the image, the Node contains different Pods. Notice [`kubelet`](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/) and Docker: 
    
    - [`kubelet`](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/)  is a component that runs on each Node in a Kubernetes cluster and manages its life cycle, ensuring that the Node is healthy.
    - Docker provides the runtime environment for containers, whilst K8s manages the orchestration.


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

#### `config` 

To connect to a running K8s cluster, you need to create a `config` (.yaml) and place it in the `~/.kube/` folder.

In our demo [K3s](https://k3s.io/){target=_blank} cluster, the `config` file is maintained in the `/etc/rancher/k3s/k3s.yaml`. You can copy the file to  `~/.kube/config` or create a symlink. 

??? info " example `config` file"

    Example of the `~/.kube/config` file which is used for K3s
    
    ```{yaml}
    apiVersion: v1
    clusters:
    - cluster:
        certificate-authority-data: <REDACTED>
        server: https://127.0.0.1:6443
      name: default
    contexts:
    - context:
        cluster: default
        user: default
      name: default
    current-context: default
    kind: Config
    preferences: {}
    users:
    - name: default
      user:
        client-certificate-data: <REDACTED>
        client-key-data: <REDACTED>
    ```

1. Copy the `~/.kube/config` file from your cluster or use our example here over to your localhost or VM and put it into a temporary directory.

2. Make a second copy and put it into your own `~/.kube/config` folder

By default, the `config` file is in the `~/.kube/` directory, but it can be put anywhere or given any name, use the `--kubeconfig` flag to tell `kubectl` where to get the config:

```
kubectl --kubeconfig /custom/path/kube.config get pods
```

#### Setting up the `namespace`

`kubectl` needs to know the `namespace` of the cluster `config` you're working with. 

In this first example today, we're going to be working locally on a K3s with a new `namespace` for each of the students (so we can differentiate whose pods are whose)

To set the context and namespace of the cluster:

```
kubectl config set-context student##-cc23 --namespace=student##-cloudcamp23
```

where ## is your assigned student ID. If you're doing this lesson on your own time, you can choose your own unique context and namespace.

Once the `config` namespace is set, you should be ready to launch "pods" i.e. containers on the cluster

### :material-kubernetes: pods

Each pod is managed using its own `.yaml` file. This way K8s / K3s can declaratively set the resources, container, networking, volumes, and permissions for each running pod.

Create a new directory called `examples` on the JS2 workshop instance you have connected to.

Create a new file called `alpine.yaml` 

```
apiVersion: v1
kind: Pod
metadata:
  name: alpine-<change-this-to-your-username>
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
kubectl create -f alpine.yaml
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
kubectl exec -it alpine-<yourusername> -- /bin/sh
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

First, we can create a `deployment.yaml`

```{yaml}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: alpine-instructor-deployment
spec:
  replicas: 3 # Number of Pod replicas
  selector:
    matchLabels:
      app: alpine-instructor
  template:
    metadata:
      labels:
        app: alpine-instructor
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

This `deplyoment.yaml` will create three replicas of the given Pod, each with the specified `alpine`` image, resource limits, and command. You can adjust the number of replicas or other parameters as needed for your workshop demonstration.

To create the deployment using the provided YAML file, you can save the file to your local system (e.g., deployment.yaml) and then run the following kubectl command:

```
kubectl apply -f deployment.yaml
```

??? question "Why bother with Deployments?"

    **High Availability**: By running three replicas of the Pod, the application becomes more resilient to failures. If one Pod fails, the other two can continue to handle requests, ensuring that the application remains available.

    **Load Balancing**: Kubernetes automatically distributes incoming traffic across the replicas. This helps in evenly spreading the load, leading to better utilization of resources and potentially improved response times.

    **Fault Tolerance**: If a node in the cluster fails, the Pods running on that node will be lost. Having multiple replicas ensures that the application continues to run on the remaining nodes. Kubernetes will also work to reschedule the lost Pods on other available nodes.

    **Scalability**: Having multiple replicas allows the application to handle more simultaneous requests. If the load increases further, the number of replicas can be easily adjusted, either manually or through autoscaling.

    **Rolling Updates and Rollbacks**: Deployments in Kubernetes facilitate rolling updates, allowing you to update the application with zero downtime. If something goes wrong, you can also easily roll back to a previous version. The multiple replicas ensure that some instances of the application are always available during this process.

    **Observability and Monitoring**: With multiple replicas, you can monitor the behavior of the application across different instances and nodes, providing insights into the system's performance and potential issues.

    **Consistent Environment**: Each replica runs in an identical environment, ensuring consistency in the application's behavior and facilitating testing and debugging.

    In summary, a deployment with three replicas enhances the availability, reliability, scalability, and manageability of the application within a Kubernetes cluster. It aligns well with best practices for running production-grade, distributed systems.

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

```
kubectl -n kubernetes-dashboard create token admin-user
```

#### delete the dashboard

```
kubectl delete -f dashboard-admin.yaml
kubectl delete -f dashboard-read-only.yaml
kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
```
