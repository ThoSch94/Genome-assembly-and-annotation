#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=5G
#SBATCH --time=20:00:00
#SBATCH --partition=pibu_el8
#SBATCH --job-name=quast
#SBATCH --output=/data/users/tschiller/assembly_course/logs/quast_output_%j.o
#SBATCH --error=/data/users/tschiller/assembly_course/logs/quast_error_%j.e
apptainer exec --bind /data/courses/assembly-annotation-course/references/ /containers/apptainer/quast_5.2.0.sif quast.py $WORKDIR/data/users/tschiller/assembly_course/assemblies/flye_assembly/assembly.fasta $WORKDIR/data/users/tschiller/assembly_course/assemblies/LJA/assembly.fasta $WORKDIR/data/users/tschiller/assembly_course/assemblies/hifiasm/hifi_asm.fa -o quast_results --labels flye,lja,hifiasm --features /data/courses/assembly-annotation-course/references/TAIR10_GFF3_genes.gff -e -r /data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa --pacbio $WORKDIR/data/users/tschiller/assembly_course/cleaned_data/ERR11437326.fastq.gz