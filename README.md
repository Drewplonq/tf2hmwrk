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

## main.tf: 
```
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

}
```
## varibables.tf:
```
variable "vm_web_fam" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "yandex_compute_image"
}

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "yandex_compute_instance"
}

variable "vm_web_platform" {
  type        = tuple([ string, number, number, number, bool, bool ])
  default     = ["standard-v1", 2, 1, 20, true, true]
  description = "yandex_compute_instance"
}
```


![image](https://github.com/user-attachments/assets/db718a24-2336-4b1e-8906-96ee12265efe)



### Задание 3

https://github.com/Drewplonq/tf2hmwrk/blob/main/main.tf](https://github.com/Drewplonq/tf2hmwrk/blob/main/main.tf)](https://github.com/Drewplonq/tf2hmwrk/blob/main/main.tf)


https://github.com/Drewplonq/tf2hmwrk/blob/main/vms_platform.tf

![image](https://github.com/user-attachments/assets/7749dc76-0a86-4cd6-803c-52f4a3353185)
