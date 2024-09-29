
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
  name        = var.vm_web_name
  platform_id = var.vm_web_platform[0]
  resources {
    cores         = var.vm_web_platform[1]
    memory        = var.vm_web_platform[2]
    core_fraction = var.vm_web_platform[3]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_platform[4]
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_platform[5]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}
resource "yandex_vpc_network" "db" {
  name = var.vpc_name_db
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
  name        = var.vm_db_name
  platform_id = var.vm_db_platform[0]
  zone           = var.default_zone_2
  resources {
    cores         = var.vm_db_platform[1]
    memory        = var.vm_db_platform[2]
    core_fraction = var.vm_db_platform[3]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_db.id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_platform[4]
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.db.id
    nat       = var.vm_db_platform[5]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
}  