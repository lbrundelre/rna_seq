#!/bin/bash

#SBATCH --job-name=quantification_kallisto.sh
#SBATCH --error=ERR_quantification_kallisto.err
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=01:00:00
#SBATCH --mem=20G
#SBATCH --array=0-11

##kallisto uses index file to quantify each fastq file
#manual: https://pachterlab.github.io/kallisto/manual

#define path to input files as variable
index_file='/data/courses/rnaseq/lncRNAs/Project2/lbrun/04quantification/index_merged_all'
forward_read=(/data/courses/rnaseq/lncRNAs/Project2/fastq/*R1*)
reverse_read=(/data/courses/rnaseq/lncRNAs/Project2/fastq/*R2*)

#create output folder
mkdir output_quantification

#add kallisto module
module add UHTS/Analysis/kallisto/0.46.0

#perform kallisto quantification as array job for different inputs with same parameters
kallisto quant -i $index_file -o output_quantification/$SLURM_ARRAY_TASK_ID/ --rf-stranded ${forward_read[SLURM_ARRAY_TASK_ID]} ${reverse_read[SLURM_ARRAY_TASK_ID]} -b 20
