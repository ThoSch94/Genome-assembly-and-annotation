#!/usr/bin/env bash

#SBATCH --cpus-per-task=60
#SBATCH --mem-per-cpu=10G
#SBATCH --time=20:00:00
#SBATCH --partition=pibu_el8
#SBATCH --job-name=EDTA
#SBATCH --output=/data/users/tschiller/annotation_try2/logs/%j_EDTA.o
#SBATCH --error=/data/users/tschiller/annotation_try2/logs/%j_EDTA.e
#SBATCH --exclude=binfservas19,binfservas37
#!/usr/bin/env bash

echo `date` # for tracking in logfiles

# load modules


# set variables
WORKDIR=/data/users/tschiller/annotation_try2
ASSEMBLY=/data/users/tschiller/annotation_try2/assembly.fasta
CDS_FILE=/data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10_cds_20110103_representative_gene_model_updated
EDTA_PL=/data/users/amaalouf/transcriptome_assembly/annotation/output/EDTA_git/EDTA.pl
#apptainer exec -C -H $WORKDIR -H ${pwd}:/work \
#--writable-tmpfs -u $IMAGE \
cd $WORKDIR
mkdir -p ./outputs_try2/edta
#/data/users/okopp/assembly_annotation_course/scripts/EDTA/EDTA.pl
cd outputs_try2/edta

perl /data/users/amaalouf/transcriptome_assembly/annotation/output/EDTA_git/EDTA.pl --genome $ASSEMBLY --species others --step all --cds "/data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10_cds_20110103_representative_gene_model_updated" --anno 1 --threads 21


#apptainer exec -C -H $(pwd):/work \
# --writable-tmpfs $IMAGE \
# EDTA.pl \
# --genome $ASSEMBLY \
# --species others \
# --step all \
# --cds "/data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10_cds_20110103_representative_gene_model_updated" \
# --anno 1 \
#  --threads 60