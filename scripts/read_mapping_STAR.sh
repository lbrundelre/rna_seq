#!/bin/bash

#SBATCH --job-name=read_mapping_STAR.sh
#SBATCH --error=ERR_read_mapping.err
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=01:00:00
#SBATCH --mem=40G

##maps reads to reference genome and outputs bam files sorted by coordinates
#manual: https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf

#give arguments in command line when executing this script in the following order:
#$1 = forward read 
#$2 = reverse read
#$3 = name of created files

#create ouput folder
mkdir STAR_output;

#define path to genome as variable
genome='/data/courses/rnaseq/lncRNAs/Project2/references/star_genome/'

#add STAR module
module add UHTS/Aligner/STAR/2.7.9a;

#perform STAR with specified arguments and variables from inside and outside
STAR --runThreadN 4 --genomeDir $genome --readFilesIn /data/courses/rnaseq/lncRNAs/Project2/fastq/$1 /data/courses/rnaseq/lncRNAs/Project2/fastq/$2 --readFilesCommand zcat --outSAMtype BAM SortedByCoordinate --outFileNamePrefix ./STAR_output/$3
