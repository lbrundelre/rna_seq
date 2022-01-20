#!/bin/bash

#SBATCH --job-name=quality_control_fastqc
#SBATCH --error=quality_control_fastqc.err
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --mem=1G


##perform fast quality control on all fasta files 

#create output folder
mkdir fastqc

#add fastqc module
module add UHTS/Quality_control/fastqc/0.11.9;

#change to folder containing the fastq files
cd ../../fastq; 

#for every file in folder perform fastqc and write output to specified folder
for i in `ls`; do fastqc -o ../lbrun/01read_quality/fastqc $i ; done

 
