variable "vm_number" {
  # creates a single VM
  # replace with a larger number to launch more than one VM
  default = "1"
}

variable "public_key" {
  # replace this with the name of the public ssh key you uploaded to Jetstream 2
  # https://docs.jetstream-cloud.org/ui/cli/managing-ssh-keys/
  default = "tswetnam-terraform-key"
}

variable "image_name" {
  # replace this with the image name of the ubuntu iso you want to use
  # https://js2.jetstream-cloud.org/project/images 
  default = "Featured-Ubuntu20"
}

variable "network_name" {
  # replace this with the id of the public interface on JS2 in Project / Network / Networks / public
  # https://js2.jetstream-cloud.org/project/networks/ 
  default = "auto_allocated_network"
}