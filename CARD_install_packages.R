if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager", repos="https://cran.yu.ac.kr/")
BiocManager::install()

BiocManager::install("S4Arrays")
BiocManager::install("SparseArray")
BiocManager::install("DelayedArray")
BiocManager::install("GenomeInfoDbData")
BiocManager::install("Biobase")
BiocManager::install("SummarizedExperiment")
BiocManager::install("SingleCellExperiment")
BiocManager::install("TOAST")

library(devtools)

devtools::install_github(c("xuranw/MuSiC", 
                           "YingMa0107/CARD"))