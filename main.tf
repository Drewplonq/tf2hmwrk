
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_fam
}
resource "yandex_compute_instance" "platform" {
  name        = local.vm_web
  platform_id = var.vms_resources.web.platform_id
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vms_resources.web.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vms_resources.web.nat
  }

  metadata = var.vms_metadata

}
resource "yandex_vpc_network" "db" {
  name = var.vm_db_vpc_name
}

resource "yandex_vpc_subnet" "db" {
  name           = var.vm_db_vpc_name
  zone           = var.default_zone_2
  network_id     = yandex_vpc_network.db.id
  v4_cidr_blocks = var.default_cidr
}
data "yandex_compute_image" "ubuntu_db" {
  family = var.vm_db_fam
}
resource "yandex_compute_instance" "db" {
  name        = local.vm_db
  platform_id = var.vms_resources.db.platform_id
  zone           = var.default_zone_2
  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_db.id
    }
  }
  scheduling_policy {
    preemptible = var.vms_resources.db.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.db.id
    nat       = var.vms_resources.db.nat
  }

  metadata = var.vms_metadata
  
}  
