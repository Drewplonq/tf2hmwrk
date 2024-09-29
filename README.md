### Задание 1.4

ошибка в блоке ресурс в платформе standarT-v4, такой у яндекса не существует,есть 1-3 самое дешевое standarD-v1, 
ядра: 1 недоступное значение, выставляем 2


![image](https://github.com/user-attachments/assets/8fc47b66-bb21-42e8-9fa0-11191e2c4b2a)

### Задание 1.6

preemptible = true указывает, что вм прерываемая, то есть выключается через 24 часа работы с сохранением данных, можно заново включить.  
core_fraction=5 указывает что вм будет выделено 5 процентов от общей мощности цпу, с увеличением до 100 при нагрузке, используется для ненагруженных систем.
также оба этих параметра влияют на ценообразование вм в облаке

![image](https://github.com/user-attachments/assets/9df669c0-f9b2-439d-a59e-a6b5d346a07c)

### Задание 2


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


  ![image](https://github.com/user-attachments/assets/3d7c9eb8-0af4-4f9f-b116-0d5c6a9c20d1)
