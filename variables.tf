variable "project" {
  default     = "kebernetes-258422"
}
variable "credentials_file" { 
  default     = "./.ssh/Kubernetes-9ec039840093.json"
}

variable "cluster_name" {
  default     = "jennifer"
}

variable "preemptible" {
  description = "preemptible = true for test"
  default     = "true"
}

variable "machine_type_web" {
  description = "... for web pods - Apache"
  default     = "n1-standard-1"
}
#variable "machine_type_web" {
#  description = "... for web pods - Apache"
#  default     = "g1-small"
#}

variable "machine_type_db" {
  description = "... for web pods - MySQL"
  default     = "n1-standard-1"
}

variable "cluster_user_name" {
  default     = "terra"
}
variable "cluster_user_password" {
  default     = "Vzhe viter hytaie pozzhovklu travu"
}

  