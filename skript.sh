#!/bin/bash
sed -i 's/PasswordAuthentication*/PasswordAuthentication no/g' /etc/ssh/sshd_config
sed -i 's/PubkeyAuthentication*/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/RSAAuthentication*/RSAAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/AuthorizedKeysFile*/   /g' /etc/ssh/sshd_config
echo "AuthorizedKeysFile     %h/.ssh/authorized_keys/g" >> /etc/ssh/sshd_config

#chmod -R 0700 /home/user
chmod 0600 ~/morozov/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

systemctl restart sshd


#dnf check-update -y
#dnf update -y
#dnf clean all -y
#dnf install nginx -y
#systemctl start nginx
#systemctl enable nginx
#sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config
#sudo setenforce 0
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

