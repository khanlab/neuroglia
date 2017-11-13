#!/bin/bash

if [ "$#" -lt 1 ]
then
echo "Usage: $0 <install folder (absolute path)>"
exit 0
fi

INSTALL=$1
mkdir -p $INSTALL

D_DIR=$1/dke
if [ -d $D_DIR ]; then
	rm -rf $D_DIR
fi
mkdir -p $D_DIR


#install Matlab MCR 2012a
RANDOM_TEMP=${RANDOM}
wget http://ssd.mathworks.com/supportfiles/MCR_Runtime/R2012a/MCR_R2012a_glnxa64_installer.zip -O ${RANDOM_TEMP}.zip;unzip -o ${RANDOM_TEMP}.zip -d $INSTALL/MCR; rm ${RANDOM_TEMP}.zip
sudo $INSTALL/MCR/install -mode silent -agreeToLicense yes

#install dke
RANDOM_TEMP=${RANDOM}
wget https://www.dropbox.com/s/trnelcwppyrlibf/Linux64.zip?dl=0 -O ${RANDOM_TEMP}.zip;unzip -o ${RANDOM_TEMP}.zip -d $D_DIR; rm ${RANDOM_TEMP}.zip
chmod a+x $D_DIR/*.sh

#install dke fiber tracking module
RANDOM_TEMP=${RANDOM}
wget https://www.dropbox.com/s/mvagskpbt75ah31/Linux_FT.zip?dl=0 -O ${RANDOM_TEMP}.zip;unzip -o ${RANDOM_TEMP}.zip -d $D_DIR; rm ${RANDOM_TEMP}.zip
chmod a+x $D_DIR/*.sh

echo $HOME

if [ -e $HOME/.profile ]; then #ubuntu
	PROFILE=$HOME/.profile
elif [ -e $HOME/.bash_profile ]; then #centos
	PROFILE=$HOME/.bash_profile
else
	echo "Add PATH manualy: PATH=$D_DIR"
	exit 0
fi

#check if PATH already exist in $PROFILE
if grep -xq "export PATH=$D_DIR:\$PATH" $PROFILE #return 0 if exist
then 
	echo "PATH=$D_DIR" in the PATH already.
else
	printf "\n#dke\n" >> $PROFILE    
	echo "export PATH=$D_DIR:\$PATH" >> $PROFILE    
	echo "export LD_LIBRARY_PATH=/usr/local/MATLAB/MATLAB_Compiler_Runtime/v717/runtime/glnxa64:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v717/bin/glnxa64:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v717/sys/os/glnxa64:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v717/sys/java/jre/glnxa64/jre/lib/amd64/native_threads:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v717/sys/java/jre/glnxa64/jre/lib/amd64/server:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v717/sys/java/jre/glnxa64/jre/lib/amd64:\$LD_LIBRARY_PATH">> $PROFILE
	echo "export XAPPLRESDIR=/usr/local/MATLAB/MATLAB_Compiler_Runtime/v717/X11/app-defaults">> $PROFILE
fi


# #test installation
# source $PROFILE
# ashs_main.sh -h 
# if [ $? -eq 0 ]; then
# 	echo 'SUCCESS'
# 	echo "To update PATH of current terminal: source $PFORFILE"
# 	echo "To update PATH of all terminal: re-login"
# else
#     echo 'FAIL.'
# fi
