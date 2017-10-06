FROM ubuntu:xenial


COPY ./install_scripts/*.sh /


ENV DEBIAN_FRONTEND=noninteractive
RUN bash 00.install_basics_sudo.sh
RUN bash 03.install_anaconda2_nipype_dcmstack_by_binary.sh /opt
RUN bash 10.install_afni_fsl_sudo.sh
RUN bash 11.install_minc_by_deb_sudo.sh /opt
RUN bash 12.install_c3d_by_binary.sh /opt
RUN bash 13.install_itksnap_by_binary.sh /opt
RUN bash 14.install_dcm4che_ubuntu.sh /opt
RUN bash 15.install_freesurfer_by_source.sh /opt
RUN bash 16.install_ants_by_binary.sh /opt
RUN bash 17.install_dcm2niix_by_binary.sh /opt
RUN bash 18.install_elastix_by_binary.sh /opt
RUN bash 19.install_dcmtk_by_binary.sh /opt
RUN bash 20.install_slicer_by_binary.sh /opt
RUN bash 21.install_MRtrix3_by_source_sudo.sh /opt
RUN bash 22.install_ashs_by_binary.sh /opt
RUN bash 23.install_heudiconv_by_source.sh /opt
RUN bash 24.install_bids-validator_sudo.sh
RUN bash 25.install_niftyreg_by_source.sh /opt
RUN rm /*.sh


ENV PATH=/opt/anaconda2/bin/:$PATH

#c3d
ENV PATH=/opt/c3d/bin:$PATH
ENV LD_LIBRARY_PATH=/opt/c3d/lib/c3d_gui-1.1.0:$LD_LIBRARY_PATH

#itksnap
ENV PATH=/opt/itksnap/bin:$PATH
ENV LD_LIBRARY_PATH=/opt/itksnap/lib/snap-3.6.0:$LD_LIBRARY_PATH

#dicom_retrieve.py use dcm4che's getscu. So, put dcm4che's PATH before dcmtk's PATH
#dcm4che
ENV PATH=/opt/dcm4che-3.3.8/bin:$PATH


#fsl
ENV FSLDIR=/usr/share/fsl/5.0
ENV POSSUMDIR=$FSLDIR
ENV PATH=/usr/lib/fsl/5.0:$PATH
ENV FSLOUTPUTTYPE=NIFTI_GZ
ENV FSLMULTIFILEQUIT=TRUE
ENV FSLTCLSH=/usr/bin/tclsh
ENV FSLWISH=/usr/bin/wish
ENV FSLBROWSER=/etc/alternatives/x-www-browser
ENV LD_LIBRARY_PATH=/usr/lib/fsl/5.0:${LD_LIBRARY_PATH}

#freesurfer
ENV PATH=/opt/freesurfer/bin:$PATH
ENV FREESURFER_HOME=/opt/freesurfer
ENV FSFAST_HOME=/opt/freesurfer/fsfast
ENV FSF_OUTPUT_FORMAT=nii.gz
ENV SUBJECTS_DIR=/opt/freesurfer/subjects
ENV MNI_DIR=/opt/fresurfer/mni
ENV MINC_BIN_DIR=/opt/freesurfer/mni/bin
ENV MINC_LIB_DIR=/opt/freesurfer/mni/lib

#ants
ENV PATH=/opt/ants:$PATH
ENV ANTSPATH=/opt/ants

#dcm2niix
ENV PATH=/opt/mricrogl_lx:$PATH

#elastix
ENV PATH=/opt/elastix:$PATH
ENV LD_LIBRARY_PATH=/opt/elastix:$LD_LIBRARY_PATH

#dcmtk
ENV PATH=/opt/dcmtk/bin:$PATH

#slicer
ENV PATH=/opt/slicer:$PATH

#MRtrix3
ENV PATH=/opt/mrtrix3/bin:$PATH

#ashs
ENV PATH=/opt/ashs/ashs-fastashs/bin:$PATH

#minc
ENV MINC_TOOLKIT=/opt/minc/1.9.15
ENV MINC_TOOLKIT_VERSION="1.9.15-20170529"
ENV PATH=/opt/minc/1.9.15/bin:/opt/minc/1.9.15/pipeline:${PATH}
ENV PERL5LIB=/opt/minc/1.9.15/perl:/opt/minc/1.9.15/pipeline:${PERL5LIB}
ENV LD_LIBRARY_PATH=/opt/minc/1.9.15/lib:/opt/minc/1.9.15/lib/InsightToolkit:${LD_LIBRARY_PATH}
ENV MNI_DATAPATH=/opt/minc/1.9.15/share
ENV MINC_FORCE_V2=1
ENV MINC_COMPRESS=4
ENV VOLUME_CACHE_THRESHOLD=-1
ENV MANPATH=/opt/minc/1.9.15/man:${MANPATH}

#heudiconv
ENV PATH=/opt/heudiconv:$PATH

#niftyreg
ENV LD_LIBRARY_PATH=/opt/niftyreg/lib:$LD_LIBRARY_PATH 
ENV PATH=/opt/niftyreg/bin:$PATH

#scripts
ENV PATH=/opt/scripts:$PATH


