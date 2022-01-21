#!/bin/bash

#SBATCH --job-name=gtf2bed
#SBATCH --error=Err_gtf2bed.err
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=01:00:00
#SBATCH --mem=10G

##transform merged gtf file (created in step 3 transcriptome assembly) to bed file to use it as input file for bedtool window analysis

#this script is used to convert two files into a bed file. Use '#' to use the other option

#add bedops module
module add UHTS/Analysis/bedops/2.4.40

##Option 1: 

#define path to gtf input file as variable
#in_file=/data/courses/rnaseq/lncRNAs/Project2/lbrun/03transcriptome_assembly/stringtie_output/merged_all.gtf

#perform gtf2bed
#gtf2bed < $in_file > merged_all.bed


##Option 2:
#define path to variable
in_file=/data/courses/rnaseq/lncRNAs/Project2/references/annotations/gencode.v38.annotation.gtf

#perform gtf2bed
gtf2bed < $in_file > genecode.v38.annotation.bed

