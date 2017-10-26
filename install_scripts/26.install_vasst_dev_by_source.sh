#!/bin/bash

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /opt"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi


INSTALL=$1
mkdir -p $INSTALL

git clone https://github.com/akhanf/vasst-dev $INSTALL/vasst-dev


PROFILE=~/.bashrc

if grep -xq "export VASST_DEV_HOME=$INSTALL/vasst-dev" $PROFILE #return 0 if exist
then 
 	echo "vasst-dev" in the PATH already.
else

	echo "export VASST_DEV_HOME=$INSTALL/vasst-dev" >> $PROFILE
	echo "export PIPELINE_ATLAS_DIR=$INSTALL/atlases" >> $PROFILE
	echo ". $INSTALL/vasst-dev/init_vasst_dev.sh"  >> $PROFILE
fi

