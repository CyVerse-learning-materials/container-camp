variable "vm_number" {
  # specify the number of VMs you want to launch
  default = "1"
}

variable "public_key" {
  # replace this with the name of the public ssh key you uploaded to Jetstream 2
  # https://docs.jetstream-cloud.org/ui/cli/managing-ssh-keys/
  default = "[REPLACE-your-ssh-key-here]>"
}

variable "image_id" {
  # replace with the OS image id of the ubuntu iso you want to use
  # https://js2.jetstream-cloud.org/project/images select the 
  default = "[REPLACE-WITH-VALID-ID]">
}

variable "network_id" {
  # replace this with the id of the public interface on JS2 in Project / Network / Networks / public 
  # https://js2.jetstream-cloud.org/project/networks/ 
  default = "[REPLACE-WITH-VALID-PUBLIC-ID]"
}