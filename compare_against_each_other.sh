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
MY_LJA=/data/users/tschiller/assembly_course/assemblies/LJA/assembly.fasta
RESULTDIR=/data/users/tschiller/assembly_course/eval/genomes_comparison/comparing_against_each_other

julian_flye=/data/users/tschiller/assembly_course/eval/genomes_comparison/genome_julian/flye.fasta
laura_flye=/data/users/tschiller/assembly_course/eval/genomes_comparison/genome_laura/flye.fasta
hector_flye=/data/users/tschiller/assembly_course/eval/genomes_comparison/genome_hector/flye.fasta
mkdir -p $RESULTDIR
cd $RESULTDIR
#nucmer
#apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif nucmer --prefix julian --breaklen 1000 --mincluster 1000 --threads $cpus $MY_LJA $julian_flye 

#apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif nucmer --prefix laura --breaklen 1000 --mincluster 1000 --threads $cpus $MY_LJA $laura_flye 

#apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif nucmer --prefix hector --breaklen 1000 --mincluster 1000 --threads $cpus $MY_LJA $hector_flye 

#apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif nucmer --prefix reda --breaklen 1000 --mincluster 1000 --threads $cpus $MY_LJA $LJA 

#apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif nucmer --prefix hans --breaklen 1000 --mincluster 1000 --threads $cpus $MY_LJA $LJA 
#mummer
apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $MY_LJA -Q $julian_flye -breaklen 1000 --filter -t png --large --layout --fat -p $RESULTDIR/julian  julian.delta

apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $MY_LJA -Q $laura_flye -breaklen 1000 --filter -t png --large --layout --fat -p $RESULTDIR/laura  laura.delta

apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $MY_LJA -Q $hector_flye -breaklen 1000 --filter -t png --large --layout --fat -p $RESULTDIR/hector  hector.delta

#apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $MY_LJA -Q $LJA -breaklen 1000 --filter -t png --large --layout --fat -p $RESULTDIR/reda  reda.delta
#apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $MY_LJA -Q $LJA -breaklen 1000 --filter -t png --large --layout --fat -p $RESULTDIR/hans  hans.delta