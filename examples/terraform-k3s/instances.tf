################
# K3s Cluster VMs
################


# Define the main resource
resource "openstack_compute_instance_v2" "master" {
  name        = "k3s-master"
  image_name  = var.image_name
  flavor_name = var.master_flavor
  # flavor_name is the size of the VM 
  # https://docs.jetstream-cloud.org/general/vmsizes/ 
  # this public key is set above in security section
  key_pair  = var.public_key
  security_groups   = ["k3s_ssh_ping", "default"]
  metadata = {
    terraform_controlled = "yes"
  }

  network {
    name = var.network_name
  }

  security_groups = [
    var.security_group_name
  ]

  # Install K3s Rancher and JupyterHub on the master node
  provisioner "remote-exec" {
    inline = [
      "curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC='--no-deploy traefik --no-deploy servicelb --no-deploy local-storage' sh -",
      "sudo useradd -m -s /bin/bash jupyter",
      "echo 'jupyter:jupyter' | sudo chpasswd",
      "sudo su - jupyter -c 'curl https://raw.githubusercontent.com/jupyterhub/the-littlest-jupyterhub/master/bootstrap/bootstrap.py | python3 - --admin jupyter --password jupyter'"
    ]
  }
}

resource "openstack_compute_instance_v2" "worker" {
  count       = var.worker_count
  name_prefix = "k3s-worker"
  image_name  = var.image_name
  flavor_name = var.worker_flavor

  network {
    name = var.network_name
  }

  security_groups = [
    var.security_group_name
  ]

  # Join the worker nodes to the K3s Rancher cluster
  provisioner "remote-exec" {
    inline = [
      "curl -sfL https://get.k3s.io | K3S_URL=https://${openstack_compute_instance_v2.master.access_ip_v4}:6443 K3S_TOKEN=${openstack_compute_instance_v2.master.null_resource.server_token} sh -"
    ]
  }
}


# create each Ubuntu20 instance
resource "openstack_compute_instance_v2" "Ubuntu20" {
  name = "container_camp_Ubuntu20_${count.index}"
  # ID of Featured-Ubuntu20
  image_name  = var.image_name
  # flavor_id is the size of the VM 
  # https://docs.jetstream-cloud.org/general/vmsizes/ 
  flavor_name  = "m3.tiny"
  # this public key is set above in security section
  key_pair  = var.public_key
  security_groups   = ["terraform_ssh_ping", "default"]
  count     = var.vm_number
  metadata = {
    terraform_controlled = "yes"
  }
  network {
    name = var.network_name
  }
  #depends_on = [openstack_networking_network_v2.terraform_network]

}
# creating floating ips from the public ip pool
resource "openstack_networking_floatingip_v2" "terraform_floatip_ubuntu20" {
  pool = "public"
    count     = var.vm_number
}

# assign floating ip to each Ubuntu20 VM
resource "openstack_compute_floatingip_associate_v2" "terraform_floatip_ubuntu20" {
  floating_ip = "${openstack_networking_floatingip_v2.terraform_floatip_ubuntu20[count.index].address}"
  instance_id = "${openstack_compute_instance_v2.Ubuntu20[count.index].id}"
    count     = var.vm_number
}