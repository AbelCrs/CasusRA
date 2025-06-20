unzip("Data_RA_raw.zip", exdir = "Data_RA_raw")
install.packages('BiocManager')
BiocManager::install('Rsubread')
library("Rsubread")
library(BiocManager)
buildindex(
  basename = 'ref_human',
  reference = 'Homo_sapiens.GRCh38.dna.toplevel.fa',
  memory = 9000,
  indexSplit = TRUE)
#RA samples
align.F31aN <- align(index = "ref_human",
                     readfile1 = "SRR4785819_1_subset40k.fastq",
                     readfile2 = "SRR4785819_2_subset40k.fastq", output_file = "F31aN.BAM")

align.F15N <- align(index = "ref_human",
                     readfile1 = "SRR4785820_1_subset40k.fastq",
                     readfile2 = "SRR4785820_2_subset40k.fastq", output_file = "F15N.BAM")

align.F31bN <- align(index = "ref_human",
                      readfile1 = "SRR4785828_1_subset40k.fastq",
                      readfile2 = "SRR4785828_2_subset40k.fastq", output_file = "F31bN.BAM")

align.F42N <- align(index = "ref_human",
                     readfile1 = "SRR4785831_1_subset40k.fastq", 
                     readfile2 = "SRR4785831_2_subset40k.fastq", output_file = "F42N.BAM")

align.F54RA <- align(index = "ref_human",
                      readfile1 = "SRR4785979_1_subset40k.fastq", 
                      readfile2 = "SRR4785979_2_subset40k.fastq", output_file = "F54RA.BAM")

align.F66RA <- align(index = "ref_human",
                      readfile1 = "SRR4785980_1_subset40k.fastq", 
                      readfile2 = "SRR4785980_2_subset40k.fastq", output_file = "F66RA.BAM")

align.F60RA <- align(index = "ref_human",
                      readfile1 = "SRR4785986_1_subset40k.fastq", 
                      readfile2 = "SRR4785986_2_subset40k.fastq", output_file = "F60RA.BAM")

align.F59RA <- align(index = "ref_human",
                      readfile1 = "SRR4785988_1_subset40k.fastq", 
                      readfile2 = "SRR4785988_2_subset40k.fastq", output_file = "F59RA.BAM")

BiocManager::install("Rsamtools")
library("Rsamtools")
# Bestandsnamen van de Samples
samples <- c('F31aN', 'F15N', 'F31bN', 'F42N',
             'F54RA', 'F66RA',"F60RA", "F59RA")
# Voor elk sample: sorteer en indexeer de BAM-file
# Sorteer BAM-bestanden
lapply(samples, function(s) {sortBam(file = paste0(s, '.BAM'), destination = paste0(s, '.sorted'))
})
list.files(pattern = "\\.bai$")
bams <- list.files(pattern = "\\.sorted\\.bam$")
lapply(bams, function(x) indexBam(x))
annotation <- "Homo_sapiens.GRCh38.114.gtf"
getwd(
  
)
list.files(pattern = "\\.sorted\\.bam$")
library("dplyr")
library("Rsamtools")
library("Rsubread")
BiocManager::install("readr")
library("readr")

bams <- list.files(pattern = "\\.sorted\\.bam$")
install.packages("R.utils")
library(R.utils)
R.utils::gunzip("Homo_sapiens.GRCh38.114.gtf.gz", remove=FALSE) 

gtf_file <- "Homo_sapiens.GRCh38.114.gtf"

fc_results <- featureCounts(
     files = bams,
     annot.ext = gtf_file,
     isGTFAnnotationFile = TRUE,
    GTF.featureType = "exon",         
     GTF.attrType = "gene_id",         
     isPairedEnd = TRUE,               
     nthreads = 4                    
   )

counts <- fc_results$counts
dim(counts)
colnames(counts)
head(counts)
save(counts, file = "counts.RData")
load("counts.RData")
View(counts[order(-rowSums(counts)), ])
count_matrix <- read.table(file="count_matrix.txt", header=TRUE)
diagnose <- c("normal", "normal", "normal", "normal", "RA", "RA","RA","RA")
diagnose_table <-data.frame(diagnose)
rownames(diagnose_table)<- c( 'SRR4785819', 'SRR4785820', 'SRR4785828', 'SRR4785831', 'SRR4785979', 'SRR4785980','SRR4785986', 'SRR4785988')
BiocManager::install("DESeq2")
BiocManager::install("KEGGREST")
library("DESeq2")
library("KEGGREST")
dds <- DESeqDataSetFromMatrix(countData = round(count_matrix), colData = diagnose_table, design = ~diagnose)
dds <-DESeq (dds)
resultaten <- results(dds)
write.table(resultaten, file='resultatenDSS.csv', row.names=TRUE, col.names=TRUE)
sum(resultaten$padj < 0.05 & resultaten$log2FoldChange > 1, na.rm=TRUE)
sum(resultaten$padj < 0.05 & resultaten$log2FoldChange < -1, na.rm=TRUE)
hoogste_fold_change <- resultaten[order(resultaten$log2FoldChange, decreasing = TRUE), ]
laagste_fold_change <- resultaten[order(resultaten$log2FoldChange, decreasing = FALSE), ]
laagste_p_waarde <- resultaten[order(resultaten$padj, decreasing = FALSE), ]
#Rij namen van alle resultaten
all <- rownames(resultaten)
#filtreren op significante p waarde en een log2foldchange van boven de 1
resultaten <- as.data.frame(resultaten)
resultaten_filtered <- resultaten %>%
  filter(padj < 0.05, log2FoldChange < -1.5 | log2FoldChange > 1.5)
