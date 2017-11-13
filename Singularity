Bootstrap: docker
From: ubuntu:xenial

#Singularity file used to create  khanlab/neuroglia.img, contains:
# anaconda2-4.2.0(python 2.7.12)
# nipype 0.3.1
# afni Jun 12 2017
# fsl 5.0.9
# c3d 1.1.0
# itksnap 3.6.0
# dcm4che 3.3.8
# freesurfer 6.0.0
# ants 2.1.0
# dcm2niix 1.0.20170724 
# elastix 4.801
# dcmtk 3.6.2
# slicer 4.7 2017-09-30
# MRtrix3 3.0 rc2
# ashs 20170223
# minc 1.9.15
# heudiconv 0.3
# bids-validator 0.23.3
# DKE 2.6
# DKE Fibertracking(July 23, 2015)
# dicom_retrieve.py

#note: install_afni_fsl_sudo.sh solves error message when run itksnap: LibGlu.so.1

#run freesurfer's freeview 
# if libQtOpenGL.so.4, run sudo apt-get libqt4-dev
# if missing:  libjpeg.so.62, run apt-get install libjpeg62

#create image
#cd Dropbox/Robarts/neuroglia_singularity
#rm ~/neuroglia/neuroglia.img && singularity create  --size 20000 ~/neuroglia/neuroglia.img && sudo singularity bootstrap ~/neuroglia/neuroglia.img Singularity

