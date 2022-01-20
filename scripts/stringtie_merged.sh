#!/bin/bash

#SBATCH --job-name=stringtie_merged.sh
#SBATCH --error=ERR_stringtie_merged.err
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=01:00:00
#SBATCH --mem=1G

#manual: http://ccb.jhu.edu/software/stringtie/index.shtml?t=manual
##this step is to merge all .gtf files into one 

#define file directory and reference annotation as variables 
file_directory=(/data/courses/rnaseq/lncRNAs/Project2/lbrun/03transcriptome_assembly/stringtie_output/*.gtf)
reference_annotation='/data/courses/rnaseq/lncRNAs/Project2/lbrun/03transcriptome_assembly/gencode.v38.annotation.gtf'

#add stringtie module
module add UHTS/Aligner/stringtie/1.3.3b;

#performe stringtie with given variables
stringtie -o stringtie_output/merged_all.gtf --merge -G $reference_annotation $file_directory

