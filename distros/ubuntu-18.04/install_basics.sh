#---------------------------------------------------------------------
# Funcion: InstallBasics
#    Instala los paquetes básicos
#---------------------------------------------------------------------
InstallBasics() {
  echo -n "Actualizando el sistema... "
  debconf-apt-progress -- apt-get -qq update 
  debconf-apt-progress -- apt-get -qqy upgrade 
  echo -e "[${green}HECHO${NC}]\n"

  echo "Instalando paquetes básicos... "
  debconf-apt-progress -- apt-get -y install ssh openssh-server vim-nox ntp ntpdate debconf-utils binutils sudo git lsb-release
  service apparmor stop 
  update-rc.d -f apparmor remove 
  debconf-apt-progress -- apt-get -y remove apparmor apparmor-utils

  echo "dash dash/sh boolean false" | debconf-set-selections
  dpkg-reconfigure -f noninteractive dash > /dev/null 2>&1
  echo -n "Reconfigurando dash... "
  echo -e "[${green}HECHO${NC}]\n"
}
