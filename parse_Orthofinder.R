#### load packages
#library(tidyverse)
#library(data.table)
#library(cowplot)
#library(RColorBrewer)
#library(UpSetR)
#
#
#
#### Import datasets
#
#wd <- "/data/users/tschiller/annotation_course/final/genespace/orthofinder/Results_Jan29"
#
## Comparative_Genomics_Statistics/Statistics_PerSpecies.tsv
#stat_per_sp <- paste0(wd, "/Comparative_Genomics_Statistics/Statistics_PerSpecies.tsv")
#dat <- fread(stat_per_sp)
#ids=names(dat)
#dat <- gather(dat, species, perc, ids[ids!="V1"], factor_key = TRUE)
#
## Orthogroups/Orthogroups.GeneCount.tsv
#gene_count <- paste0(wd, "/Orthogroups/Orthogroups.GeneCount.tsv")
#ogroups <- fread(gene_count)
#
## Define output dir for plots
#plot_dir <- paste0(wd, "/orthofinder_plots")
#dir.create(plot_dir)
#
#
#
#### 1) Summarize Orthofinder statistics per species
#
### Parse Dataset 
#o_ratio <- dat %>%
#  filter( V1 %in% c("Number of genes", "Number of genes in orthogroups", "Number of unassigned genes",
#                    "Number of orthogroups containing species", "Number of species-specific orthogroups", 
#                    "Number of genes in species-specific orthogroups"
#  ))
#
#o_percent <- dat %>%
#  filter( V1 %in% c(
#    "Percentage of genes in orthogroups", "Percentage of unassigned genes", "Percentage of orthogroups containing species",
#    "Percentage of genes in species-specific orthogroups"
#  ))
#
#
### Plot
#
#order_species <- c("TAIR10", "Kar1", "RRS10")
#
#o_percent <- o_percent %>%
#  mutate(species = factor(species, levels = order_species))
#
#o_ratio <- o_ratio %>%
#  mutate(species = factor(species, levels = order_species))
#
#colors <- c("#CCCCCC", "#5A8DCB", "#FFA500")  # Adjusted colors
#
#p <- ggplot(o_ratio, aes(x =  V1, y = perc, fill = species)) +
#  geom_col(position = "dodge") +
#  scale_fill_manual(values = setNames(colors, order_species)) +  # Set manual colors
#  # scale_fill_brewer(palette = "Paired") +
#  theme_cowplot() +
#  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
#  labs(y = "Count")
#ggsave(paste0(plot_dir, "/orthogroup_number_plot.pdf"))
#
#p <- ggplot(o_percent, aes(x =  V1, y = perc, fill = species)) +
#  geom_col(position = "dodge") +
#  ylim(c(0, 100)) +
#  scale_fill_manual(values = setNames(colors, order_species)) +  # Set manual colors
#  # scale_fill_brewer(palette = "Paired") +
#  theme_cowplot() +
#  theme(axis.text.x = element_text(angle = 45, hjust = 1),
#        plot.margin = margin(t = 20, r = 20, b = 20, l = 60, unit = "pt")) +
#  labs(y = "Count")
#ggsave(paste0(plot_dir, "/orthogroup_percentage_plot.pdf"))
#
#
#
#### 2) PLot co-occurrence of Orthogroups
#
### parse dataset
#ogroups <- ogroups %>% select(-Total)
#ogroups_presence_absence <- ogroups
#rownames(ogroups_presence_absence) <- ogroups_presence_absence$Orthogroup
#ogroups_presence_absence[ogroups_presence_absence > 0] <- 1
#ogroups_presence_absence$Orthogroup <- rownames(ogroups_presence_absence)
#
#str(ogroups_presence_absence)
#ogroups_presence_absence$Orthogroup
#
#ogroups_presence_absence <- ogroups_presence_absence %>%
#  rowwise() %>%
#  mutate(SUM = sum(c_across(ends_with("proteins"))))
#
#
#genomes <- ids[-1] # names(ogroups_presence_absence)[grepl("proteins",names(ogroups_presence_absence))]
#ogroups_presence_absence <- data.frame(ogroups_presence_absence)
#ogroups_presence_absence[genomes] <- ogroups_presence_absence[genomes] == 1
#
#
### plot data using the ComplexUpset package
#library(ComplexUpset)
#
#pdf(paste0(plot_dir, "/one-to-one_orthogroups_plot.complexupset.pdf"), height = 7, width = 28, useDingbats = T) # 
#upset(ogroups_presence_absence, genomes, name = "genre", width_ratio = 0.1, wrap = T, set_sizes = F)
#dev.off()
library(tidyverse)
library(data.table)

