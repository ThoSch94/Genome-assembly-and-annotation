#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=5G
#SBATCH --time=20:00:00
#SBATCH --partition=pibu_el8
#SBATCH --job-name=busco
#SBATCH --output=/data/users/tschiller/assembly_course/logs/busco_output_%j.o
#SBATCH --error=/data/users/tschiller/assembly_course/logs/busco_error_%j.e

module load BUSCO/5.4.2-foss-2021a
genome1=/data/users/tschiller/assembly_course/assemblies/flye_assembly/assembly.fasta
genome2=/data/users/tschiller/assembly_course/assemblies/hifiasm/hifi_asm.fa
genome3=/data/users/tschiller/assembly_course/assemblies/LJA/assembly.fasta
transcriptome=/data/users/tschiller/assembly_course/assemblies/trinity/trinity_out_dir.Trinity.fasta
busco -i $genome1 -m genome --cpu 32 --lineage brassicales_odb10 --out busco_flye --out_path /data/users/tschiller/assembly_course/eval/merqury_eval -f
busco -i $genome2 -m genome --cpu 32 --lineage brassicales_odb10 --out busco_hifiasm --out_path /data/users/tschiller/assembly_course/eval/merqury_eval -f
busco -i $genome3 -m genome --cpu 32 --lineage brassicales_odb10 --out busco_LJA --out_path /data/users/tschiller/assembly_course/eval/merqury_eval -f
busco -i $genome1 -m transcriptome --cpu 32 --lineage brassicales_odb10
