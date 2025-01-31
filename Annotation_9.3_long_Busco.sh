#!/usr/bin/env bash

#SBATCH --cpus-per-task=20
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=BUSCO
#SBATCH --output=/data/users/tschiller/annotation_course/logs/%j_output_BUSCO.o
#SBATCH --error=/data/users/tschiller/annotation_course/logs/%j_error_BUSCO.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/tschiller/annotation_course/final"
cd $WORKDIR


module load BUSCO/5.4.2-foss-2021a
busco -f -i /data/users/tschiller/annotation_course/final/longest_proteins.fasta -l brassicales_odb10 -o busco_output_protein -m proteins
busco -f -i /data/users/tschiller/annotation_course/final/longest_transcripts.fasta -l brassicales_odb10 -o busco_output_trans -m transcriptome
