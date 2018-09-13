#---------------------------------------------------------------------
# Function: PreInstallCheck
#    Do some pre-install checks
#---------------------------------------------------------------------
PreInstallCheck() {
  # Comprobando si el usuario es root
  if [ $(id -u) != "0" ]; then
    echo -n "Error: Debes ser root para correr este script.\n"
    exit 1
  fi
  DIPGRA="no"
  # Comprobando conectividad 

  echo -n "Comprobando conexion a internet fuera de Diputacion... "
  ping -q -c 3 www.google.es > /dev/null 2>&1

  if [ ! "$?" -eq 0 ]; then
        echo -e "\n${red}No hemos podido hacer ping a www.google.es${NC}\n"
        echo -n "\n${red}Comprobando ping al repositorio de Diputacion... ${NC}\n"
        ping -q -c 3 10.1.1.91 > /dev/null 2>&1
        if [ ! "$?" -eq 0 ]; then
            echo -e "\n${red}ERROR: No hemos podido hacer ping al repositorio interno ni a internet${NC}\n"
            echo -e "\n${red}ERROR: No tenemos conexion ni dentro ni fuera de la Diputacion, comprueba la conexion${NC}\n"
            echo -e "\n${red}ERROR: Es necesario tener conexion a internet para instalar ISPConfig en su sistema${NC}\n"
            exit 1
        else 
            echo -e "\n${green}Añadiendo el repositorio de Diputacion en su sistema${NC}\n"
            DIPGRA="si"
            echo 'Acquire::http::proxy "http://incidencias.dipgra.es:8080/";' >> /etc/apt/apt.conf.d/00proxy
            echo 'Acquire::http::proxy::incidencias.dipgra.es "DIRECT";' >> /etc/apt/apt.conf.d/00proxy
        fi
  fi

  # Comprobamos si tenemos alguna version de ISPConfig en el sistema
  if [ -f /usr/local/ispconfig/interface/lib/config.inc.php ]; then
    echo "${red}ISPConfig ya está instalado, no puedo continuar.${NC}"
	exit 1
  fi
  
  # Comprobamos sources.list
  
  if [ -f /etc/apt/sources.list ]; then
    echo "\n${red}Se ha movido el archivo /etc/apt/source.list a /etc/apt/source.list.old${NC}\n"
    mv /etc/apt/sources.list /etc/apt/sources.list.old
  fi

    echo "deb http://archive.ubuntu.com/ubuntu/ bionic main universe restricted multiverse" >> /etc/apt/sources.list
    echo "deb http://archive.ubuntu.com/ubuntu/ bionic-updates main universe restricted multiverse" >> /etc/apt/sources.list
    echo "deb http://archive.ubuntu.com/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list
    echo "deb http://security.ubuntu.com/ubuntu bionic-security main universe restricted multiverse" >> /etc/apt/sources.list
    
  
echo -e "${green} OK${NC}\n"
}


