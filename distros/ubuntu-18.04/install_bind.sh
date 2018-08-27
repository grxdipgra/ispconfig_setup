#---------------------------------------------------------------------
# Function: InstallBind
#    Install bind DNS server
#---------------------------------------------------------------------
InstallBind() {
  echo -n "Instalando Bind9... ";
  apt-get -y install bind9 dnsutils > /dev/null 2>&1
  echo -e "[${green}HECHO${NC}]\n"
}
