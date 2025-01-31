

data_file1=$1
data_file2=$2
data_file3=$3

module load fastp/0.23.4-GCC-10.3.0
cd /data/users/tschiller/assembly_course
#fastp -i ./RNAseq_Sha/ERR754081_1.fastq.gz -I ./RNAseq_Sha/ERR754081_2.fastq.gz -o ./cleaned_data/ERR754081_1.fastq.gz -O ./cleaned_data/ERR754081_2.fastq.gz
#fastp -i ./RRS10/ERR11437326.fastq.gz -o ./cleaned_data/ERR11437326.fastq.gz 

fastp \
    -i $data_file1 \
    -I $data_file2 \
    -o /cleaned_data/ERR754081_1.fastq.gz \
    -O /cleaned_data/ERR754081_2.fastq.gz \
    --detect_adapter_for_pe \
    --cut_front \
    --cut_tail \
    --cut_window_size 4 \
    --cut_mean_quality 20 \
    --qualified_quality_phred 15 \
    --length_required 36 \
    --json /data/users/tschiller/assembly_course/cleaned_data/fastp_RNA.json \
    --html /data/users/tschiller/assembly_course/cleaned_data/fastp_RNA.html \
    --thread 4  # Adjust threads based on your system
fastp \
    -i ./RRS10/ERR11437326.fastq.gz \
    -o  ./cleaned_data/ERR11437326.fastq.gz \
    --disable_length_filtering \
    --json /data/users/tschiller/assembly_course/cleaned_data/fastp_DNA.json \
    --html /data/users/tschiller/assembly_course/cleaned_data/fastp_DNA.html \
    --thread 4  # Adjust threads based on your system
