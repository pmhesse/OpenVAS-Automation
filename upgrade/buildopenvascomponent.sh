#!/bin/bash
# for building the software downloaded here http://www.openvas.org/install-source.html

if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user" 2>&1
  exit 1
fi

PASSED=$1

if [ $# -lt 1 ]; then
	echo 1>&2 "$0: not enough arguments"
	exit 2
fi
if [ -d "${PASSED}" ]; then
	echo "doing it"
	cd $1
	mkdir source
	cd source
	cmake ..
	make
	make install
	cd ../..
else
	echo 1>&2 "$0: must pass a directory name"
	exit 3
fi