#filtreren op rownames
DEG <- rownames(resultaten_filtered)
#GO analyse uitvoeren
BiocManager::install("goseq")
BiocManager::install("geneLenDataBase")
BiocManager::install("org.Hs.eg.db")
library("goseq")
library("geneLenDataBase")
library("org.Hs.eg.db")
gene.vector=as.integer(all%in%DEG)
names(gene.vector)=all 
#vector begrip
head(gene.vector)
tail(gene.vector)
gene.vector
pwf=nullp(gene.vector,"hg19","geneSymbol")
#find enriched Go terms
GO.wall=goseq(pwf,"hg19","geneSymbol")
#Hoevbel verrijkte go terms hebben wij?
class(GO.wall)
head(GO.wall)
nrow(GO.wall)
#sorteren op significantie
enriched.GO=GO.wall$category[GO.wall$over_represented_pvalue<.05]
#How many GO terms do we have now?
class(enriched.GO)
head(enriched.GO)
length(enriched.GO)
BiocManager::install("GO.db")
library(GO.db)
capture.output(for(go in enriched.GO[1:258]) { print(GOTERM[[go]])
  cat("--------------------------------------\n")
}
, file="SigGo.txt")

#top 10 visualiseren
library("ggplot2")
top10_GO <- GO.wall %>%
  +     filter(category %in% enriched.GO) %>%
  +     arrange(over_represented_pvalue) %>%
  +     slice_head(n = 10)
head(GO.wall$category)
class(enriched.GO)
head(enriched.GO)
filtered_GO <- GO.wall[GO.wall$category %in% enriched.GO, ]
head(filtered_GO)
detach("package:dplyr", unload = TRUE)
library(dplyr)
top10_GO <- dplyr::filter(GO.wall, category %in% enriched.GO) %>%
  dplyr::arrange(over_represented_pvalue) %>%
  dplyr::slice_head(n = 10)
library(magrittr)
top10_GO <- dplyr::filter(GO.wall, category %in% enriched.GO) %>%
  dplyr::arrange(over_represented_pvalue) %>%
  dplyr::slice_head(n = 10)
top10_GO$term <- sapply(top10_GO$category, function(go_id) {
       term <- Term(GOTERM[[go_id]])
       if (is.null(term)) return(NA)
       else return(term)
  })

ggplot(top10_GO, aes(x = reorder(term, -log10(over_represented_pvalue)), 
                                           y = -log10(over_represented_pvalue))) +
       geom_bar(stat = "identity", fill = "red") +
       coord_flip() +
       labs(title = "Top 10 Enriched GO Terms",
                       x = "GO Term",
                       y = "-log10(P-value)") +
       theme_minimal()
#volcano plot

if (!requireNamespace("EnhancedVolcano", quietly = TRUE)) {
  BiocManager::install("EnhancedVolcano")
}
library(EnhancedVolcano)

EnhancedVolcano(resultaten,
                lab = rownames(resultaten),
                x = 'log2FoldChange',
                y = 'padj')
# Alternatieve plot zonder p-waarde cutoff (alle genen zichtbaar)
EnhancedVolcano(resultaten,
                lab = rownames(resultaten),
                x = 'log2FoldChange',
                y = 'padj',
                pCutoff = 0)
# het figuur opslaan
dev.copy(png, 'VolcanoplotWC.png', 
         width = 8,
         height = 10,
         units = 'in',
         res = 500)
dev.off()
#KEGG uitvoeren
if (!requireNamespace("pathview", quietly = TRUE)) {
  BiocManager::install("pathview")
}
library(pathview)

resultaten[1] <- NULL
resultaten[2:5] <- NULL
#pathway visualiseren waar RA het meest impact op heeft.
pathview(
  gene.data = resultaten,
  pathway.id = "hsa04662",     # Correct KEGG ID for Homo sapiens
  species = "hsa",             # 'hsa' = Homo sapiens
  gene.idtype = "SYMBOL",      # If you're using gene symbols like "TNF", "IL6", etc.
  limit = list(gene = 5)       # Color scale range for log2FC: -5 to +5
)
sessionInfo()
