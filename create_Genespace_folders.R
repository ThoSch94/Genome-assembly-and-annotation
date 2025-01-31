library(data.table)
library(tidyverse)


# Load the annotation
annotation <- fread("/data/users/tschiller/annotation_course/final/filtered.genes.renamed.final.gff3", header = FALSE, sep = "\t")
bed_genes <- annotation %>%
    filter(V3 == "gene") %>%
    select(V1, V4, V5, V9) %>%
    mutate(gene_id = as.character(str_extract(V9, "ID=[^;]*"))) %>%
    mutate(gene_id = as.character(str_replace(gene_id, "ID=", ""))) %>%
    select(-V9)

top20_scaff <- fread("/data/users/tschiller/assembly_course/assemblies/LJA/assembly.fasta.fai", header = FALSE, sep = "\t") %>%
    select(V1, V2) %>%
    arrange(desc(V2)) %>%
    head(20)

# Write the bed file
bed_genes <- bed_genes %>%
    filter(V1 %in% top20_scaff$V1)

gene_id <- bed_genes$gene_id
write.table(gene_id, "/data/users/tschiller/annotation_course/final/genespace_genes.txt", quote = FALSE, row.names = FALSE, col.names = FALSE)
# Load the longest protein sequences
longest_proteins <- "/data/users/tschiller/annotation_course/final/longest_proteins.fasta"

# make a genespace specific directory
if (!dir.exists("genespace")) {
    dir.create("genespace")
}
if (!dir.exists("genespace/bed")) {
    dir.create("genespace/bed")
}
if (!dir.exists("genespace/peptide")) {
    dir.create("genespace/peptide")
}

write.table(bed_genes, "genespace/bed/genome1.bed", sep = "\t", quote = FALSE, row.names = FALSE, col.names = FALSE)

# remove "-R.*" from fasta headers of proteins, to get only gene IDs
system(paste("sed 's/-R.*//' ", longest_proteins, " > genome1_peptide.fa", sep = ""))
