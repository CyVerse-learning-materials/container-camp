### Set the floating_ip address for DNS redirections ###

# jupyterhub_floating_ip="149.165.152.223"
### Set up the Security Groups (re=used from Horizon) ###

security_groups = ["default","cacao-default","cacao-k8s"]
### Give the Deployment a Name (shorter is better) ###
instance_name = "jh-prod"
### Horizon Account User ID and ACCESS-CI Project Account ###

username = "${USER}"
project = "BIO220085"
# Horizon SSH key-pair
keypair = "${USER}-default"
### Set the Number of Instances (Master + Workers) ###
instance_count = 6
# Storage Volume Size in GiB 
jh_storage_size=1000
# Storage Volume directory path
jh_storage_mount_dir="/home/shared"
# OS type
image_name = "Featured-Ubuntu22"
# Worker VM Flavor
flavor = "m3.medium"
# Master VM Flavor (m3.medium or larger is recommended)
flavor_master = "m3.medium"
### Run JupyterHub on Master Node ###

do_jh_singleuser_exclude_master="true"

# Jetstream2 Region
region = "IU"
# VM image (root disk) sizes
root_storage_size = 100
root_storage_type = "volume"

# Enable GPUs (true/false) - use "true" with "g3" flavors
do_enable_gpu=false
### Zero 2 JupyterHub with K3s Rancher Configuration ###
jupyterhub_deploy_strategy="z2jh_k3s"
### Ansible-based Setup for JupyterHub ###

do_ansible_execution=true
### CPU usage per user utilization 10000m = 100% of 1 core ###

jh_resources_request_cpu="3000m"

### Memory RAM per-user requirement in Gigibytes ###

jh_resources_request_memory="10Gi"
    
### Set Power Status ###
power_state = "active"
# power_state = "shelved_offloaded"
### Pre-Cache images? ###
do_jh_precache_images=false
user_data = ""
### JupyterHub Configurations ###
# set the type of authentication, comment out Dummy or OAuth
# OAuth-type (GitHub Authentication)
# jupyterhub_oauth2_clientid="02b0a98c5d1547101514"
# jupyterhub_oauth2_secret="ac658055d848e787c31803afd973a05fbdb98f64"

# Dummy-type Authentication
jupyterhub_authentication="dummy"
# set the dummy username password
jupyterhub_dummy_password="password"
# Specify the JupyterHub admins
jupyterhub_admins="${USER}"

# add JupyterHub student account usernames 
jupyterhub_allowed_users="${USER}, student1, student2, student3, student4"
### Select a JupyterHub-ready image ###

#jupyterhub_singleuser_image="harbor.cyverse.org/vice/jupyter/pytorch"
jupyterhub_singleuser_image="jupyter/datascience-notebook"
jupyterhub_singleuser_image_tag="latest"