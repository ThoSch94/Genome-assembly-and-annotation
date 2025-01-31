#!/usr/bin/env bash

#SBATCH --cpus-per-task=20
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=parseRM
#SBATCH --output=/data/users/tschiller/annotation_try2/logs/%j_output_parseRM.o
#SBATCH --error=/data/users/tschiller/annotation_try2/logs/%j_error_parseRM.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/tschiller/annotation_try2/outputs/edta/assembly.fasta.mod.EDTA.anno
cd $WORKDIR



module add BioPerl/1.7.8-GCCcore-10.3.0
perl /data/users/tschiller/annotation_course/scripts/parseRM.pl -i assembly.fasta.mod.out -l 50,1 -v

module load R/4.2.1-foss-2021a  
Rscript /data/users/tschiller/annotation_try2/scripts/plot_div.R