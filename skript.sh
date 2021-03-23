#!/bin/bash
dnf check-update -y
dnf update -y
dnf clean all -y
dnf install nginx -y
systemctl start nginx
systemctl enable nginx
#firewall-cmd -–add-service=ssh
#firewall-cmd -–add-service=ssh --permanent
#systemctl restart sshd
#Далее добавим 80 порт Nginx и 443 порт в исключение фаерволла CentOS8 и перезапустим службу firewalld.
#firewall-cmd --permanent --add-port=80/tcp
#firewall-cmd --permanent --add-port=443/tcp
#firewall-cmd --reload
#Установка PHP-FPM
#sudo dnf install php-fpm -y
#systemctl start php-fpm
#systemctl enable php-fpm

