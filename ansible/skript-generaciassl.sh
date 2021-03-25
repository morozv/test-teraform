#!/bin/sh


#
# Генерирование ключей и создание SSL-сертификата
#
# Создайте каталог для хранения SSL-сертификата и перейдите в него:
mkdir -p /etc/nginx/ssl/example.com # в место example.com пишем свой адрес
cd /etc/nginx/ssl/example.com
# Создайте закрытый ключ:
openssl genrsa -des3 -out server.key 2048
# Удалите фразовый пароль:
openssl rsa -in server.key -out server.key
# Используйте этот CSR, чтобы подписать сертификат в надёжном центре сертификации, или же создайте самоподписанный сертификат при помощи команды:
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
#
# server.key – закрытый ключ
# ca-certs.pem – промежуточные сертификаты (появится только в случае подписи сертификата в ЦС).
# server.crt – SSL-сертификат для доменного имени.
# Пропустите директиву ssl_trusted_certificate, если вы используете самоподписанный сертификат.
#

# создайте самоподписанный сертификат при помощи команды:
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

cd /etc/nginx/
mkdir sites-available
cd /etc/nginx/sites-available/



service nginx reload