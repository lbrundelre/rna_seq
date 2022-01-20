#!/bin/bash

#SBATCH --job-name=coding_potential_CPAT
#SBATCH --error=Err_coding_potential_CPAT.err
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=01:00:00
#SBATCH --mem=10G

##find protein coding transcripts with CPAT
#manual: https://cpat.readthedocs.io/en/latest/
#Human_Hexamer.tsv and Human_lgitModel.RData is found on this website (https://sourceforge.net/projects/rna-cpat/files/v1.2.4/) and must be downloaded to working folder
#outputs .dat file which can be used in given R code

#add cpat module
module add SequenceAnalysis/GenePrediction/cpat/1.2.4

#define path to input as variable
GENE_FILE=/data/courses/rnaseq/lncRNAs/Project2/lbrun/04quantification/merged_all.fa

#perform cpat
cpat.py -g $GENE_FILE -x Human_Hexamer.tsv -d Human_logitModel.RData -o coding_potential

