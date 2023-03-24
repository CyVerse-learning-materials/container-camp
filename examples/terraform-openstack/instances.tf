################
# Instance OS
################

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