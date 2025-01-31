#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=trinity
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/tschiller/assembly_course/logs/trinity_output_%j.o
#SBATCH --error=/data/users/tschiller/assembly_course/logs/trinity_error_%j.e

module load Trinity/2.15.1-foss-2021a
Trinity --seqType fq --left /data/users/tschiller/assembly_course/cleaned_data/ERR754081_1.fastq.gz --right /data/users/tschiller/assembly_course/cleaned_data/ERR754081_2.fastq.gz --CPU 16 --max_memory 64G 