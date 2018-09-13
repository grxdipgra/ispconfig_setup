#---------------------------------------------------------------------
# Funcion: InstallWebmail
# Instala Roundcube
#---------------------------------------------------------------------


InstallWebmail() {
  echo -n "Instalando el cliente webmail($CFG_WEBMAIL)... "
  echo "dictionaries-common dictionaries-common/default-wordlist select spanish" | debconf-set-selections
  echo "dbconfig-common dbconfig-common/internal/skip-preseed   boolean true" | debconf-set-selections
  echo "dbconfig-common dbconfig-common/mysql/admin-user        string 'root'" | debconf-set-selections
  echo "dbconfig-common dbconfig-common/mysql/admin-pass password $CFG_MYSQL_ROOT_PWD" | debconf-set-selections
  echo 'roundcube-core roundcube/dbconfig-install boolean true'     | debconf-set-selections
  echo 'roundcube-core roundcube/database-type select mysql'        | debconf-set-selections
  echo "roundcube-core roundcube/mysql/admin-pass password $CFG_MYSQL_ROOT_PWD" | debconf-set-selections
  echo 'roundcube-core roundcube/language select es_ES'             | debconf-set-selections
  echo "roundcube-core roundcube/mysql/admin-pass password $CFG_MYSQL_ROOT_PWD" | debconf-set-selections
  echo "roundcube-core roundcube/mysql/app-pass password $CFG_MYSQL_ROOT_PWD" | debconf-set-selections
  echo "roundcube-core roundcube/app-password-confirm password $CFG_MYSQL_ROOT_PWD" | debconf-set-selections
  echo 'roundcube-core roundcube/password-confirm password $CFG_MYSQL_ROOT_PWD'             | debconf-set-selections
  
  
  debconf-apt-progress -- apt-get -y install roundcube roundcube-core roundcube-mysql roundcube-plugins javascript-common libjs-jquery-mousewheel php-net-sieve tinymce wspanish ispell

  
  if [ "$CFG_WEBSERVER" == "apache" ]; then
	  service apache2 restart > /dev/null 2>&1
  else
	  service nginx restart > /dev/null 2>&1
  fi
  echo -e "[${green}DONE${NC}]\n"
}

