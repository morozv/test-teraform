terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}
provider "yandex" {
  #token     = "<OAuth>"
  #получить новый https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token
  token = "AgAAAABTRcM5AATuwXYeSEccpkXFvBBq0AhU0z8"
  #cloud_id  = "<идентификатор облака>"
  cloud_id = "b1gbe7r94e8v9f6kaooh"
  #folder_id = "<идентификатор каталога>"
  folder_id = "b1g73clmol4fsf0ru7ig"
  zone      = "ru-central1-a"
}


resource "yandex_compute_instance" "vm-0-balansir" {
#подробнее о создании ВМ тут:
#https://cloud.yandex.ru/docs/compute/operations/vm-create/create-linux-vm
  name        = "vm0balansir"
  #platform_id = "standard-v2"

  resources {
    #cores  = <количество ядер vCPU>
    cores = 2
    #memory = <объем RAM в ГБ>
    memory = 2
  }
  
  # тут про публичные оброзы
  # https://cloud.yandex.ru/docs/compute/operations/images-with-pre-installed-software/get-list
  # тут про установку CLI 
  # https://cloud.yandex.ru/docs/cli/quickstart
  # (Интерфейс командной строки Yandex.Cloud (CLI) — скачиваемое программное обеспечение 
  # для управления вашими облачными ресурсами через командную строку)
  # $ curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
  # не забудьперезапустить консоль
  # поиск по публичным образам от яндекс
  # yc compute image list --folder-id standard-images | grep centos
  boot_disk {
    initialize_params {
      #image_id = "<идентификатор образа>"
      image_id = "fd8g0dj6sus84bcku631"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    # ssh-keys = "<имя пользователя>:<содержимое SSH-ключа>"
    ssh-keys = "user:${file("key1.pub")}"
    # скрип установки софта и т.д.
    user-data = file("skript.sh")
    }
  
}

resource "yandex_compute_instance" "vm-1-web0" {
#подробнее о создании ВМ тут:
#https://cloud.yandex.ru/docs/compute/operations/vm-create/create-linux-vm
  name        = "vm1web0"
  #platform_id = "standard-v2"

  resources {
    #cores  = <количество ядер vCPU>
    cores = 2
    #memory = <объем RAM в ГБ>
    memory = 2
  }
  
  # тут про публичные оброзы
  # https://cloud.yandex.ru/docs/compute/operations/images-with-pre-installed-software/get-list
  # тут про установку CLI 
  # https://cloud.yandex.ru/docs/cli/quickstart
  # (Интерфейс командной строки Yandex.Cloud (CLI) — скачиваемое программное обеспечение 
  # для управления вашими облачными ресурсами через командную строку)
  # $ curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
  # не забудьперезапустить консоль
  # поиск по публичным образам от яндекс
  # yc compute image list --folder-id standard-images | grep centos
  boot_disk {
    initialize_params {
      #image_id = "<идентификатор образа>"
      image_id = "fd8g0dj6sus84bcku631"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    # ssh-keys = "<имя пользователя>:<содержимое SSH-ключа>"
    ssh-keys = "user:${file("key1.pub")}"
    # скрип установки софта и т.д.
    user-data = file("skript.sh")
    }
}

resource "yandex_compute_instance" "vm-2-web1" {
#подробнее о создании ВМ тут:
#https://cloud.yandex.ru/docs/compute/operations/vm-create/create-linux-vm
  name        = "vm2web1"
  #platform_id = "standard-v2"

  resources {
    #cores  = <количество ядер vCPU>
    cores = 2
    #memory = <объем RAM в ГБ>
    memory = 2
  }
  
  # тут про публичные оброзы
  # https://cloud.yandex.ru/docs/compute/operations/images-with-pre-installed-software/get-list
  # тут про установку CLI 
  # https://cloud.yandex.ru/docs/cli/quickstart
  # (Интерфейс командной строки Yandex.Cloud (CLI) — скачиваемое программное обеспечение 
  # для управления вашими облачными ресурсами через командную строку)
  # $ curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
  # не забудьперезапустить консоль
  # поиск по публичным образам от яндекс
  # yc compute image list --folder-id standard-images | grep centos
  boot_disk {
    initialize_params {
      #image_id = "<идентификатор образа>"
      image_id = "fd8g0dj6sus84bcku631"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    # ssh-keys = "<имя пользователя>:<содержимое SSH-ключа>"
    ssh-keys = "user:${file("key1.pub")}"
    # скрип установки софта и т.д.
    user-data = file("skript.sh")
    }
}


#создание приватной сети
resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

#Создание подсети
resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

# вывод ip адресов
output "internal_ip_address_vm_0_balansir" {
  value = yandex_compute_instance.vm-0-balansir.network_interface.0.ip_address
}
output "internal_ip_address_vm_1_web0" {
  value = yandex_compute_instance.vm-1-web0.network_interface.0.ip_address
}
output "internal_ip_address_vm_2_web1" {
  value = yandex_compute_instance.vm-2-web1.network_interface.0.ip_address
}
output "external_ip_address_vm_0_balansir" {
  value = yandex_compute_instance.vm-0-balansir.network_interface.0.nat_ip_address
}
output "external_ip_address_vm_1_web0" {
  value = yandex_compute_instance.vm-1-web0.network_interface.0.nat_ip_address
}
output "external_ip_address_vm_2_web1" {
  value = yandex_compute_instance.vm-2-web1.network_interface.0.nat_ip_address
}