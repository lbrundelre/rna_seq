#!/bin/bash

#SBATCH --job-name=transcriptome_assembly.sh
#SBATCH --error=ERR_transcriptome_assembly.err
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=00:30:00
#SBATCH --mem-per-cpu=10G
#SBATCH --array=0-11

##assembles bam files to reference transcriptome
#manual: http://ccb.jhu.edu/software/stringtie/index.shtml?t=manual

#create output folder
mkdir stringtie_output

#define path to reference annotation and to bam files respectivly
reference_annotation='/data/courses/rnaseq/lncRNAs/Project2/lbrun/03transcriptome_assembly/gencode.v38.annotation.gtf'
file=(/data/courses/rnaseq/lncRNAs/Project2/lbrun/02read_mapping/STAR_output/*.bam)

#add stringtie module
module add UHTS/Aligner/stringtie/1.3.3b;

#performe stringtie as an array job to run it over every bam file with the same parameters
stringtie -o stringtie_output/${SLURM_ARRAY_TASK_ID}.gtf --rf -G $reference_annotation ${file[$SLURM_ARRAY_TASK_ID]}
