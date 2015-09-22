#!/bin/bash
# for setting up the software downloaded here http://www.openvas.org/install-source.html
# based on this site http://hackertarget.com/install-openvas-7-ubuntu/

if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user" 2>&1
  exit 1
fi


ldconfig
openvassd
openvas-nvt-sync
openvas-scapdata-sync
openvas-certdata-sync
openvasmd --rebuild --progress
openvasmd
gsad
ps -ef | grep -E "openvas|gsad"
netstat -anp | grep LISTEN
echo __________________________________________
read -p "Verify that the OpenVAS and GSAd processes are listening, then reboot your server to complete the install."
echo __________________________________________
