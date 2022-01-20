#!/bin/bash

#SBATCH --job-name=TSS_bedtools_window
#SBATCH --output=/data/courses/rnaseq/lncRNAs/Project2/lbrun/06integrative_analysis_prep/TSS_transcripts.txt
#SBATCH --error=Err_TSS_bedtools_window.err
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=01:00:00
#SBATCH --mem=10G

#https://bedtools.readthedocs.io/en/latest/content/tools/window.html?highlight=window
##use this to find overlapping RNAs, in this context: compare with known RNA start sites (=TSS_human file)
#TSS_human file was downloaded from here:https://dbarchive.biosciencedbc.jp/data/fantom5/datafiles/phase1.3/extra/TSS_classifier/
#-w option:Base pairs added upstream and downstream of each entry in A when searching for overlaps in B. Default is 1000 bp
#add BEDTools module
module add UHTS/Analysis/BEDTools/2.29.2;

#define input files as variables
reference=/data/courses/rnaseq/lncRNAs/Project2/dschaer/6_1CAGEr/TSS_human.bed.gz
in_file=/data/courses/rnaseq/lncRNAs/Project2/lbrun/06integrative_analysis_prep/merged_all.bed

#unzip reference file and redirect it
gunzip < $reference > reference.bed

#perform bedtools window
bedtools window -w 100 -a $in_file -b reference.bed

#remove redirected reference file
rm reference.bed
