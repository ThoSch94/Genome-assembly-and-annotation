#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10G
#SBATCH --time=20:00:00
#SBATCH --partition=pibu_el8
#SBATCH --job-name=EDTA
#SBATCH --output=/data/users/tschiller/annotation_try2/logs/%j_phylo.o
#SBATCH --error=/data/users/tschiller/annotation_try2/logs/%j_phylo.e
#SBATCH --exclude=binfservas19,binfservas37

# Load necessary modules
module load SeqKit/2.6.1
module load Clustal-Omega/1.2.4-GCC-10.3.0
module load FastTree/2.1.11-GCCcore-10.3.0

# Set up working directories and files
WORKDIR=/data/users/tschiller/annotation_try2
FASTA_FILE=/data/users/tschiller/annotation_try2/outputs/edta/assembly.fasta.mod.EDTA.TElib.fa
BRASSICADB=/data/courses/assembly-annotation-course/CDS_annotation/data/Brassicaceae_repbase_all_march2019.fasta
OUTDIR=/data/users/tschiller/annotation_try2/results_TEsorter
RESULTDIR=/data/users/tschiller/annotation_try2/phylogenetic_analysis


# Step 1: Extract Copia and Gypsy sequences and run TEsorter
cd /data/users/tschiller/annotation_try2/results_TEsorter
seqkit grep -r -p "Copia" $FASTA_FILE > Copia_sequences.fa
seqkit grep -r -p "Gypsy" $FASTA_FILE > Gypsy_sequences.fa

apptainer exec --bind /data --writable-tmpfs -u /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif TEsorter Copia_sequences.fa -db rexdb-plant
apptainer exec --bind /data --writable-tmpfs -u /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif TEsorter Gypsy_sequences.fa -db rexdb-plant
apptainer exec --bind /data --writable-tmpfs -u /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif TEsorter $BRASSICADB -db rexdb-plant

# Step 2: Extract RT protein sequences for phylogenetic analysis
COPIA=/data/users/tschiller/annotation_try2/results_TEsorter/Copia_sequences.fa.rexdb-plant.dom.faa
GYPSY=/data/users/tschiller/annotation_try2/results_TEsorter/Gypsy_sequences.fa.rexdb-plant.dom.faa
BRASSICA=/data/users/tschiller/annotation_try2/results_TEsorter/Brassicaceae_repbase_all_march2019.fasta.rexdb-plant.dom.faa

# Generate lists and extract sequences for Gypsy, Copia, and Brassica
grep Ty3-RT $GYPSY > /data/users/tschiller/annotation_try2/phylogenetic_analysis/listG.txt
sed -i 's/>//' /data/users/tschiller/annotation_try2/phylogenetic_analysis/listG.txt
sed -i 's/ .\+//' /data/users/tschiller/annotation_try2/phylogenetic_analysis/listG.txt
seqkit grep -f /data/users/tschiller/annotation_try2/phylogenetic_analysis/listG.txt $GYPSY -o /data/users/tschiller/annotation_try2/phylogenetic_analysis/Gypsy_RT.fasta

grep Ty1-RT $COPIA > /data/users/tschiller/annotation_try2/phylogenetic_analysis/listC.txt
sed -i 's/>//' /data/users/tschiller/annotation_try2/phylogenetic_analysis/listC.txt
sed -i 's/ .\+//' /data/users/tschiller/annotation_try2/phylogenetic_analysis/listC.txt
seqkit grep -f /data/users/tschiller/annotation_try2/phylogenetic_analysis/listC.txt $COPIA -o /data/users/tschiller/annotation_try2/phylogenetic_analysis/Copia_RT.fasta

grep Ty3-RT $BRASSICA > /data/users/tschiller/annotation_try2/phylogenetic_analysis/list1.txt
sed -i 's/>//' /data/users/tschiller/annotation_try2/phylogenetic_analysis/list1.txt
sed -i 's/ .\+//' /data/users/tschiller/annotation_try2/phylogenetic_analysis/list1.txt
seqkit grep -f /data/users/tschiller/annotation_try2/phylogenetic_analysis/list1.txt $BRASSICA -o /data/users/tschiller/annotation_try2/phylogenetic_analysis/Brassica_Ty3_RT.fasta

