#!/usr/bin/env bash

#SBATCH --cpus-per-task=20
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=OMAmer
#SBATCH --output=/data/users/tschiller/annotation_course/logs/%j_output_OMAmer.o
#SBATCH --error=/data/users/tschiller/annotation_course/logs/%j_error_OMAmer.e
#SBATCH --partition=pibu_el8

eval "$(/home/amaalouf/miniconda3/bin/conda shell.bash hook)"

conda activate OMArk
cd /data/users/tschiller/annotation_course
wget https://omabrowser.org/All/LUCA.h5
omamer search --db LUCA.h5 --query /data/users/tschiller/annotation_course/final/assembly.all.maker.proteins.fasta.renamed.fasta --out /data/users/tschiller/annotation_course/final/assembly.all.maker.proteins.fasta.renamed.fasta.omamer