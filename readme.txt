How to download neuroglia.img?
	singularity pull shub://khanlab/neuroglia:master
	singularity pull docker://khanlab/neuroglia:0.0.1

What package in the image?
  anaconda2-4.2.0(python 2.7.12)
  nipype 0.3.1
  afni Jun 12 2017
  fsl 5.0.9
  c3d 1.1.0
  itksnap 3.6.0
  dcm4che 3.3.8
  freesurfer 6.0.0
  ants 2.1.0
  dcm2niix 1.0.20170724 
  elastix 4.801
  dcmtk 3.6.2
  slicer 4.7 2017-09-30
  MRtrix3 3.0 rc2
  ashs 20170223
  minc 1.9.15
  heudiconv 0.3
  bids-validator 0.23.3
  dicom_retrieve.py
  
How to use the tools in the singularity image?

  step 0. install Linux(ubuntu/debian,CentOS,mint,...)
  
  step 1. install singularity:
	sudo bash 02.install_singularity_by_source_sudo.sh /opt
	or 
	bash 02.install_singularity_by_source_sudo.sh ~/app
	
  step 2. copy the neuroglia.img to your local(it's about 22G, freesurfer took ~14G)
  
  step 3. run the command you want:
  
	*usage 1: executing the command
		singularity exec /path/to/neuroglia.img <command_name>
	
		for example:
		
		if you want to run afni:
			singularity exec /path/to/neuroglia.img afni &
		
		if you want to run elastix:
			singularity exec /path/to/neuroglia.img elastix  -f ~/Downloads/1_fixed.mha -m ~/Downloads/1_moving_by_translation_30.mha -out ~/Downloads/ttt -p ~/Downloads/elastix_pars_affine.txt 
			(note: ~/Downloads is the host path. YES! you can see host $HOME when you exec a command in the container)
			
		if you want to run dicom_retrieve.py:
			singularity exec -B /mnt/hgfs/data:/data /path/to/neuroglia.img dicom_retrieve.py /data/7T_BIDS_patientID_list.txt /data/output/dicom/ UWO_USERNAME UWO_PASSWORD
			note: 
			-B(or --bind) will mapping your local(/mnt/hgfs/data) into the container(/data), thereafter, all operation with /data is actually /mnt/hgfs/data
						
		if you want to run heudiconv
			singularity exec -B /mnt/hgfs/data:data /path/to/neuroglia.img heudiconv -b -d /data/7T_BIDS/dicoms/{subject}/*.IMA -s 001 -f /data/7T_BIDS/7T_TOPSY_BIDS_heuristic.py -c dcm2niix -b -o /data/output

	*usage 2: shell into the container: 	singularity shell /path/to/neuroglia.img
		you will get a prompt like this: Singularity neuroglia.img:~/test>
		NOTE: When you shell into the Singularity container, you can still see your home.
				
		if you want to run afni:
			afni &		
			
		if you want to run elastix:
			cd elastix_registration project
			(note: the full path is: /home/ylu/elastix_registration_project)
			elastix  -f 1_fixed.mha -m 1_moving_by_translation_30.mha -out ./ttt -p elastix_pars_affine.txt 

    summary: usage 1 is good for executing the command in a script, ussage 2 is good for interacive.
	
