#---------------------------------------------------------------------
# Function: InstallJoomla
# Instala joomla como web por defecto
#---------------------------------------------------------------------
InstallJoomla(){
  echo -n "Instalando Joomla como cms en Ispconfig..."
  mkdir /tmp/joomla
  cd /tmp/joomla
  if [ "$DIPGRA" == "no" ]; then
        wget https://github.com/joomla/joomla-cms/releases/download/3.8.11/Joomla_3.8.11-Stable-Full_Package.tar.bz2
  else
        wget https://incidencias.dipgra.es/bionic-rep/Joomla_3.8.11-Stable-Full_Package.tar.bz2
  fi
  tar xjvf Joomla_3.8.11-Stable-Full_Package.tar.bz2
  rm Joomla_3.8.11-Stable-Full_Package.tar.bz2
  cd ..
  mv joomla/ /usr/local/ispconfig/server/
  
  echo -e "[${green}HECHO${NC}]\n"
}

