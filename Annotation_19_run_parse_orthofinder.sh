#!/usr/bin/env bash
#SBATCH --job-name=parse_ortho
#SBATCH --output=/data/users/tschiller/annotation_try2/logs/%j_parse_ortho.o
#SBATCH --error=/data/users/tschiller/annotation_try2/logs/%j_parse_ortho.e
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=20   # Adjust based on available resources
#SBATCH --mem=64G           # Adjust memory requirements
#SBATCH --time=7:00:00     # Adjust time as needed
 

WORKDIR=/data/users/tschiller/annotation_course/final/genespace/orthofinder/Results_Jan29/
cd $WORKDIR
module load R/4.2.1-foss-2021a  

Rscript /data/users/tschiller/annotation_try2/scripts/parse_Orthofinder.R