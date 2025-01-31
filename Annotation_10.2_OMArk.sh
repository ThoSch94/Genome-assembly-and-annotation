#!/usr/bin/env bash

#SBATCH --cpus-per-task=20
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=omark
#SBATCH --output=/data/users/tschiller/annotation_course/logs/%j_output_omark.o
#SBATCH --error=/data/users/tschiller/annotation_course/logs/%j_error_omark.e
#SBATCH --partition=pibu_el8

eval "$(/home/amaalouf/miniconda3/bin/conda shell.bash hook)"

conda activate OMArk

omark -f /data/users/tschiller/annotation_course/final/assembly.all.maker.proteins.fasta.renamed.fasta.omamer -of /data/users/tschiller/annotation_course/final/assembly.all.maker.proteins.fasta.renamed.fasta -i /data/users/tschiller/annotation_course/logs/13575146_output_OMArk_prep.o -d /data/users/tschiller/annotation_course/LUCA.h5 -o /data/users/tschiller/annotation_course/final/omark_output