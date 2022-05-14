## Mini Kubernetes

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

### Installing `K3s`

### Instlaling `minikube`

### Installing `microK8s`