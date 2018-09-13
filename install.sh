#!/usr/bin/env bash
#---------------------------------------------------------------------
# install.sh
#
# ISPConfig 3 system installer
#
# Script: install.sh
# Version: 3.0.2
# Author: Matteo Temporini <temporini.matteo@gmail.com>
# Modificado y traducido por Alberto Avidad Fernandez - OSL Diputación de Granada
# Descripcion: Este script instalará todos los paquetes necesarios par instalar 
# ISPConfig 3 en un servidor ubuntu 18.04.
#
#
#---------------------------------------------------------------------

#Logeamos todo
exec > >(tee -i /var/log/ispconfig_setup.log)
exec 2>&1

#---------------------------------------------------------------------
# Variables Globales
#---------------------------------------------------------------------
CFG_HOSTNAME_FQDN=`hostname -f`;
WT_BACKTITLE="Sistema de instalación ISPConfig 3"

# Bash Colour
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0m' # Sin Color


#Guardamos el directorio actual
PWD=$(pwd);

#---------------------------------------------------------------------
# Cargamos funciones necesarias
#---------------------------------------------------------------------

source $PWD/functions/check_linux.sh
echo "Chequeando su sistema, por favor espere..."
CheckLinux

#---------------------------------------------------------------------
# Cargamos modulos necesarios
#---------------------------------------------------------------------

source $PWD/distros/$DISTRO/preinstallcheck.sh
source $PWD/distros/$DISTRO/askquestions.sh
source $PWD/distros/$DISTRO/install_basics.sh
source $PWD/distros/$DISTRO/install_postfix.sh
source $PWD/distros/$DISTRO/install_mysql.sh
source $PWD/distros/$DISTRO/install_mta.sh
source $PWD/distros/$DISTRO/install_antivirus.sh
source $PWD/distros/$DISTRO/install_webserver.sh
source $PWD/distros/$DISTRO/install_hhvm.sh
source $PWD/distros/$DISTRO/install_ftp.sh
source $PWD/distros/$DISTRO/install_quota.sh
source $PWD/distros/$DISTRO/install_bind.sh
source $PWD/distros/$DISTRO/install_webstats.sh
source $PWD/distros/$DISTRO/install_jailkit.sh
source $PWD/distros/$DISTRO/install_fail2ban.sh
source $PWD/distros/$DISTRO/install_webmail.sh
source $PWD/distros/$DISTRO/install_metronom.sh
source $PWD/distros/$DISTRO/install_ispconfig.sh
source $PWD/distros/$DISTRO/install_fix.sh
source $PWD/distros/$DISTRO/install_joomla.sh



#source $PWD/distros/$DISTRO/install_basephp.sh #to remove in feature release
#---------------------------------------------------------------------
# Main program [ main() ]
#    Run the installer
#---------------------------------------------------------------------
clear

echo "Bienvenido a ISPConfig Setup Script v.3.1"
echo "Este software esta basado en el trabajo de Temporini Matteo"
echo "Modificado por Alberto Avidad Fernández"
echo "========================================="
echo "Instalador de ISPConfig 3"
echo "========================================="
echo
echo "Este software sirve para instalar de forma desatendida ISPConfig 3."
echo "- Debemos tener internet";
echo
echo
if [ -n "$PRETTY_NAME" ]; then
	echo -e "La versión detectada de Linux: " $PRETTY_NAME
else
	echo -e "La distribución de Linux es: " $ID-$VERSION_ID
fi
echo
if [ -n "$DISTRO" ]; then
	read -p "¿Es correcto? (s/n)" -n 1 -r
	echo    # (optional) move to a new line
	if [[ ! $REPLY =~ ^[Ss]$ ]]
		then
		exit 1
	fi
else
	echo -e "Lo siento tu sistema no es compatible con este script"
	echo -e "Ponte en contacto con la OSL de Dipgra"
	exit 1
fi

if [ "$DISTRO" == "debian8" ]; then
	     while [ "x$CFG_ISPCVERSION" == "x" ]
          do
                CFG_ISPCVERSION=$(whiptail --title "ISPConfig Version" --backtitle "$WT_BACKTITLE" --nocancel --radiolist "Seleccione la versión de ISPConfig" 10 50 2 "estable" "(default)" ON "Beta" "" OFF 3>&1 1>&2 2>&3)
          done
         while [ "x$CFG_MULTISERVER" == "x" ]
          do
                CFG_MULTISERVER=$(whiptail --title "MULTISERVER SETUP" --backtitle "$WT_BACKTITLE" --nocancel --radiolist "¿Quiere instalar ISPConfig en un MultiServer Setup?" 10 50 2 "no" "(default)" ON "yes" "" OFF 3>&1 1>&2 2>&3)
          done
else
	CFG_MULTISERVER=no
fi

