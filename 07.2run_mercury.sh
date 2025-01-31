#!/usr/bin/env bash

#SBATCH --cpus-per-task=20
#SBATCH --mem=30G
#SBATCH --time=1:00:00
#SBATCH --job-name=run_merq
#SBATCH --output=/data/users/tschiller/assembly_course/logs/output_mercury5_%j.o
#SBATCH --error=/data/users/tschiller/assembly_course/logs/error_mercury5_%j.e
#SBATCH --partition=pibu_el8

# Working Directories
WORKDIR=/data/users/tschiller/assembly_course/
READDIR=/data/users/tschiller/assembly_course/RRS10/ERR11437326.fastq.gz

# Input Dirs
FLYEIN=/data/users/tschiller/assembly_course/assemblies/flye_assembly/assembly.fasta
HIFIASMIN=/data/users/tschiller/assembly_course/assemblies/hifiasm/hifi_asm.fa
LJAIN=/data/users/tschiller/assembly_course/assemblies/LJA/assembly.fasta

# Output Dirs
MERCURYDIR=/data/users/tschiller/assembly_course/assemblies/merqury_eval
MERYLDIR=/data/users/tschiller/assembly_course/assemblies/merqury_eval/meryl
FLYEOUT=$MERCURYDIR/flye
HIFIOUT=$MERCURYDIR/hifi
LJAOUT=$MERCURYDIR/lja

mkdir -p $MERCURYDIR $MERYLDIR $FLYEOUT $HIFIOUT $LJAOUT
export MERQURY="/usr/local/share/merqury"

cd $WORKDIR
apptainer exec /containers/apptainer/merqury_1.3.sif\
 meryl k=18 count $READDIR output $MERYLDIR.meryl


cd $FLYEOUT
apptainer exec --bind $WORKDIR\
 /containers/apptainer/merqury_1.3.sif\
 merqury.sh /data/users/tschiller/assembly_course/assemblies/merqury_eval/meryl.meryl $FLYEIN flye_merq

cd $HIFIOUT
apptainer exec --bind $WORKDIR\
 /containers/apptainer/merqury_1.3.sif\
 merqury.sh /data/users/tschiller/assembly_course/assemblies/merqury_eval/meryl.meryl $HIFIASMIN hifi_merq

cd $LJAOUT
apptainer exec --bind $WORKDIR\
 /containers/apptainer/merqury_1.3.sif\
 merqury.sh /data/users/tschiller/assembly_course/assemblies/merqury_eval/meryl.meryl $LJAIN lja_merq


