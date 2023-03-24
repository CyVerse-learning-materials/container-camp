################
#Security section
################

# Creating Compute Security group
resource "openstack_compute_secgroup_v2" "terraform_ssh_ping" {
  name = "terraform_ssh_ping"
  description = "Security group with SSH and PING open to 0.0.0.0/0"

  #ssh rule
  rule{
    ip_protocol = "tcp"
    from_port  =  "22"
    to_port    =  "22"
    cidr       = "0.0.0.0/0"
  }
  rule {
    from_port   = -1
    to_port     = -1
    ip_protocol = "icmp"
    cidr        = "0.0.0.0/0"
  }

}

# Create a Netowrking Security group
resource "openstack_networking_secgroup_v2" "terraform_tcp_1" {
  name        = "terraform_tcp_1"
  description = "Security group with TCP open to 0.0.0.0/0"
}

# Allow HTTP (port 80) traffic
resource "openstack_networking_secgroup_rule_v2" "http_rule" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.terraform_tcp_1.id}"
}

# Allow HTTPS (port 443) traffic
resource "openstack_networking_secgroup_rule_v2" "https_rule" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.terraform_tcp_1.id}"
}

# Allow Service (port 8080) traffic
resource "openstack_networking_secgroup_rule_v2" "service_rule" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8080
  port_range_max    = 8080
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.terraform_tcp_1.id}"
}
