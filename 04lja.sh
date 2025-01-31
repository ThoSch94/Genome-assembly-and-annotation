#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=lja
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/tschiller/assembly_course/logs/lja_output_%j.o
#SBATCH --error=/data/users/tschiller/assembly_course/logs/lja_error_%j.e


apptainer exec /containers/apptainer/lja-0.2.sif lja -t 16 -o /data/users/tschiller/assembly_course/assemblies/LJA --reads /data/users/tschiller/assembly_course/cleaned_data/ERR11437326.fastq.gz --diploid