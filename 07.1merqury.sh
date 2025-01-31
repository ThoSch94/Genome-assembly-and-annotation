#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=2G
#SBATCH --time=20:00:00
#SBATCH --partition=pibu_el8
#SBATCH --job-name=merq
#SBATCH --output=/data/users/tschiller/assembly_course/logs/merq_output_%j.o
#SBATCH --error=/data/users/tschiller/assembly_course/logs/merq_error_%j.e

#sh /data/users/tschiller/assembly_course/best_k.sh 130000000
#genome: 130000000
#tolerable collision rate: 0.001
#18.4591

# Define MERQURY environment variable
export MERQURY="/usr/local/share/merqury"
apptainer exec /containers/apptainer/merqury_1.3.sif bash /data/users/tschiller/assembly_course/run_merq.sh read_db.meryl /data/users/tschiller/assembly_course/assemblies/flye_assembly/assembly.fasta merqu_flye

