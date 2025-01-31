#!/bin/bash
#SBATCH --cpus-per-task=20
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=Genespace
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/tschiller/annotation_try2/logs/%j_genespace.out
#SBATCH --error=/data/users/tschiller/annotation_try2/logs/%j_genespace.err

COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
WORKDIR="/data/users/tschiller/annotation_course/final"

apptainer exec \
    --bind $COURSEDIR \
    --bind $WORKDIR \
    --bind $SCRATCH:/temp \
    $COURSEDIR/containers/genespace_latest.sif Rscript /data/users/tschiller/annotation_try2/scripts/Genespace.R /data/users/tschiller/annotation_course/final/genespace

# apptainer shell \
#     --bind $COURSEDIR \
#     --bind $WORKDIR \
#     --bind $SCRATCH:/temp \
#     $COURSEDIR/containers/genespace_latest.sif