#---------------------------------------------------------------------
# Function: PreInstallCheck
#    Do some pre-install checks
#---------------------------------------------------------------------
PreInstallCheck() {
  # Comprobando si el usuario es root
  if [ $(id -u) != "0" ]; then
    echo -n "Error: Debes ser root para correr este script."
    exit 1
  fi
  
  # Comprobando conectividad 

  echo -n "Comprobando conexion a internet fuera de Diputacion... "
  ping -q -c 3 www.google.es > /dev/null 2>&1

  if [ ! "$?" -eq 0 ]; then
        echo -e "${red}ERROR: No hemos podido hacer ping a www.google.es${NC}"
        echo -n "${red}Comprobando ping al repositorio de Diputacion... ${NC}"
        ping -q -c 3 10.1.1.91 > /dev/null 2>&1
        if [ ! "$?" -eq 0 ]; then
            echo -e "${red}ERROR: No hemos podido hacer ping al repositorio interno ni a internet${NC}"
            echo -e "${red}ERROR: No tenemos conexion ni dentro ni fuera de la Diputacion, comprueba la conexion${NC}"
            echo -e "${red}ERROR: Es necesario tener conexion a internet para instalar ISPConfig en su sistema${NC}"
            exit 1
        else 
            echo -e "${green}Añadiendo el repositorio de Diputacion en su sistema${NC}"
            echo 'Acquire::http::proxy "http://incidencias.dipgra.es:8080/";' >> /etc/apt/apt.conf.d/00proxy
            echo 'Acquire::http::proxy::incidencias.dipgra.es "DIRECT";' >> /etc/apt/apt.conf.d/00proxy
        fi
  fi

  # Comprobamos si tenemos alguna version de ISPConfig en el sistema
  if [ -f /usr/local/ispconfig/interface/lib/config.inc.php ]; then
    echo "${red}ISPConfig ya está instalado, no puedo continuar.${NC}"
	exit 1
  fi
  
  # Comprobamos source.list
  
  if [ -f /etc/apt/source.list ]; then
    echo "${red}Se ha movido el archivo /etc/apt/source.list a /etc/apt/source.list.old${NC}"
    mv /etc/apt/source.list /etc/apt/source.list.old
  fi

    echo "deb http://de.archive.ubuntu.com/ubuntu/ bionic main restricted" >> /etc/apt/source.list
    echo "deb http://de.archive.ubuntu.com/ubuntu/ bionic-updates main restricted" >> /etc/apt/source.list
    echo "deb http://de.archive.ubuntu.com/ubuntu/ bionic universe" >> /etc/apt/source.list
    echo "deb http://de.archive.ubuntu.com/ubuntu/ bionic-updates universe" >> /etc/apt/source.list
    echo "deb http://de.archive.ubuntu.com/ubuntu/ bionic multiverse" >> /etc/apt/source.list
    echo "deb http://de.archive.ubuntu.com/ubuntu/ bionic-updates multiverse" >> /etc/apt/source.list
    echo "deb http://de.archive.ubuntu.com/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/source.list
    echo "deb http://security.ubuntu.com/ubuntu bionic-security main restricted" >> /etc/apt/source.list
    echo "deb http://security.ubuntu.com/ubuntu bionic-security universe" >> /etc/apt/source.list
    echo "deb http://security.ubuntu.com/ubuntu bionic-security multiverse" >> /etc/apt/source.list
  
echo -e "${green} OK${NC}\n"
}


