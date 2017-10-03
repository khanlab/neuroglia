Bootstrap: docker
From: ubuntu:xenial

#Singularity file used to create neuroimage.img, contains:
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
# MRtrix3 3.0 rc2
# ashs 20170223
# minc 1.9.15
# heudiconv 0.3
# bids-validator 0.23.3
# dicom_retrieve.py

#note: install_afni_fsl_sudo.sh solves error message when run itksnap: LibGlu.so.1

#run freesurfer's freeview 
# if libQtOpenGL.so.4, run sudo apt-get libqt4-dev
# if missing:  libjpeg.so.62, run apt-get install libjpeg62

#create image
#rm neuroimage.img && singularity create  --size 20000 neuroimage.img && sudo singularity bootstrap neuroimage.img /mnt/hgfs/Dropbox/Robarts/neuroimage_singularity/Singularity.sh

#########
%setup
#########
cp /mnt/hgfs/Dropbox/linux_install_scripts/*.sh $SINGULARITY_ROOTFS

#########
%post
#########
bash 00.install_basics_sudo.sh
bash 03.install_anaconda2_nipype_dcmstack_by_binary.sh /opt
bash 10.install_afni_fsl_sudo.sh
bash 11.install_minc_by_deb_sudo.sh /opt
bash 12.install_c3d_by_binary.sh /opt
bash 13.install_itksnap_by_binary.sh /opt
bash 14.install_dcm4che_ubuntu.sh /opt
bash 15.install_freesurfer_by_source.sh /opt
bash 16.install_ants_by_binary.sh /opt
bash 17.install_dcm2niix_by_binary.sh /opt
bash 18.install_elastix_by_binary.sh /opt
bash 19.install_dcmtk_by_binary.sh /opt
bash 21.install_MRtrix3_by_source_sudo.sh /opt
bash 22.install_ashs_by_binary.sh /opt
bash 23.install_heudiconv_by_source.sh /opt
bash 24.install_bids-validator_sudo.sh

#remove all install scripts
rm *.sh

#create scripts folder
mkdir -p /opt/scripts

#########
%environment
#########
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

#anaconda2
PATH=/opt/anaconda2/bin/:$PATH

#c3d
PATH=/opt/c3d/bin:$PATH
LD_LIBRARY_PATH=/opt/c3d/lib/c3d_gui-1.1.0:$LD_LIBRARY_PATH

#itksnap
PATH=/opt/itksnap/bin:$PATH
LD_LIBRARY_PATH=/opt/itksnap/lib/snap-3.6.0:$LD_LIBRARY_PATH

#dcmtk #note: dicom_retrieve.py use dcm4che's getscu. So, put dcm4che's PATH before dcmtk's PATH
PATH=/opt/dcmtk/bin:$PATH

#dcm4che
PATH=/opt/dcm4che-3.3.8/bin:$PATH

#freesurfer
PATH=/opt/freesurfer/bin:$PATH
FREESURFER_HOME=/opt/freesurfer
FSFAST_HOME=/opt/freesurfer/fsfast
FSF_OUTPUT_FORMAT=nii.gz
SUBJECTS_DIR=/opt/freesurfer/subjects
MNI_DIR=/opt/fresurfer/mni
MINC_BIN_DIR=/opt/freesurfer/mni/bin
MINC_LIB_DIR=/opt/freesurfer/mni/lib

#ants
PATH=/opt/ants:$PATH
ANTSPATH=/opt/ants

#dcm2niix
PATH=/opt/mricrogl_lx:$PATH

#elastix
PATH=/opt/elastix:$PATH
LD_LIBRARY_PATH=/opt/elastix:$LD_LIBRARY_PATH

#MRtrix3
PATH=/opt/mrtrix3/bin:$PATH

#ashs
PATH=/opt/ashs/ashs-fastashs/bin:$PATH

#minc
MINC_TOOLKIT=/opt/minc/1.9.15
MINC_TOOLKIT_VERSION="1.9.15-20170529"
PATH=/opt/minc/1.9.15/bin:/opt/minc/1.9.15/pipeline:${PATH}
PERL5LIB=/opt/minc/1.9.15/perl:/opt/minc/1.9.15/pipeline:${PERL5LIB}
LD_LIBRARY_PATH=/opt/minc/1.9.15/lib:/opt/minc/1.9.15/lib/InsightToolkit:${LD_LIBRARY_PATH}
MNI_DATAPATH=/opt/minc/1.9.15/share
MINC_FORCE_V2=1
MINC_COMPRESS=4
VOLUME_CACHE_THRESHOLD=-1
MANPATH=/opt/minc/1.9.15/man:${MANPATH}

#heudiconv
PATH=/opt/heudiconv:$PATH

#scripts
PATH=/opt/scripts:$PATH

#########
%files
#########
/mnt/hgfs/Dropbox/Robarts/7T_BIDS/dicom_retrieve.py /opt/scripts/dicom_retrieve.py
/mnt/hgfs/Dropbox/Robarts/7T_BIDS/7T_TOPSY_BIDS_heuristic.py /opt/scripts/7T_TOPSY_BIDS_heuristic.py
