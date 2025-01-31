#!/usr/bin/env bash

#SBATCH --cpus-per-task=20
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=MAKER_merge
#SBATCH --output=/data/users/tschiller/annotation_course/logs/%j_output_MERGE_MAKER.o
#SBATCH --error=/data/users/tschiller/annotation_course/logs/%j_error_MERGE_MAKER.e
#SBATCH --partition=pibu_el8


WORKDIR=/data/users/tschiller/annotation_course
cd $WORKDIR
COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"

MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
$MAKERBIN/gff3_merge -s -d assembly.maker.output/assembly_master_datastore_index.log > assembly.all.maker.gff
$MAKERBIN/gff3_merge -n -s -d assembly.maker.output/assembly_master_datastore_index.log >assembly.all.maker.noseq.gff
$MAKERBIN/fasta_merge -d assembly.maker.output/assembly_master_datastore_index.log -o assembly
