#!/bin/bash
# for setting up the software downloaded here http://www.openvas.org/install-source.html
# based on this site http://hackertarget.com/install-openvas-7-ubuntu/

if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user" 2>&1
  exit 1
fi

openvas-mkcert
ldconfig
openvassd
openvas-nvt-sync
openvas-scapdata-sync
openvas-certdata-sync
openvasmd --create-user=admin --role=Admin
echo __________________________________________
read -p "pausing to allow you to copy the password. Hit [enter]..."
echo __________________________________________
openvas-mkcert-client -n -i
openvasmd --rebuild --progress
openvasmd
gsad
ps -ef | grep -E "openvas|gsad"
netstat -anp | grep LISTEN
echo __________________________________________
read -p "If all is well you should see two openvas services and one gsad service"
echo __________________________________________
