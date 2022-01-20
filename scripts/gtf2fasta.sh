#!/bin/bash

##BATCH --job-name=gtf_to_fasta.sh
#SBATCH --error=ERR_gtf_to_fasta.err
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=00:10:00
#SBATCH --mem=1G

##transforms merged gtf file to fasta file using a reference genome
#manual: http://ccb.jhu.edu/software/stringtie/gff.shtml
#merged_all.fa is created

#define path to input file as variable
genome='/data/courses/rnaseq/lncRNAs/Project2/references/genome_sequence/GRCh38.primary_assembly.genome.fa.gz'
gtf_file='/data/courses/rnaseq/lncRNAs/Project2/lbrun/03transcriptome_assembly/stringtie_output/merged_all.gtf'

#add cufflinks module
module add UHTS/Assembler/cufflinks/2.2.1;

#unzip genome and redirect it
gunzip < $genome > genome.fa

#perform gffread on gtf file
gffread -w merged_all.fa -g genome.fa $gtf_file

#remove redirected genome variable
rm genome.fa
