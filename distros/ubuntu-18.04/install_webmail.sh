#---------------------------------------------------------------------
# Funcion: InstallWebmail
# Instala RoundcubeRoundcube
#---------------------------------------------------------------------
InstallWebmail() {
  echo -n "Instalando el cliente webmail($CFG_WEBMAIL)... "
  echo "dictionaries-common dictionaries-common/default-wordlist select spanish" | debconf-set-selections
  echo "dbconfig-common dbconfig-common/internal/skip-preseed   boolean true" | debconf-set-selections
  echo "dbconfig-common dbconfig-common/mysql/admin-user        string ''" | debconf-set-selections
  debconf-apt-progress -- apt-get -y install roundcube roundcube-core roundcube-mysql roundcube-plugins javascript-common libjs-jquery-mousewheel php-net-sieve tinymce wspanish ispell

  
  if [ "$CFG_WEBSERVER" == "apache" ]; then
	  service apache2 restart > /dev/null 2>&1
  else
	  service nginx restart > /dev/null 2>&1
  fi
  echo -e "[${green}DONE${NC}]\n"
}

