#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=flye
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/tschiller/assembly_course/logs/flye_output_%j.o
#SBATCH --error=/data/users/tschiller/assembly_course/logs/flye_error_%j.e


OUT_DIR=/data/users/tschiller/assembly_course/assemblies/flye_assembly
IN_FILE=/data/users/tschiller/assembly_course/cleaned_data/ERR11437326.fastq.gz

export APPTAINER_TMPDIR=/data/users/tschiller
export APPTAINER_CACHEDIR=/data/users/tschiller
export APPTAINER_BIND=/data

apptainer exec /containers/apptainer/flye_2.9.5.sif flye --pacbio-hifi $IN_FILE --genome-size 129m --threads 16 --out-dir $OUT_DIR --read-error 0.177