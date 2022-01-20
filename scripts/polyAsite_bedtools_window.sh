#!/bin/bash

#SBATCH --job-name=polyAsite_bedtools_window.sh
#SBATCH --output=/data/courses/rnaseq/lncRNAs/Project2/lbrun/06integrative_analysis_prep/polyAsite_transcripts.txt
#SBATCH --error=Err_polyAsite_bedtools_window.err
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=01:00:00
#SBATCH --mem=10G

##https://bedtools.readthedocs.io/en/latest/content/tools/window.html?highlight=window
#use this to find overlapping RNA, in this context: compare with known RNA polyAsites (=atlas.clusters)
#atlas.clusters file was downloaded from here: https://polyasite.unibas.ch/atlas
#use -sm option: only reports variants which overlap on same strand
#use -w option:Base pairs added upstream and downstream of each entry in A when searching for overlaps in B. Default is 1000 bp

#add BEDTools module
module add UHTS/Analysis/BEDTools/2.29.2;

#define path to input files as variables
reference=/data/courses/rnaseq/lncRNAs/Project2/lbrun/06integrative_analysis_prep/atlas.clusters.2.0.GRCh38.96.bed.gz
in_file=/data/courses/rnaseq/lncRNAs/Project2/lbrun/06integrative_analysis_prep/merged_all.bed

#unzip reference file and redirect it
gunzip < $reference > reference.bed

#perform bedtool window
bedtools window -w 100 -sm -a $in_file -b reference.bed

#remove redirected reference file
rm reference.bed
