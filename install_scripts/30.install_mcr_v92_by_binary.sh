#!/bin/bash

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /opt"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi



INSTALL=$1
TMP_DIR=/tmp/mcr
MCR_DIR=$INSTALL/mcr/v92
mkdir -p $TMP_DIR $MCR_DIR

curl -L --retry 5 http://ssd.mathworks.com/supportfiles/downloads/R2017a/deployment_files/R2017a/installers/glnxa64/MCR_R2017a_glnxa64_installer.zip > $TMP_DIR/install.zip
pushd $TMP_DIR
unzip install.zip
./install -mode silent -agreeToLicense yes -destinationFolder $MCR_DIR
popd

rm -rf $TMP_DIR


#set MCRROOT in bashrc
