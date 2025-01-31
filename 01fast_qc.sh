#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=40G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=fastp
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/tschiller/assembly_course/logs/fastp_output_%j.o
#SBATCH --error=/data/users/tschiller/assembly_course/logs/fastp_error_%j.e

export APPTAINER_TMPDIR=/data/users/tschiller
export APPTAINER_CACHEDIR=/data/users/tschiller
export APPTAINER_BIND=/data


WORKDIR=/data/users/tschiller/assembly_course/RRS10/
OUT_DIR=/data/users/tschiller/assembly_course/fast_qc_out/
data_file1=/data/users/tschiller/assembly_course/RNAseq_Sha/ERR754081_1.fastq.gz
data_file2=/data/users/tschiller/assembly_course/RNAseq_Sha/ERR754081_2.fastq.gz
data_file3=/data/users/tschiller/assembly_course/RRS10/ERR11437326.fastq.gz
/data/users/tschiller/assembly_course/helper_fast_qc.sh $OUT_DIR $data_file1 $data_file2 $data_file3

sbatch /data/users/tschiller/assembly_course/fastp.sh $data_file1 $data_file2 $data_file3

OUT_DIR=/data/users/tschiller/assembly_course/fast_qc_cleaned/
data_file1=assembly_course/cleaned_data/ERR754081_1.fastq.gz
data_file2=/data/users/tschiller/assembly_course/cleaned_data/ERR754081_2.fastq.gz
data_file3=/data/users/tschiller/assembly_course/cleaned_data/ERR11437326.fastq.gz
/data/users/tschiller/assembly_course/helper_fast_qc.sh $OUT_DIR $data_file1 $data_file2 $data_file3

