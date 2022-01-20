#!/bin/bash

#SBATCH --job-name=quality_control_multiqc
#SBATCH --error=quality_control_multiqc.err
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --mem=1G

###make a multi quality control with all fastqc files

#add multiqc module
module add UHTS/Analysis/MultiQC/1.8;

#perform multiqc with every file in fastqc folder
multiqc fastqc
