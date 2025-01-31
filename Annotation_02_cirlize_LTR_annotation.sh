#!/usr/bin/env bash

#SBATCH --cpus-per-task=60
#SBATCH --mem-per-cpu=10G
#SBATCH --time=20:00:00
#SBATCH --partition=pibu_el8
#SBATCH --job-name=EDTA
#SBATCH --output=/data/users/tschiller/annotation_try2/logs/%j_circlize.o
#SBATCH --error=/data/users/tschiller/annotation_try2/logs/%j_circlize.e
#SBATCH --exclude=binfservas19,binfservas37
WORKDIR=/data/users/tschiller/assembly_course/assemblies/LJA

cd $WORKDIR
module load SAMtools/1.13-GCC-10.3.0

samtools faidx assembly.fasta

module load R/4.2.1-foss-2021a  
Rscript /data/users/tschiller/annotation_try2/scripts/circlize_ltrannotation.R