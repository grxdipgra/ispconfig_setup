#---------------------------------------------------------------------
# Function: InstallJoomla
# Instala joomla como web por defecto
#---------------------------------------------------------------------
InstallJoomla(){
  echo -n "Instalando Joomla como cms en Ispconfig..."
  mkdir /tmp/joomla
  cd /tmp/joomla
  wget https://incidencias.dipgra.es/bionic-rep/Joomla_3.8.11-Stable-Full_Package.tar.bz2
  tar xjvf Joomla_3.8.11-Stable-Full_Package.tar.bz2
  rm Joomla_3.8.11-Stable-Full_Package.tar.bz2
  cd ..
  mv joomla/ /usr/local/ispconfig/server/
  
  echo -e "[${green}HECHO${NC}]\n"
}
