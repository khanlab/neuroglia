#!/bin/bash

apt-get update

#basic
apt-get install -y sudo wget curl git dos2unix tree zip unzip

#
apt-get install -y make cmake 

#needed when install Anaconda2
apt-get install -y bzip2

#needed when install nipype
apt-get install -y build-essential libtool autotools-dev automake autoconf

#needed when run itksnap
apt-get install -y libglu1-mesa libsm6 libxt-dev libglib2.0-dev libqt5x11extras5

#needed when install dcm4che
apt-get install -y default-jre

#needed when run freesurfer
apt-get install -y libqt4-scripttools libqt4-dev libjpeg62

#needed when run elastix
apt-get install -y ocl-icd-opencl-dev

#need when install minc
apt-get install -y imagemagick