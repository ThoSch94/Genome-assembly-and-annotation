#!/usr/bin/env bash

#SBATCH --cpus-per-task=60
#SBATCH --mem-per-cpu=10G
#SBATCH --time=20:00:00
#SBATCH --partition=pibu_el8
#SBATCH --job-name=EDTA
#SBATCH --output=/data/users/tschiller/annotation_try2/logs/%j_LTR-RTs.o
#SBATCH --error=/data/users/tschiller/annotation_try2/logs/%j_LTR-RTs.e
#SBATCH --exclude=binfservas19,binfservas37

cd /data/users/tschiller/annotation_try2/scripts
./Annotation_01.1.1_TEsorter.sh

module load R/4.2.1-foss-2021a  

Rscript /data/users/tschiller/annotation_try2/scripts/full_length_LTRs_identity.R