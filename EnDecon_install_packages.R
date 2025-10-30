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



# ST Deconvolve
BiocManager::install("fgsea")

# SPOTlight
BiocManager::install("DropletUtils")

library(devtools)

# SCDC
remotes::install_github("renozao/xbioc")
devtools::install_github("meichendong/SCDC")

# RCTD
options(timeout = 600000000) ### set this to avoid timeout error
devtools::install_github("dmcable/spacexr", build_vignettes = FALSE)

# Giotto
devtools::install_github('RubD/Giotto')

# STdeconvolve
remotes::install_github('JEFworks-Lab/STdeconvolve')

# SPOTlight
devtools::install_github("https://github.com/MarcElosua/SPOTlight/tree/spotlight-0.1.7")

# CARD
devtools::install_github(c("xuranw/MuSiC",          # for CARD
                           "YingMa0107/CARD"))

# EnDecon
devtools::install_github("JEFworks/liger")
devtools::install_github("edgarfelizmenio/EnDecon", ref="spatstat_univar")