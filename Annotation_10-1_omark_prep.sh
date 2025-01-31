#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=prep
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/tschiller/annotation_course/logs/%j_output_OMArk_prep.o
#SBATCH --error=/data/users/tschiller/annotation_course/logs/%j_error_OMArk_prep.e

input_file=/data/users/tschiller/annotation_course/final/assembly.all.maker.proteins.fasta.renamed.filtered.fasta.fai

# Read the file and process isoforms
awk '{
    # Split the first column by "-"
    split($1, arr, "-");
    prefix = arr[1];

    # Append the full identifier to the list for this prefix
    isoforms[prefix] = (isoforms[prefix] ? isoforms[prefix] ";" $1 : $1);
} END {
    # Print each prefix and its associated isoforms
    for (p in isoforms) {
        print isoforms[p];
    }
}' "$input_file"
