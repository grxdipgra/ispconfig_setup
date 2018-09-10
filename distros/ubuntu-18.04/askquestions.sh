#---------------------------------------------------------------------
# Function: AskQuestions Ubuntu 18.04
#    Pregunta por todas los datos necesarios
#---------------------------------------------------------------------
AskQuestions() {
	  echo "Instalando paquetes requeridos"
	  [ -f /bin/whiptail ] && echo -e "whiptail encontrado: ${green}OK${NC}\n"  || apt-get -y install whiptail > /dev/null 2>&1
	  
	  while [ "x$CFG_SQLSERVER" == "x" ]
          do
                CFG_SQLSERVER=$(whiptail --title "SQLSERVER" --backtitle "$WT_BACKTITLE" --nocancel --radiolist "Selecciona el tipo de servidor SQL" 10 50 2 "MySQL" "(default)" ON "MariaDB" "" OFF 3>&1 1>&2 2>&3)
          done
		  
	  while [ "x$CFG_MYSQL_ROOT_PWD" == "x" ]
	  do
		CFG_MYSQL_ROOT_PWD=$(whiptail --title "MySQL" --backtitle "$WT_BACKTITLE" --passwordbox "Introduzca la clave de root" --nocancel 10 50 3>&1 1>&2 2>&3)
	  done

	  while [ "x$CFG_WEBSERVER" == "x" ]
          do
                CFG_WEBSERVER=$(whiptail --title "WEBSERVER" --backtitle "$WT_BACKTITLE" --nocancel --radiolist "Seleccione el servidor web" 10 50 2 "apache" "(default)" ON "nginx" "" OFF 3>&1 1>&2 2>&3)
          done
	
	  while [ "x$CFG_XCACHE" == "x" ]
		  do
				CFG_XCACHE=$(whiptail --title "Instalar XCache" --backtitle "$WT_BACKTITLE" --nocancel --radiolist "¿Instalar XCache? ATENCION: Si XCache es instalado, Ioncube Loaders no funcionará!!" 20 50 2 "yes" "(default)" ON "no" "" OFF 3>&1 1>&2 2>&3)
	  done
	
	  while [ "x$CFG_PHPMYADMIN" == "x" ]
		  do
				CFG_PHPMYADMIN=$(whiptail --title "Instalar phpMyAdmin" --backtitle "$WT_BACKTITLE" --nocancel --radiolist "¿Quiere instalar phpMyAdmin?" 10 50 2 "yes" "(default)" ON "no" "" OFF 3>&1 1>&2 2>&3)
	  done
	
	  while [ "x$CFG_MTA" == "x" ]
	  do
		CFG_MTA=$(whiptail --title "Servidor de Correo" --backtitle "$WT_BACKTITLE" --nocancel --radiolist "Seleccione el servidor de correo" 10 50 2 "dovecot" "(default)" ON "courier" "" OFF 3>&1 1>&2 2>&3)
	  done
	  
	  	  	  
	  while [ "x$CFG_HHVMINSTALL" == "x" ]
	  do
		CFG_HHVMINSTALL=$(whiptail --title "Instalar HHVM" --backtitle "$WT_BACKTITLE" --nocancel --radiolist "¿Quiere instalar HHVM?" 10 50 2 "yes" "" OFF "no""(default)" ON 3>&1 1>&2 2>&3)
	  done
	  
	  while [ "x$CFG_METRONOM" == "x" ]
	  do
		CFG_METRONOM=$(whiptail --title "Servidor de Chat Metronom XMPP" --backtitle "$WT_BACKTITLE" --nocancel --radiolist "¿Instalar el servidor de chat Metronom XMPP?" 10 50 2 "yes" "" OFF "no""(default)" ON 3>&1 1>&2 2>&3)
	  done
	  
	  while [ "x$CFG_AVUPDATE" == "x" ]
	  do
		CFG_AVUPDATE=$(whiptail --title "Actualizar Freshclam DB Antivirus" --backtitle "$WT_BACKTITLE" --nocancel --radiolist "¿Desea actualizar la base de datos del antivirus?" 10 50 2 "yes" "(default)" ON "no" "" OFF 3>&1 1>&2 2>&3)
	  done
	  
	  if (whiptail --title "Quota" --backtitle "$WT_BACKTITLE" --yesno "¿Poner cuotas de espacio a los usuarios?" 10 50) then
		CFG_QUOTA=yes
	  else
		CFG_QUOTA=no
	  fi
	
      while [ "x$CFG_JOOMLA" == "x" ]
	  do
		CFG_JOOMLA=$(whiptail --title "Instalacion de CMS" --backtitle "$WT_BACKTITLE" --nocancel --radiolist "Seleccione el CMD por defecto" 10 50 2 "joomla" "(default)" ON "drupal" "" OFF 3>&1 1>&2 2>&3)
	  done
	
	  while [ "x$CFG_ISPC" == "x" ]
	  do
          	CFG_ISPC=$(whiptail --title "Configuración de ISPConfig " --backtitle "$WT_BACKTITLE" --nocancel --radiolist "¿Desea que la instalación sea desatendida o entrar en modo experto?" 10 50 2 "standard" "(default)" ON "expert" "" OFF 3>&1 1>&2 2>&3)
          done

	  if (whiptail --title "Jailkit" --backtitle "$WT_BACKTITLE" --yesno "¿Desea instalar Jailkit?" 10 50) then
		CFG_JKIT=yes
	  else
		CFG_JKIT=no
	  fi
	  
	  CFG_WEBMAIL=roundcube
	  
	  SSL_COUNTRY=$(whiptail --title "SSL Pais" --backtitle "$WT_BACKTITLE" --inputbox "Configuracion SSL - Pais (ejem. ES)" --nocancel 10 50  ES 3>&1 1>&2 2>&3)
      SSL_STATE=$(whiptail --title "SSL Estado" --backtitle "$WT_BACKTITLE" --inputbox "Configuracion SSL - ESTADO (ejem. Espana)" --nocancel 10 50 España 3>&1 1>&2 2>&3)
      SSL_LOCALITY=$(whiptail --title "SSL Localidad" --backtitle "$WT_BACKTITLE" --inputbox "Configuracion SSL - Localidad (ejem. Granada)" --nocancel 10 50 Granada 3>&1 1>&2 2>&3)
      SSL_ORGANIZATION=$(whiptail --title "SSL Organization" --backtitle "$WT_BACKTITLE" --inputbox "Configuracion SSL - Organizacion (ejem. Exma. Diputación de Granada)" --nocancel 10 50 "Exma. Diputación de Granada" 3>&1 1>&2 2>&3)
      SSL_ORGUNIT=$(whiptail --title "SSL Organization Unit" --backtitle "$WT_BACKTITLE" --inputbox "Configuracion SSL - Unidad de Organizacion (ejem. Dpto. Asistencia a Municipios)" --nocancel 10 50 "Dpto. Asistencia a Municipios - OSL" 3>&1 1>&2 2>&3)

}

