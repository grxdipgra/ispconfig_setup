#---------------------------------------------------------------------
# Function: InstallQuota
#    Install and configure of disk quota
#---------------------------------------------------------------------
InstallQuota() {
  echo -n "Instalando e inicializando las cuotas de disco (puede tardar un buen rato)... "
  debconf-apt-progress -- apt-get -qqy install quota quotatool 

  if ! [ -f /proc/user_beancounters ]; then

	  if [ `cat /etc/fstab | grep ',usrjquota=aquota.user,grpjquota=aquota.group,jqfmt=vfsv0' | wc -l` -eq 0 ]; then
		sed -i '/tmpfs/!s/errors=remount-ro/errors=remount-ro,usrjquota=aquota.user,grpjquota=aquota.group,jqfmt=vfsv0/' /etc/fstab
	  fi
	  if [ `cat /etc/fstab | grep 'defaults' | wc -l` -ne 0 ]; then
		sed -i '/tmpfs/!s/defaults/defaults,usrjquota=aquota.user,grpjquota=aquota.group,jqfmt=vfsv0/' /etc/fstab
	  fi
	  mount -o remount /
	  quotacheck -avugm > /dev/null 2>&1
	  quotaon -avug > /dev/null 2>&1

  fi
  echo -e "[${green}HECHO${NC}]\n"
}
