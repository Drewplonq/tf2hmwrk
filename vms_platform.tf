###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_zone_2" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}
variable "vpc_name_db" {
  type        = string
  default     = "db"
  description = "VPC network & subnet name"
}

variable "vm_db_vpc_name" {
  type        = string
  default     = "db"
  description = "VPC network & subnet name"
}
###ssh vars

/* variable "vms_ssh_root_key" {
  type        = string
  default     = "<your_ssh_ed25519_key>"
  description = "ssh-keygen -t ed25519"
}
*/
variable "vm_web_fam" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "yandex_compute_image"
}
variable "vm_db_fam" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "yandex_compute_image"
}
 variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "yandex_compute_instance"
}
variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "yandex_compute_instance"
}
/* variable "vm_web_platform" {
  type        = tuple([ string, number, number, number, bool, bool ])
  default     = ["standard-v1", 2, 1, 5, true, true]
  description = "yandex_compute_image"
}
variable "vm_db_platform" {
  type        = tuple([ string, number, number, number, bool, bool ])
  default     = ["standard-v3", 2, 2, 20, true, true]
  description = "yandex_compute_image"
}
*/
variable "vms_resources" {
    type    = map(object({
        platform_id = string
        cores   =   number
        memory  =   number
        core_fraction   =   number
        preemptible = bool
        nat = bool
    }))
    default = {
      "web" = {
        platform_id = "standard-v1"
        cores   =  2
        memory  =  1
        core_fraction   =   5
        preemptible = true
        nat = true
      }
      "db" = {
        platform_id = "standard-v3"
        cores   =  2
        memory  =  2
        core_fraction   =   20
        preemptible = true
        nat = true
      }
    }
    description = "vms resources"
}

variable "vms_metadata" {
  type = map(string)
    description = "Metadata of Vm's"
}
