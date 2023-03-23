terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = ">=1.47.0"
    }
  }
}

provider "openstack" {
  auth_url = "https://js2.jetstream-cloud.org:5000/v3/"
  region = "IU"
}