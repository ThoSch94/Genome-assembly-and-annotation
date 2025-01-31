#!/usr/bin/env bash

#SBATCH --cpus-per-task=20
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=blastP
#SBATCH --output=/data/users/tschiller/annotation_course/logs/%j_output_blastP.o
#SBATCH --error=/data/users/tschiller/annotation_course/logs/%j_error_blastP.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/tschiller/annotation_course/final
cd $WORKDIR
mkdir -p blastp

protein="assembly.all.maker.proteins.fasta.renamed.filtered.fasta"
uniprot="/data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa"


module load BLAST+/2.15.0-gompi-2021a

blastp -query ${protein} -db /data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa -num_threads 10 -outfmt 6  -evalue 1e-10 -out blastp.txt

