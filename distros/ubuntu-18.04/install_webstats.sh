#---------------------------------------------------------------------
# Function: InstallWebStats
#    Install and configure web stats
#---------------------------------------------------------------------
InstallWebStats() {
  echo -n "Instalando stats... ";
  apt-get -y install vlogger webalizer awstats geoip-database libclass-dbi-mysql-perl > /dev/null 2>&1
  sed -i 's/^/#/' /etc/cron.d/awstats
  echo -e "[${green}HECHO${NC}]\n"
}

