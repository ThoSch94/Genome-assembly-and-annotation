#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=genome_comp
#SBATCH --output=/data/users/tschiller/assembly_course/logs/output_genome_comp_%j.o
#SBATCH --error=/data/users/tschiller/assembly_course/logs/error_genome_comp_%j.e
#SBATCH --partition=pibu_el8

cpus=16
WORKDIR=/data/users/tschiller/assembly_course
REF=/data/users/tschiller/assembly_course/ref_genome/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
FLYE=/data/users/tschiller/assembly_course/assemblies/flye_assembly/assembly.fasta
HIFIASM=/data/users/tschiller/assembly_course/assemblies/hifiasm/hifi_asm.fa
LJA=/data/users/tschiller/assembly_course/assemblies/LJA/assembly.fasta
RESULTDIR=/data/users/tschiller/assembly_course/genomes_comparison
mkdir -p $RESULTDIR
cd $RESULTDIR
#nucmer
apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif nucmer --prefix genome_flye --breaklen 1000 --mincluster 1000 --threads $cpus $REF $FLYE 

apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif nucmer --prefix genome_hifiasm --breaklen 1000 --mincluster 1000 --threads $cpus $REF $HIFIASM 

apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif nucmer --prefix genome_LJA --breaklen 1000 --mincluster 1000 --threads $cpus $REF $LJA 

#mummer
apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $REF -Q $FLYE -breaklen 1000 --filter -t png --large --layout --fat -p $RESULTDIR/flye  genome_flye.delta

apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $REF -Q $HIFIASM -breaklen 1000 --filter -t png --large --layout --fat -p $RESULTDIR/hifiasm  genome_hifiasm.delta

apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $REF -Q $LJA -breaklen 1000 --filter -t png --large --layout --fat -p $RESULTDIR/LJA  genome_LJA.delta
