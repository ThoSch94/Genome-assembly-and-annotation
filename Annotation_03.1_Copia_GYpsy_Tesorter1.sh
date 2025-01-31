#!/usr/bin/env bash

#SBATCH --cpus-per-task=20
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=MAKER_Config
#SBATCH --output=/data/users/tschiller/annotation_course/logs/output_tesort_seq2_%j.o
#SBATCH --error=/data/users/tschiller/annotation_course/logs/error_tesort_seq2_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/tschiller/annotation_course/fucked_output/annotate_TEs_1_EDTA
cd $WORKDIR

apptainer exec -C -H $WORKDIR -H ${pwd}:/work --writable-tmpfs -u
/data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif TEsorter Copia_sequences.fa -db rexdb-plant
apptainer exec -C -H $WORKDIR -H ${pwd}:/work --writable-tmpfs -u
/data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif TEsorter Gypsy_sequences.fa -db rexdb-plant
