WORKDIR=/data/users/tschiller/annotation_try2/EDTA_annotation/
cd $WORKDIR
Intact_fasta=/data/users/tschiller/annotation_try2/EDTA_annotation/assembly.fasta.mod.EDTA.raw/LTR/assembly.fasta.mod.LTR.intact.raw.fa


apptainer exec \
--bind $WORKDIR \
/data/courses/assembly-annotation-course/containers2/TEsorter_1.3.0.sif \
TEsorter $Intact_fasta -db rexdb-plant