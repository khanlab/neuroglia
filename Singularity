Bootstrap: docker
From: ubuntu:xenial

#command
#rm neuroimage.img && singularity create  --size 10000 neuroimage.img && sudo singularity bootstrap neuroimage.img /mnt/hgfs/Dropbox/Robarts/NeuroImage/Singularity
#singularity exec neuroimage.img ants.sh
#heudiconv
#singularity exec -B /mnt/hgfs/data:data neuroimage.img heudiconv -b -d /data/7T_BIDS/dicoms/{subject}/*.IMA -s 001 -f /data/7T_BIDS/7T_TOPSY_BIDS_heuristic.py -c dcm2niix -b -o /data/output

#bids validator
singularity exec -B /mnt/hgfs/data:data neuroimage.img bids-validator /data/output

#how to modify image.
sudo singularity shell --contain --writable neuroimage.img

singularity exec -B /mnt/hgfs/data:data neuroimage.img dicom_retrieve.py /data/7T_BIDS_patientID_list.txt /data/output/dicom/ UWO_USERNAME UWO_PASSWORD


#########
%setup
#########
cp /mnt/hgfs/Dropbox/linux_install_scripts/*.sh $SINGULARITY_ROOTFS

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
PATH=/opt/matrix3/bin:$PATH

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
%post
#########
bash 00.install_gcc_make_cmake_dos2nix_sudo.sh
bash 02.install_anaconda2_by_binary.sh /opt
#bash 10.install_nipype_afni_fsl_sudo.sh
#bash 12.install_c3d_by_binary.sh /opt
#bash 13.install_itksnap_by_binary.sh /opt
bash 14.install_dcm4che_ubuntu.sh /opt
#bash 15.install_freesurfer_by_source.sh /opt
#bash 16.install_ants_by_binary.sh
bash 17.install_dcm2niix_by_binary.sh /opt
#bash 18.install_elastix_by_binary.sh /opt
#bash 19.install_dcmtk_by_binary.sh /opt
#bash 19.install_dcmtk_by_binary.sh /opt
#bash 21_install_MRtrix3_by_source_sudo.sh /opt
#bash 22.install_ashs_by_binary.sh /opt
#bash 22.install_minc_by_deb_sudo.sh
bash 23.install_heudiconv_by_source.sh /opt
bash 24.install_bids_validator_sudo.sh

#remove all install scripts
rm *.sh

#create scripts folder
mkdir -p /opt/scripts

#########
%files
#########
/mnt/hgfs/Dropbox/Robarts/7T_BIDS/dicom_retrieve.py /opt/scripts/dicom_retrieve.py

#########
%test
#########
#test itksnap, NOTE: itksnap -h, $? is 1 which will report "ABORT: Aborting with RETVAL=255"
#echo -n "testing itksnap: "
#/opt/itksnap/bin/itksnap -h
#if [ $? -eq 0 ]; then
#	echo "SUCCEED"
#else
#    echo "FAILED"
#fi
