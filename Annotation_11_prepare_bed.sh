#!/usr/bin/env bash
#SBATCH --job-name=prepare_bed
#SBATCH --output=/data/users/tschiller/annotation_course/logs/%j_prepare_bed.o
#SBATCH --error=/data/users/tschiller/annotation_course/logs/%j_prepare_bed.e
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=20   # Adjust based on available resources
#SBATCH --mem=64G           # Adjust memory requirements
#SBATCH --time=7:00:00     # Adjust time as needed
 

WORKDIR=/data/users/tschiller/annotation_course/final
cd $WORKDIR
module load R/4.2.1-foss-2021a  
module load UCSC-Utils/448-foss-2021a 

Rscript /data/users/tschiller/annotation_course/tims_scripts/create_Genespace_folders.R

faSomeRecords genome1_peptide.fa genespace_genes.txt genespace/peptide/genome1.fa

cp /data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10.bed genespace/bed/
cp /data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10.fa genespace/peptide/