if [ -f /etc/debian_version ]; then
  PreInstallCheck
  if [ "$CFG_MULTISERVER" == "no" ]; then
	AskQuestions
  else
    source $PWD/distros/$DISTRO/askquestions_multiserver.sh
	AskQuestionsMultiserver
  fi
  InstallBasics 
  

  InstallSQLServer
  

  if [ "$CFG_SETUP_WEB" == "yes" ] || [ "$CFG_MULTISERVER" == "no" ]; then
    InstallWebServer
    

    InstallFTP 
    

    if [ "$CFG_QUOTA" == "yes" ]; then
    	InstallQuota 
    	

    fi
    if [ "$CFG_JKIT" == "yes" ]; then
    	InstallJailkit 
    	

    fi
    if [ "$CFG_HHVM" == "yes" ]; then
    	InstallHHVM
    	

    fi
    if [ "$CFG_METRONOM" == "yes" ]; then
    	InstallMetronom 
    	

    fi
    InstallWebmail 
    

  else
    InstallBasePhp    
  fi  
  if [ "$CFG_SETUP_MAIL" == "yes" ] || [ "$CFG_MULTISERVER" == "no" ]; then
    InstallPostfix 
    InstallMTA 
    InstallAntiVirus 
  fi  
  if [ "$CFG_SETUP_NS" == "yes" ] || [ "$CFG_MULTISERVER" == "no" ]; then
    InstallBind 
  fi
  InstallWebStats
  InstallFail2ban
  if [ "$CFG_ISPCVERSION" == "Beta" ]; then
		source $PWD/distros/$DISTRO/install_ispconfigbeta.sh
		InstallISPConfigBeta
  fi
  InstallISPConfig
  if [ "$CFG_JOOMLA" == "joomla" ]; then
    InstallJoomla
  else
    InstallDrupal
  fi
  
  InstallFix
  echo -e "${green}Ya tiene ISPConfig instalado y configurado correctamente :D ${NC}"
  echo "Ahora puede conectarse en https://$CFG_HOSTNAME_FQDN:8080 o https://IP_ADDRESS:8080"
  if [ "$CFG_WEBMAIL" == "roundcube" ]; then
    if [ "$DISTRO" != "debian8" ]; then
		echo -e "${red}Debes editar el usuario y la clave del archivo /var/lib/roundcube/plugins/ispconfig3_account/config/config.inc.php del usuario roudcube, como el que insertaste en ISPconfig ${NC}"
	fi
  fi
  if [ "$CFG_WEBSERVER" == "nginx" ]; then
  	if [ "$CFG_PHPMYADMIN" == "yes" ]; then
  		echo "Puede acceder a Phpmyadmin en http://$CFG_HOSTNAME_FQDN:8081/phpmyadmin o http://IP_ADDRESS:8081/phpmyadmin";
	fi
	if [ "$DISTRO" == "debian8" ] && [ "$CFG_WEBMAIL" == "roundcube" ]; then
		echo "Puede acceder al Webmail en https://$CFG_HOSTNAME_FQDN/webmail o https://IP_ADDRESS/webmail";
	else
		echo "Puede acceder al Webmail en http://$CFG_HOSTNAME_FQDN:8081/webmail o http://IP_ADDRESS:8081/webmail";
	fi
  fi
else 
	if [ -f /etc/centos-release ]; then
		echo "Attention please, this is the very first version of the script for CentOS 7"
		echo "Please use only for test purpose for now."
		echo -e "${red}Not yet implemented: courier, nginx support${NC}"
		echo -e "${green}Implemented: apache, mysql, bind, postfix, dovecot, roundcube webmail support${NC}"
		echo "Help us to test and implement, press ENTER if you understand what I'm talking about..."
		read DUMMY
		source $PWD/distros/$DISTRO/install_mailman.sh
		PreInstallCheck
		AskQuestions 
		InstallBasics 
		InstallPostfix 
		InstallSQLServer 
		InstallMTA 
		InstallAntiVirus 
		InstallWebServer
		InstallFTP 
		#if [ $CFG_QUOTA == "yes" ]; then
		#		InstallQuota 
		#fi
		InstallBind 
        InstallWebStats 
	    if [ "$CFG_JKIT" == "yes" ]; then
			InstallJailkit 
	    fi
		InstallFail2ban 
		if [ "$CFG_METRONOM" == "yes" ]; then
			InstallMetronom 
		fi
		InstallWebmail 
		InstallISPConfig
		#InstallFix
		echo -e "${green}Well done! ISPConfig installed and configured correctly :D ${NC}"
		echo "Now you can connect to your ISPConfig installation at https://$CFG_HOSTNAME_FQDN:8080 or https://IP_ADDRESS:8080"
		echo "You can visit my GitHub profile at https://github.com/servisys/ispconfig_setup/"
		echo -e "${red}If you setup Roundcube webmail go to http://$CFG_HOSTNAME_FQDN/roundcubemail/installer and configure db connection${NC}"
		echo -e "${red}After that disable access to installer in /etc/httpd/conf.d/roundcubemail.conf${NC}"
	else
		echo "${red}Unsupported linux distribution.${NC}"
	fi
fi

exit 0