dat <- fread("/data/users/tschiller/annotation_course/final/genespace/orthofinder/Results_Jan29/Comparative_Genomics_Statistics/Statistics_PerSpecies.tsv", header = T, fill = TRUE)
genomes <- names(dat)[names(dat) != "V1"]

dat <- dat %>% pivot_longer(cols = -V1, names_to = "species", values_to = "perc")
ortho_ratio <- dat %>%
    filter(V1 %in% c(
        "Number of genes", "Number of genes in orthogroups", "Number of unassigned genes",
        "Number of orthogroups containing species", "Number of species-specific orthogroups", "Number of genes in species-specific orthogroups"
    ))

ortho_percent <- dat %>%
    filter(V1 %in% c(
        "Percentage of genes in orthogroups", "Percentage of unassigned genes", "Percentage of orthogroups containing species",
        "Percentage of genes in species-specific orthogroups"
    ))

p <- ggplot(ortho_ratio, aes(x = V1, y = perc, fill = species)) +
    geom_col(position = "dodge") +
    cowplot::theme_cowplot() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    labs(y = "Count")
ggsave("/data/users/tschiller/annotation_try2/plots/orthogroup_plot.pdf")


p <- ggplot(ortho_percent, aes(x = V1, y = as.numeric(perc), fill = species)) +
    geom_col(position = "dodge") +
    ylim(c(0, 100)) +
    cowplot::theme_cowplot() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    labs(y = "Count")
ggsave("/data/users/tschiller/annotation_try2/plots/orthogroup_percent_plot.pdf")


library(UpSetR)


orthogroups <- fread("/data/users/tschiller/annotation_course/final/genespace/orthofinder/Results_Jan29/Orthogroups/Orthogroups.GeneCount.tsv")
orthogroups <- orthogroups %>%
    select(-Total)
ogroups_presence_absence <- orthogroups
rownames(ogroups_presence_absence) <- ogroups_presence_absence$Orthogroup

# convert the gene counts to presence/absence
ogroups_presence_absence[ogroups_presence_absence > 0] <- 1
ogroups_presence_absence$Orthogroup <- rownames(ogroups_presence_absence)

str(ogroups_presence_absence)

ogroups_presence_absence <- ogroups_presence_absence %>%
    rowwise() %>%
    mutate(SUM = sum(c_across(!ends_with("Orthogroup"))))



ogroups_presence_absence <- data.frame(ogroups_presence_absence)
ogroups_presence_absence[genomes] <- ogroups_presence_absence[genomes] == 1

#save dataframe
write.table(ogroups_presence_absence,"ogroups_presence_absence.csv")
write.table(genomes, "genomes.csv")


# use ComplexUpset package to make an upset plot with a subset of the data
library(ComplexUpset)

pdf("/data/users/tschiller/annotation_try2/plots/one-to-one_orthogroups_plot.complexupset.pdf", height = 5, width = 10, useDingbats = FALSE)

upset(ogroups_presence_absence, genomes, name = "genre", width_ratio = 0.1, wrap = TRUE, set_sizes = FALSE)
dev.off()
# I executed this locally on my machine in the end and it worked
