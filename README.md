Forked version of Neuroglia with vasst-dev additions

# Currently deployed at on graham at:  /project/6007967/akhanf/singularity

# Singularity hub version under construction, to build your own, use: make build

# Wrappers:

*  neuroglia <command to run>
Wrapper for singularity exec. To use, set the following environment variables in your .bashrc:
```
SINGULARITY_IMG=<location of singularity container>
SINGULARITY_OPTS=<options for singularity exec>
```

* neurogliaBatch <script/exec-name> <subjlist> <opt args>
Wrapper to submit jobs on graham. Will loop over subjlist and submit jobs (8core,32G,24h) for each as:
neuroglia <script/exec-name> <opt args> <subj i>


To use on graham, add the following lines to your ~/.bash_profile:
```
export PATH=<location of this folder>:$PATH
SINGULARITY_IMG=/project/6007967/akhanf/singularity/khanlab_neuroglias-vasst-dev_0.0.1d.img   # can modify to update version 
SINGULARITY_OPTS="-B /project:/project"
```


