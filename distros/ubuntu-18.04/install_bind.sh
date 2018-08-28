#---------------------------------------------------------------------
# Function: InstallBind
#    Install bind DNS server
#---------------------------------------------------------------------
InstallBind() {
  echo -n "Instalando Bind9... ";
  debconf-apt-progress -- apt-get -y install bind9 dnsutils
  echo -e "[${green}HECHO${NC}]\n"
}
