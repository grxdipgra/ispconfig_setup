#---------------------------------------------------------------------
# Function: InstallFTP
#    Install and configure PureFTPd
#---------------------------------------------------------------------
InstallFTP() {
  echo -n "Instalando PureFTPd... "
  echo "pure-ftpd-common pure-ftpd/virtualchroot boolean true" | debconf-set-selections
  debconf-apt-progress -- apt-get -yqq install pure-ftpd-common pure-ftpd-mysql 
  sed -i 's/VIRTUALCHROOT=false/VIRTUALCHROOT=true/' /etc/default/pure-ftpd-common
  echo 1 > /etc/pure-ftpd/conf/TLS
  mkdir -p /etc/ssl/private/
  openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem -subj "/C=$SSL_COUNTRY/ST=$SSL_STATE/L=$SSL_LOCALITY/O=$SSL_ORGANIZATION/OU=$SSL_ORGUNIT/CN=$CFG_HOSTNAME_FQDN"
  chmod 600 /etc/ssl/private/pure-ftpd.pem
  service openbsd-inetd restart > /dev/null 2>&1
  service pure-ftpd-mysql restart > /dev/null 2>&1
  echo -e "[${green}HECHO${NC}]\n"
}

