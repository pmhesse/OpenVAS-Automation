#!/bin/bash
# for building the software downloaded here http://www.openvas.org/install-source.html

if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user" 2>&1
  exit 1
fi

#####################################################################
## begin update area
## NOTE: you also have to update the URLs with the latest versions manually

LIBRARIES=openvas-libraries-8.0.5
LIBRARIESURL=http://wald.intevation.org/frs/download.php/2125/openvas-libraries-8.0.5.tar.gz

SCANNER=openvas-scanner-5.0.4
SCANNERURL=http://wald.intevation.org/frs/download.php/2129/openvas-scanner-5.0.4.tar.gz

MANAGER=openvas-manager-6.0.6
MANAGERURL=http://wald.intevation.org/frs/download.php/2169/openvas-manager-6.0.6.tar.gz

GSAD=greenbone-security-assistant-6.0.6
GSADURL=http://wald.intevation.org/frs/download.php/2173/greenbone-security-assistant-6.0.6.tar.gz

CLI=openvas-cli-1.4.3
CLIURL=http://wald.intevation.org/frs/download.php/2141/openvas-cli-1.4.3.tar.gz

## end update area
#####################################################################

if [ ! -f $LIBRARIES.tar.gz ]; then
	wget $LIBRARIESURL
	tar xvfz $LIBRARIES.tar.gz
else
	echo $LIBRARIES.tar.gz already exists, skipping.
fi
if [ ! -f $SCANNER.tar.gz ]; then
	wget $SCANNERURL
	tar xvfz $SCANNER.tar.gz
else
	echo $SCANNER.tar.gz already exists, skipping.
fi
if [ ! -f $MANAGER.tar.gz ]; then
	wget $MANAGERURL
	tar xvfz $MANAGER.tar.gz
else
	echo $MANAGER.tar.gz already exists, skipping.
fi
if [ ! -f $GSAD.tar.gz ]; then
	wget $GSADURL
	tar xvfz $GSAD.tar.gz
else
	echo $GSAD.tar.gz already exists, skipping.
fi
if [ ! -f $CLI.tar.gz ]; then
	wget $CLIURL
	tar xvfz $CLI.tar.gz
else
	echo $CLI.tar.gz already exists, skipping.
fi

read -p "To start the install/upgrade of OpenVAS please press [Enter]."

# before building OpenVAS here are the prerequisites for Ubuntu 14
# this includes everything needed for PDF generation - if you don't want that, remove texlive-latex-extra because it saves about 800mb
apt-get install apt-get install build-essential bison flex cmake pkg-config libglib2.0-0 libglib2.0-dev libgnutls26 libgnutls-dev libpcap0.8 libpcap0.8-dev libgpgme11 libgpgme11-dev doxygen libuuid1 uuid-dev sqlfairy xmltoman libsqlite3-0 libsqlite3-dev libxml2-dev libxslt1.1 libxslt1-dev xsltproc libmicrohttpd-dev libldap-2.4-2 libldap2-dev sqlite3 texlive-latex-extra nmap

./buildopenvascomponent.sh $LIBRARIES
./buildopenvascomponent.sh $SCANNER
./buildopenvascomponent.sh $MANAGER
./buildopenvascomponent.sh $GSAD
#./buildopenvascomponent.sh $CLI
