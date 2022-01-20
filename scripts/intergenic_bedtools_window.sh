#!/bin/bash

#SBATCH --job-name=intergenic_bedtools_window.sh
#SBATCH --output=/data/courses/rnaseq/lncRNAs/Project2/lbrun/06integrative_analysis_prep/intergenic_transcripts.txt
#SBATCH --error=Err_intergenic_bedtools_window.err
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=01:00:00
#SBATCH --mem=10G

##https://bedtools.readthedocs.io/en/latest/content/tools/window.html?highlight=window
#use this to find overlapping RNA, in this context: compare with coding regions
#reference: genecode.V38.annotation.bed has labels for genes which are protein coding
#use -sm option: Only reports variants which overlap on same strand
#use -w option: Base pairs added upstream and downstream of each entry in A when searching for overlaps in B. Default is 1000 bp
#use -v option: Only report those entries in A that have no overlaps with B

#add BEDTools module
module add UHTS/Analysis/BEDTools/2.29.2;

#define path to input files as variables
reference=/data/courses/rnaseq/lncRNAs/Project2/dschaer/6_3Intergenic/gencode.v38.annotation.bed
in_file=/data/courses/rnaseq/lncRNAs/Project2/lbrun/06integrative_analysis_prep/merged_all.bed

#perform bedtool window
bedtools window -w 100 -sm -v -a $in_file -b $reference

