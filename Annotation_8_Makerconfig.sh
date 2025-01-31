#!/usr/bin/env bash

#SBATCH --cpus-per-task=20
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=MAKER_Config
#SBATCH --output=/data/users/tschiller/annotation_course/logs/%j_output_MAKERconfig.o
#SBATCH --error=/data/users/tschiller/annotation_course/logs/%j_error_MAKERconfig.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/tschiller/annotation_course
#cd $WORKDIR
#mkdir -p gene_annotation
cd /data/users/tschiller/annotation_course/gene_annotation

apptainer exec --bind $WORKDIR \
/data/courses/assembly-annotation-course/containers2/MAKER_3.01.03.sif maker -CTL \
