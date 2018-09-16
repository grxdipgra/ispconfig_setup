#---------------------------------------------------------------------
# Function: InstallJoomla
# Instala joomla como web por defecto
#---------------------------------------------------------------------
InstallJoomla(){
  echo -n "Instalando Joomla como cms en Ispconfig..."
  mkdir /tmp/joomla
  cd /tmp/joomla
  if [ "$DIPGRA" == "no" ]; then
        wget https://github.com/joomla/joomla-cms/releases/download/3.8.11/Joomla_3.8.11-Stable-Full_Package.tar.bz2
  else
        wget https://incidencias.dipgra.es/bionic-rep/Joomla_3.8.11-Stable-Full_Package.tar.bz2
  fi
  tar xjvf Joomla_3.8.11-Stable-Full_Package.tar.bz2
  rm Joomla_3.8.11-Stable-Full_Package.tar.bz2
  cd ..
  mv joomla/ /usr/local/ispconfig/server/
  
  ##Con estas lineas ponemos joomla como cms de inicio de los portales
##  /usr/local/ispconfig/server/plugins-available/apache2_plugin.inc.php
  lineas=$(grep -n 'if(!file_exists(escapeshellcmd($data' /usr/local/ispconfig/server/plugins-available/apache2_plugin.inc.php | grep index.html |cut -d ':' -f '1'|sort -r)
  
  for i in $lineas
  do
    sed -i "${i}d" /usr/local/ispconfig/server/plugins-available/apache2_plugin.inc.php 
  done
  tmp=$(grep  -n "exec('chmod -R a+r '.escapeshellcmd($data" /usr/local/ispconfig/server/plugins-available/apache2_plugin.inc.php |cut -d ':' -f '1') 
  insertar="exec('cp -R ' . \$conf['rootpath'] . '/joomla/* '.escapeshellcmd(\$data['new']['document_root']).'/' . \$web_folder . '/');"
  sed -i "${tmp}i${insertar}" /usr/local/ispconfig/server/plugins-available/apache2_plugin.inc.php
  
  echo -e "[${green}HECHO${NC}]\n"
  
  
  ##Instalamos 
  
  if [ "$DIPGRA" == "no" ]; then
        wget https://github.com/aavidad/ispconfig_setup/sample_data.sql
  else
       wget https://incidencias.dipgra.es/bionic-rep/sample_data.sql
  fi
  rm /usr/local/ispconfig/server/joomla/installation/sql/mysql/sample*
  mv sample_data.sql /usr/local/ispconfig/server/joomla/installation/sql/mysql/       
  
    
}

