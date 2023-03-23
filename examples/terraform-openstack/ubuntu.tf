################
# Specify the VMs
################

# creating Ubuntu20 instance
resource "openstack_compute_instance_v2" "Ubuntu20" {
  name = "terraform_Ubuntu20_${count.index}"
  # ID of Featured-Ubuntu20
  image_id  = var.image_id
  flavor_name   = m3.quad
  # this public key is set above in security section
  key_pair  = var.public_key
  security_groups   = ["terraform_ssh_ping", "default"]
  count     = var.vm_number
  metadata = {
    terraform_controlled = "yes"
  }
  network {
    name = "auto_allocated_network"
  }
  #depends_on = [openstack_networking_network_v2.terraform_network]

}
# creating floating ip from the public ip pool
resource "openstack_networking_floatingip_v2" "terraform_floatip_ubuntu20" {
  pool = "public"
    count     = var.vm_number
}

# assigning floating ip from public pool to Ubuntu20 VM
resource "openstack_compute_floatingip_associate_v2" "terraform_floatip_ubuntu20" {
  floating_ip = "${openstack_networking_floatingip_v2.terraform_floatip_ubuntu20[count.index].address}"
  instance_id = "${openstack_compute_instance_v2.Ubuntu20[count.index].id}"
    count     = var.vm_number
}

################
#Output
################


output "floating_ip_ubuntu20" {
  value = openstack_networking_floatingip_v2.terraform_floatip_ubuntu20.*.address
  description = "Public IP for Ubuntu 20"
}