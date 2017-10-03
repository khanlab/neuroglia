#!/bin/bash

IMAGE_FILE=~/test/neuroimage/neuroimage.img

echo -n "test anaconda install: "
singularity exec $IMAGE_FILE conda -h &> /dev/null
if [ $? -eq 0 ]; then
	echo 'SUCCESS'
else
    echo 'FAIL.'
fi

echo -n "testing afni install"
singularity exec $IMAGE_FILE afni --help &> /dev/null
if [ $? -eq 0 ]; then
	echo 'SUCCESS'
else
    echo 'FAIL.'
fi

echo -n "testing fsl install"
singularity exec $IMAGE_FILE fsl5.0-bet2 -h &> /dev/null  #fsl5.0-fsl -h always show a gui, use fsl5.0-bet2 instead.
if [ $? -eq 0 ]; then
	echo 'SUCCESS'
else
    echo 'FAIL.'
fi

#test minc, NOTE: mincinfo -h, $? is 1 which will report "ABORT: Aborting with RETVAL=255"
echo -n "testing mincinfo: "
singularity exec $IMAGE_FILE mincinfo -h &>/dev/null
if [ $? -eq 1 ]; then
	echo "SUCCESS"
else
   echo "FAIL"
fi

#test installation
echo -n "test c3d install: "
singularity exec $IMAGE_FILE c3d -h &>/dev/null
if [ $? -eq 0 ]; then
	echo "SUCCESS"
else
    echo 'FAIL.'
fi

#test itksnap, NOTE: itksnap -h, $? is 1 which will report "ABORT: Aborting with RETVAL=255"
echo -n "testing itksnap install: "
singularity exec $IMAGE_FILE itksnap -h &>/dev/null
if [ $? -eq 1 ]; then
	echo "SUCCESS"
else
   echo "FAIL"
fi

#test dcm4che
echo -n "testing dcm4che install: "
singularity exec $IMAGE_FILE getscu -h &>/dev/null
if [ $? -eq 0 ]; then
	echo "SUCCESS"
else
    echo "FAILED"
fi

#test freesurfer
echo -n "testing freesurfer install: "
singularity exec $IMAGE_FILE freesurfer -h &>/dev/null
if [ $? -eq 0 ]; then
	echo "SUCCESS"
else
    echo 'FAIL.'
fi

#test installation
echo -n "testing ants install: "
singularity exec $IMAGE_FILE ants.sh -h &>/dev/null
if [ $? -eq 0 ]; then
	echo "SUCCESS"
else
    echo 'FAIL.'
fi

#test installation
echo -n "testing dcm2niix install: "
singularity exec $IMAGE_FILE dcm2niix -h &>/dev/null
if [ $? -eq 0 ]; then
	echo "SUCCESS"
else
    echo "FAIL."
fi

#test installation
echo -n "testing elastix install: "
singularity exec $IMAGE_FILE elastix -h &>/dev/null
if [ $? -eq 0 ]; then
	echo "SUCCESS"
else
    echo 'FAIL.'
fi

#test installation
echo -n "testing dcmtk install: "
singularity exec $IMAGE_FILE dcmdump -h &>/dev/null
if [ $? -eq 0 ]; then
	echo "SUCCESS"
else
    echo 'FAIL.'
fi

#test installation
echo -n "testing MRtrix3 install: "
singularity exec $IMAGE_FILE mrview -h &>/dev/null
if [ $? -eq 0 ]; then
 	echo 'SUCCESS.'
else
     echo 'FAIL.'
fi

#test installation
echo -n "testing ashs install: "
singularity exec $IMAGE_FILE ashs_main.sh -h  &>/dev/null
if [ $? -eq 0 ]; then
	echo 'SUCCESS'
else
    echo 'FAIL.'
fi

#test installation
echo -n "testing heudiconv install: "
singularity exec $IMAGE_FILE heudiconv -h  >/dev/null
if [ $? -eq 0 ]; then
	echo 'SUCCESS'
else
    echo 'FAIL.'
fi

#test installation
echo -n "testing ashs install: "
singularity exec $IMAGE_FILE bids-validator -h  >/dev/null
if [ $? -eq 0 ]; then
	echo 'SUCCESS'
else
    echo 'FAIL.'
fi

## test dicom_retrieve
singularity exec -B /mnt/hgfs/data:data $IMAGE_FILE dicom_retrieve.py /data/7T_BIDS_patientID_list.txt /data/output/dicom/ UWO_USERNAME UWO_PASSWORD

#test heudiconv
#singularity exec -B /mnt/hgfs/data:data $IMAGE_FILE heudiconv -b -d /data/7T_BIDS/dicoms/{subject}/*.IMA -s 001 -f /data/7T_BIDS/7T_TOPSY_BIDS_heuristic.py -c dcm2niix -b -o /data/output

#BIDS-validator
#singularity exec -B /mnt/hgfs/data:data $IMAGE_FILE bids-validator /data/output
