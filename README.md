# README #

Este trabajo es una adaptación para la Diputacion de Granada de ispconfig_setup 3.1 de Temporini Matteo.
Se ha añadido soporte para ubuntu 18.04 y se ha añadido un cms para los portales de los dominios.
# Version #
v.3.1

Este script hace una instalación casi desatendida de ispconfig 3 en un servidor ubuntu 18.04.
No se han borrado las instalaciones para versiones anteriores a ubuntu 18.04, pero sólo en la versión de ubuntu 18.04 se ha ara añadido CMS para los portales.
Según la rama original, se han probado las siguientes instalaciones

- Debian 9 Stretch ([Servisys VPS](https://www.servisys.it/), VmWare Esxi, Amazon AWS, Virtualbox, OVH VPS, Hetzner, Digital Ocean)
- Debian 8 Jessie ([Servisys VPS](https://www.servisys.it/), VmWare Esxi, Amazon AWS, Virtualbox, OVH VPS, Hetzner, Digital Ocean)
- Debian 7 Wheezy ([Servisys VPS](https://www.servisys.it/), VmWare Esxi, Amazon AWS, Virtualbox, OVH VPS, Hetzner, Digital Ocean)
- Ubuntu 14.04 Trusty ([Servisys VPS](https://www.servisys.it/), VmWare Esxi, Amazon AWS, Virtualbox, OVH VPS, Hetzner, Digital Ocean)
- Ubuntu 15.10 Willy ([Servisys VPS](https://www.servisys.it/), VmWare Esxi, Amazon AWS, Virtualbox, OVH VPS, Hetzner, Digital Ocean)
- Ubuntu 16.04 Xenial Xerus ( [Servisys VPS](https://www.servisys.it/), VmWare Esxi, Amazon AWS, Virtualbox, OVH VPS, Hetzner, Digital Ocean)
- Centos 7 ([Servisys VPS](https://www.servisys.it/), Vitualbox)
- ISPConfig 3.*

Se requiere una instalación de linux e internet para que funcione el script, aunque se recomienda ubuntu 18.04 server.
https://www.ubuntu.com/download/server/thank-you?country=ES&version=18.04.1&architecture=amd64

You can Choose during install:
- Apache / Nginx
- Dovecot or Courier
- Quota On/Off
- Jailkit On/Off
- Roundcube
- ISPConfig 3 Standard / Expert mode
- ISPConfig 3 Multiserver Setup (* Debian 8 only for now)


https://www.howtoforge.com/perfect-server-debian-wheezy-apache2-bind-dovecot-ispconfig-3

to install debian as required for ISPConfig

* Configuration for Debian 7 / 8 / 9 - Ubuntu 14.04 / 15.10 / 16.04

After you got a fresh and perfect Debian installation you had to

```shell
cd /tmp; wget --no-check-certificate -O installer.tgz "https://github.com/servisys/ispconfig_setup/tarball/master"; tar zxvf installer.tgz; cd *ispconfig*; bash install.sh
```
* Centos 7

```shell
cd /tmp; yum install wget unzip net-tools; wget --no-check-certificate -O installer.tgz "https://github.com/servisys/ispconfig_setup/tarball/master"; tar zxvf installer.tgz; cd *ispconfig*; bash install.sh
```

Centos 7 is in a very early stage, we got to test a bit, any help will be appreciated. 
Some feature are missing for now, only implemented Apache and Dovecot, no webmail.

Follow the instruction on the screen

### Who had contributed to this work? ###

* The scripts and instructions have been produced by Matteo Temporini ( <temporini.matteo@gmail.com> )
* Special thanks to Torsten Widmann for contribution to the code
* Special thanks to Michiel Kamphuis ( http://www.ensync.it/ ) for contribution to Multiserver Setup integration
* Special thanks to Bartłomiej Gajda ( http://webard.me/ ) for the bug fixes to multiserver setup and beta installation
* The code is based on the "Automatic Debian System Installation for ISPConfig 3" of Author: Mark Stunnenberg <mark@e-rave.nl>
* Howtoforge community https://www.howtoforge.com/community/
