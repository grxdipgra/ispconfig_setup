#---------------------------------------------------------------------
# Funcion: InstallBasics
#    Instala los paquetes básicos
#---------------------------------------------------------------------
InstallBasics() {
  echo -n "Actualizando el sistema... "
  apt-get -qq update > /dev/null 2>&1
  apt-get -qqy upgrade > /dev/null 2>&1
  echo -e "[${green}HECHO${NC}]\n"

  echo "Instalando paquetes básicos... "
  apt-get -y install ssh openssh-server vim-nox ntp ntpdate debconf-utils binutils sudo git lsb-release > /dev/null 2>&1
  service apparmor stop 
  update-rc.d -f apparmor remove 
  apt-get -y remove apparmor apparmor-utils

  echo "dash dash/sh boolean false" | debconf-set-selections
  dpkg-reconfigure -f noninteractive dash > /dev/null 2>&1
  echo -n "Reconfigurando dash... "
  echo -e "[${green}HECHO${NC}]\n"
}
