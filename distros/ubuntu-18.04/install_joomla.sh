#---------------------------------------------------------------------
# Function: InstallBasePhp Debian 8
#    Install Basic php need to run ispconfig
#---------------------------------------------------------------------
InstallJoomla(){
  echo -n "Instalando Joomla como cms en ispconfig..."
  mkdir /tmp/joomla
  cd /tmp/joomla
  wget https://incidencias.dipgra.es/bionic-rep/Joomla_3.8.11-Stable-Full_Package.tar.bz2
  tar xjvf Joomla_3.8.11-Stable-Full_Package.tar.bz2
  rm Joomla_3.8.11-Stable-Full_Package.tar.bz2
  cd ..
  mv joomla/ /usr/local/ispconfig/server/
  
  echo -e "[${green}HECHO${NC}]\n"
}
