#!/bin/bash

#SBATCH --job-name=indexing_kallisto.sh
#SBATCH --error=ERR_indexing_kallisto.err
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=01:00:00
#SBATCH --mem=10G

##indexes merged fasta file
#manual: https://pachterlab.github.io/kallisto/manual
#outputs index_merged_all.fa.fai

#define path to fasta input file as variable
FASTA_file='/data/courses/rnaseq/lncRNAs/Project2/lbrun/04quantification/merged_all.fa'

#add kallisto module
module add UHTS/Analysis/kallisto/0.46.0;

#perform kallisto index on fasta file
kallisto index $FASTA_file -i index_merged_all

