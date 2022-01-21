#load sleuth and all required packages to do so
#sleuth was downloaded locally with the instructions found here: https://githubmemory.com/@passt
#help(package = 'sleuth')
setwd("C:/Users/livbr/bioinformatics/rna_seq")
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager:: install("rhdf5")
BiocManager::install("devtools")
devtools::install('./sleuth/') 
install.packages("shiny")
library(shiny)
install.packages("htmltools")
library(htmltools)

#followed this documentation https://rawgit.com/pachterlab/sleuth/master/inst/doc/intro.html 
#and this https://pachterlab.github.io/sleuth/docs/sleuth_results.html
#load package 
library('sleuth')

#kallisto_output was downloaded locally, now define path for Sleuth to use it
base_dir <- "C:/Users/livbr/bioinformatics/rna_seq/output_quantification"

#introduce samples
sample_id <- dir(file.path(base_dir))
kal_dirs <- sapply(sample_id, function(id) file.path(base_dir, id))

#fill metadata about samples
s2c <- data.frame(path=kal_dirs, sample=sample_id, condition = rep(c("holo", "mero", "para", "parent"), each=3), stringsAsFactors=FALSE)
s2c <- dplyr::select(s2c, sample, condition)
s2c <- dplyr::mutate(s2c, path = kal_dirs)

#connect ENSEMBL gene names with common gene names
#collect gene names
mart <- biomaRt::useMart(biomart = "ENSEMBL_MART_ENSEMBL", dataset = "hsapiens_gene_ensembl", host = 'https://www.ensembl.org')

#add them to sleuth table
t2g <- biomaRt::getBM(attributes = c("ensembl_transcript_id", "ensembl_gene_id", "external_gene_name"), mart = mart)
t2g <- dplyr::rename(t2g, target_id = ensembl_transcript_id, ens_gene = ensembl_gene_id, ext_gene = external_gene_name)

###transcript level
#read kallisto output files, connect with metadata and set up a linear model for analyzing the expression data
so <- sleuth_prep(s2c, ~condition, target_mapping = t2g, extra_bootstrap_summary=TRUE)

#fit full model
so <- sleuth_fit(so)

#fit reduced model
so <- sleuth_fit(so, ~1, 'reduced')

#perform test
so <- sleuth_lrt(so, 'reduced', 'full')

#view models
models(so)

#generate Shiny webpage that allows for exploratory data analysis
sleuth_live(so)

#do Wald test
so <- sleuth_wt(so, which_beta="conditionparent")

#view comparison of expression of one target_id as plot
plot_bootstrap(so, "target_id")

#generate volcano plot
#sig_level: 0.1 or 0.05
plot_volcano(so, test="conditionparent" , test_type = "wt", which_model = "full",
             sig_level = 0.05, point_alpha = 0.2, sig_color = "red",
             highlight = NULL)

#generate matrix
Matrix_transcriptlevel <- sleuth_to_matrix(obj = so, which_df = "obs_norm", which_units = "tpm")

#generate table of results
transcript_results_table <- sleuth_results(so, test='conditionparent', test_type = 'wt', show_all=TRUE)
filtered_transcript_results_table <- dplyr::filter(transcript_results_table, qval <= 0.05)

#save tables as files
write.table(filtered_transcript_results_table,file="Transcript_level_result_table.txt",quote=F,sep="\t")
write.table(Matrix_transcriptlevel,file="Differential_expr_Transcript_level.txt",quote=F,sep="\t")

###gene level analysis

#delete so variable from transcript level analysis
rm(so)

#read kallisto output files, connect with metadata and set up a linear model for analyzing the expression data
so <- sleuth_prep(s2c, ~condition, target_mapping = t2g, gene_mode=TRUE, aggregation_column = 'ens_gene', extra_bootstrap_summary=TRUE)

#fit full model
so <- sleuth_fit(so)

#fit reduced model
so <- sleuth_fit(so, ~1, 'reduced')

#perform test
so <- sleuth_lrt(so, 'reduced', 'full')

#view models
models(so)

#generate Shiny webpage that allows for exploratory data analysis
sleuth_live(so)

#view comparison of expression of one target_id as plot
plot_bootstrap(so, "enter target_id")

#do Wald test
so <- sleuth_wt(so, which_beta="conditionparent")

#generate volcano plot
#sig_level: 0.1 or 0.05
plot_volcano(so, test="conditionparent" , test_type = "wt", which_model = "full",
             sig_level = 0.1, point_alpha = 0.2, sig_color = "red",
             highlight = NULL)

#generate table of results
gene_results_table <- sleuth_results(so, test='conditionparent', test_type = 'wt', show_all= TRUE)
filtered_gene_results_table <- dplyr::filter(gene_results_table, qval <= 0.05)

#generate matrix
Matrix_genelevel <- sleuth_to_matrix(obj = so, which_df = "obs_norm", which_units = "scaled_reads_per_base")

##save tables as files
write.table(Matrix_genelevel,file="Differential_expr_Gene_level.txt",quote=F,sep="\t", na = "NA")
write.table(filtered_gene_results_table, file='Gene_level_result_table.txt', quot=F,sep='\t', na = 'NA')
