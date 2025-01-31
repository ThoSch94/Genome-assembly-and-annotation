#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=40G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=jellyfish
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/tschiller/assembly_course/logs/fastp_output_%j.o
#SBATCH --error=/data/users/tschiller/assembly_course/logs/fastp_error_%j.e

module load Jellyfish/2.3.0-GCC-10.3.0
cd /data/users/tschiller/assembly_course/cleaned_data/
jellyfish count -C -m 21 -s 5000000000 -t 4  -o reads.jf <(zcat /data/users/tschiller/assembly_course/cleaned_data/ERR11437326.fastq.gz)

jellyfish histo -t 10 reads.jf > reads.histo