#########
%setup
#########
cp ./install_scripts/*.sh $SINGULARITY_ROOTFS
mkdir -p $SINGULARITY_ROOTFS/opt/scripts
ln -fs /usr/share/zoneinfo/US/Pacific-New /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

#########
%post
#########
export DEBIAN_FRONTEND=noninteractive

bash 00.install_basics_sudo.sh
bash 03.install_anaconda2_nipype_dcmstack_by_binary.sh /opt
bash 04.install_octave_sudo.sh 
bash 10.install_afni_fsl_sudo.sh
bash 12.install_c3d_by_binary.sh /opt
bash 15.install_freesurfer_by_source.sh /opt
bash 16.install_ants_by_binary.sh /opt
bash 17.install_dcm2niix_by_binary.sh /opt
bash 18.install_elastix_by_binary.sh /opt
bash 21.install_MRtrix3_by_source_sudo.sh /opt
bash 22.install_ashs_by_binary.sh /opt
bash 23.install_heudiconv_by_source.sh /opt
bash 24.install_bids-validator_sudo.sh
bash 25.install_niftyreg_by_source.sh /opt
bash 26.install_vasst_dev_by_source.sh /opt
bash 27.install_vasst_dev_atlases_by_source.sh /opt
bash 28.install_camino_by_source.sh /opt
bash 29.install_unring_by_binary.sh /opt
bash 30.install_dke_by_binary.sh /opt


#bash 11.install_minc_by_deb_sudo.sh /opt
#bash 13.install_itksnap_by_binary.sh /opt
#bash 14.install_dcm4che_ubuntu.sh /opt
#bash 19.install_dcmtk_by_binary.sh /opt
#bash 20.install_slicer_by_binary.sh /opt


#remove all install scripts
rm *.sh

#create scripts folder
mkdir -p /opt/scripts

#########
%environment

#told apt-get to skip any interactive steps
export DEBIAN_FRONTEND=noninteractive

#export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

#anaconda2
export PATH=/opt/anaconda2/bin/:$PATH

#c3d
export PATH=/opt/c3d/bin:$PATH
#leave out deps for c3d gui to avoid conflicts
#export LD_LIBRARY_PATH=/opt/c3d/lib/c3d_gui-1.1.0:$LD_LIBRARY_PATH 

#itksnap
export PATH=/opt/itksnap/bin:$PATH
export LD_LIBRARY_PATH=/opt/itksnap/lib/snap-3.6.0:$LD_LIBRARY_PATH

#dicom_retrieve.py use dcm4che's getscu. So, put dcm4che's PATH before dcmtk's PATH
#dcm4che
export PATH=/opt/dcm4che-3.3.8/bin:$PATH


#fsl
export FSLDIR=/usr/share/fsl/5.0
export POSSUMDIR=$FSLDIR
export PATH=/usr/lib/fsl/5.0:$PATH
export FSLOUTPUTTYPE=NIFTI_GZ
export FSLMULTIFILEQUIT=TRUE
export FSLTCLSH=/usr/bin/tclsh
export FSLWISH=/usr/bin/wish
export FSLBROWSER=/etc/alternatives/x-www-browser
export LD_LIBRARY_PATH=/usr/lib/fsl/5.0:${LD_LIBRARY_PATH}


#freesurfer
export PATH=/opt/freesurfer/bin:$PATH
export FREESURFER_HOME=/opt/freesurfer
export FSFAST_HOME=/opt/freesurfer/fsfast
export FSF_OUTPUT_FORMAT=nii.gz
export SUBJECTS_DIR=/opt/freesurfer/subjects
export MNI_DIR=/opt/fresurfer/mni
export MINC_BIN_DIR=/opt/freesurfer/mni/bin
export MINC_LIB_DIR=/opt/freesurfer/mni/lib

#ants
export PATH=/opt/ants:$PATH
export ANTSPATH=/opt/ants

#dcm2niix
export PATH=/opt/mricrogl_lx:$PATH

#elastix
export PATH=/opt/elastix:$PATH
export LD_LIBRARY_PATH=/opt/elastix:$LD_LIBRARY_PATH

#dcmtk
export PATH=/opt/dcmtk/bin:$PATH

#slicer
export PATH=/opt/slicer:$PATH

#MRtrix3
export PATH=/opt/mrtrix3/bin:$PATH

#ashs
export PATH=/opt/ashs/ashs-fastashs/bin:$PATH

#minc
#export MINC_TOOLKIT=/opt/minc/1.9.15
#export MINC_TOOLKIT_VERSION="1.9.15-20170529"
#export PATH=/opt/minc/1.9.15/bin:/opt/minc/1.9.15/pipeline:${PATH}
#export PERL5LIB=/opt/minc/1.9.15/perl:/opt/minc/1.9.15/pipeline:${PERL5LIB}
#export LD_LIBRARY_PATH=/opt/minc/1.9.15/lib:/opt/minc/1.9.15/lib/InsightToolkit:${LD_LIBRARY_PATH}
#export MNI_DATAPATH=/opt/minc/1.9.15/share
#export MINC_FORCE_V2=1
#export MINC_COMPRESS=4
#export VOLUME_CACHE_THRESHOLD=-1
#export MANPATH=/opt/minc/1.9.15/man:${MANPATH}

#heudiconv
export PATH=/opt/heudiconv:$PATH

#niftyreg
export LD_LIBRARY_PATH=/opt/niftyreg/lib:$LD_LIBRARY_PATH 
export PATH=/opt/niftyreg/bin:$PATH

#Matlab 2012a MCR, needed by Diffusional Kurtosis Imaging
export LD_LIBRARY_PATH=/usr/local/MATLAB/MATLAB_Compiler_Runtime/v717/runtime/glnxa64:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v717/bin/glnxa64:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v717/sys/os/glnxa64:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v717/sys/java/jre/glnxa64/jre/lib/amd64/native_threads:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v717/sys/java/jre/glnxa64/jre/lib/amd64/server:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v717/sys/java/jre/glnxa64/jre/lib/amd64:$LD_LIBRARY_PATH
export XAPPLRESDIR=/usr/local/MATLAB/MATLAB_Compiler_Runtime/v717/X11/app-defaults

#dke
#dke Fiber Tractography
export PATH=/opt/dke:$PATH

#scripts
export PATH=/opt/scripts:$PATH

#vasst-dev
export VASST_DEV_HOME=/opt/vasst-dev
export PIPELINE_ATLAS_DIR=/opt/atlases
export PIPELINE_DIR=$VASST_DEV_HOME/pipeline
export PIPELINE_TOOL_DIR=$VASST_DEV_HOME/tools
MIAL_DEPENDS_DIR=$VASST_DEV_HOME/mial-depends
#MIAL_DEPENDS_LIBS=$VASST_DEV_HOME/mial-depends/lib
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MIAL_DEPENDS_LIBS
export PIPELINE_CFG_DIR=$PIPELINE_DIR/cfg
export PATH=$PIPELINE_TOOL_DIR:$MIAL_DEPENDS_DIR:$PATH
export MCRBINS=$VASST_DEV_HOME/mcr/v92
for name in `ls -d $PIPELINE_DIR/*`; do  export PATH=$name:$PATH; done
#mcr - vasst-dev dependency
export MCRROOT=/opt/mcr/v92



#camino
export PATH=/opt/camino/bin:$PATH
export LD_LIBRARY_PATH=/opt/camino/lib:$LD_LIBRARY_PATH
export MANPATH=/opt/camino/lib:$MANPATH
export CAMINO_HEAP_SIZE=32000

#unring
export PATH=/opt/unring/bin:$PATH


#dke
export PATH=/opt/dke:$PATH

%files
#########
./files_scripts/dicom_retrieve.py /opt/scripts/dicom_retrieve.py
./files_scripts/7T_TOPSY_BIDS_heuristic.py /opt/scripts/7T_TOPSY_BIDS_heuristic.py
