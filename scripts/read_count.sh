#!/bin/bash

#SBATCH --job-name=read_count
#SBATCH --error=read_count.err
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --mem=1000

###counts reads of every fastq file

#create output directory
mkdir read_count

#change folder with fastq files
cd ../../fastq;

#for every file in this folder look for certain, count how many times this pattern occurs in a file and write it to new file in specified folder
for i in `ls`; do
zcat $i | awk '$1=="+"' | wc -l >> ../lbrun/01read_quality/read_count/read_count_${i}.txt; done