grep Ty1-RT $BRASSICA > /data/users/tschiller/annotation_try2/phylogenetic_analysis/list2.txt
sed -i 's/>//' /data/users/tschiller/annotation_try2/phylogenetic_analysis/list2.txt
sed -i 's/ .\+//' /data/users/tschiller/annotation_try2/phylogenetic_analysis/list2.txt
seqkit grep -f /data/users/tschiller/annotation_try2/phylogenetic_analysis/list2.txt $BRASSICA -o /data/users/tschiller/annotation_try2/phylogenetic_analysis/Brassica_Ty1-RT.fasta

# step 3: Concatenate RTs from both Brassicaceae and Arabidopsis TEs into one fasta file.
cat /data/users/tschiller/annotation_try2/phylogenetic_analysis/Brassica_Ty1-RT.fasta /data/users/tschiller/annotation_try2/phylogenetic_analysis/Copia_RT.fasta > /data/users/tschiller/annotation_try2/phylogenetic_analysis/Copia_RT_all.fa
cat /data/users/tschiller/annotation_try2/phylogenetic_analysis/Brassica_Ty3_RT.fasta /data/users/tschiller/annotation_try2/phylogenetic_analysis/Gypsy_RT.fasta > /data/users/tschiller/annotation_try2/phylogenetic_analysis/Gypsy_RT_all.fa
# the following part fixes my accession header
sed -i 's/#.\+//' Copia_RT_all.fa
sed -i 's/:/_/g' Copia_RT_all.fa
sed -i 's/#.\+//' Gypsy_RT_all.fa
sed -i 's/:/_/g' Gypsy_RT_all.fa
# this part fixes the brass headers
sed -i 's/|.*//' Copia_RT_all.fa
sed -i 's/|.*//' Gypsy_RT_all.fa


clustalo -i /data/users/tschiller/annotation_try2/phylogenetic_analysis/Copia_RT_all.fa -o /data/users/tschiller/annotation_try2/phylogenetic_analysis/copia_prot_align.fasta
clustalo -i /data/users/tschiller/annotation_try2/phylogenetic_analysis/Gypsy_RT_all.fa -o /data/users/tschiller/annotation_try2/phylogenetic_analysis/gypsy_prot_align.fasta

# Step 4: Generate phylogenetic trees with FastTree
FastTree -out /data/users/tschiller/annotation_try2/phylogenetic_analysis/tree_copia /data/users/tschiller/annotation_try2/phylogenetic_analysis/copia_prot_align.fasta
FastTree -out /data/users/tschiller/annotation_try2/phylogenetic_analysis/tree_gypsy /data/users/tschiller/annotation_try2/phylogenetic_analysis/gypsy_prot_align.fasta


grep -e "Retand RT" /data/users/tschiller/annotation_course/fucked_output/annotate_TEs_1_EDTA/Gypsy_sequences.fa.rexdb-plant.cls.tsv|cut -f 1|sed 's/:/_/'|sed 's/#.*//'|sed 's/$/ #FF0000 Retand/' >> gypsy.txt
grep -e "Athila RT" /data/users/tschiller/annotation_course/fucked_output/annotate_TEs_1_EDTA/Gypsy_sequences.fa.rexdb-plant.cls.tsv|cut -f 1|sed 's/:/_/'|sed 's/#.*//'|sed 's/$/ #888888 Athila/' >> gypsy.txt
grep -e "CRM RT" /data/users/tschiller/annotation_course/fucked_output/annotate_TEs_1_EDTA/Gypsy_sequences.fa.rexdb-plant.cls.tsv|cut -f 1|sed 's/:/_/'|sed 's/#.*//'|sed 's/$/ #00FF00 CRM/' >> gypsy.txt
grep -e "Tekay RT" /data/users/tschiller/annotation_course/fucked_output/annotate_TEs_1_EDTA/Gypsy_sequences.fa.rexdb-plant.cls.tsv|cut -f 1|sed 's/:/_/'|sed 's/#.*//'|sed 's/$/ #0000FF Tekay/' >> gypsy.txt
grep -e "Reina RT" /data/users/tschiller/annotation_course/fucked_output/annotate_TEs_1_EDTA/Gypsy_sequences.fa.rexdb-plant.cls.tsv|cut -f 1|sed 's/:/_/'|sed 's/#.*//'|sed 's/$/ #FF00FF Reina/' >> gypsy.txt
grep -e "unknown RT" /data/users/tschiller/annotation_course/fucked_output/annotate_TEs_1_EDTA/Gypsy_sequences.fa.rexdb-plant.cls.tsv|cut -f 1|sed 's/:/_/'|sed 's/#.*//'|sed 's/$/ #FF8800 unknown/' >> gypsy.txt