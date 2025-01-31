#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=hifiasm
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/tschiller/assembly_course/logs/hifiasm_output_%j.o
#SBATCH --error=/data/users/tschiller/assembly_course/logs/hifiasm_error_%j.e

apptainer exec /containers/apptainer/hifiasm_0.19.8.sif hifiasm -o /data/users/tschiller/assembly_course/assemblies/hifiasm/genome_hifiasm.bp.p_ctg.gfa -t 16 /data/users/tschiller/assembly_course/cleaned_data/ERR11437326.fastq.gz
#awk '/^S/{print ">"$2;print $3}' FILE.gfa > FILE.fa