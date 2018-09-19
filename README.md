# README #

Este trabajo es una adaptación para la Diputacion de Granada de ispconfig_setup 3.1.
Se ha añadido soporte para ubuntu 18.04 y se ha añadido un cms para los portales de los dominios.
# Version #
v.3.1

Este script hace una instalación casi desatendida de ispconfig 3 en un servidor ubuntu 18.04.
No se han borrado las instalaciones para versiones anteriores a ubuntu 18.04, pero sólo en la versión de ubuntu 18.04 se han  añadido CMS para los portales.
Según la rama original, se han probado las siguientes instalaciones

- Debian 9 Stretch ([Servisys VPS](https://www.servisys.it/), VmWare Esxi, Amazon AWS, Virtualbox, OVH VPS, Hetzner, Digital Ocean)
- Debian 8 Jessie ([Servisys VPS](https://www.servisys.it/), VmWare Esxi, Amazon AWS, Virtualbox, OVH VPS, Hetzner, Digital Ocean)
- Debian 7 Wheezy ([Servisys VPS](https://www.servisys.it/), VmWare Esxi, Amazon AWS, Virtualbox, OVH VPS, Hetzner, Digital Ocean)
- Ubuntu 14.04 Trusty ([Servisys VPS](https://www.servisys.it/), VmWare Esxi, Amazon AWS, Virtualbox, OVH VPS, Hetzner, Digital Ocean)
- Ubuntu 15.10 Willy ([Servisys VPS](https://www.servisys.it/), VmWare Esxi, Amazon AWS, Virtualbox, OVH VPS, Hetzner, Digital Ocean)
- Ubuntu 16.04 Xenial Xerus ( [Servisys VPS](https://www.servisys.it/), VmWare Esxi, Amazon AWS, Virtualbox, OVH VPS, Hetzner, Digital Ocean)
- Ubuntu 18.04 server kvm
- Centos 7 ([Servisys VPS](https://www.servisys.it/), Vitualbox)
- ISPConfig 3.*

Se requiere una instalación de linux e internet para que funcione el script, aunque se recomienda ubuntu 18.04 server.
https://www.ubuntu.com/download/server/thank-you?country=ES&version=18.04.1&architecture=amd64

Podemos elegir durante la instalacion las siguientes opciones:
- Apache / Nginx
- mysql 5.7 o mariadb
- Dovecot o Courier
- Quota On/Off
- Jailkit On/Off

Se instalará además en la version 18.04:
- roundcube
- spamassassin
- clamav
- amavis
- postgrey
- rkhunter
- bind9
- fail2band
- pureftp
- Joomla
- metronome
- postfix
- quota
- php7.2 
- webalizer
Entre otras aplicaciones.
