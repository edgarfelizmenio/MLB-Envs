if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager", repos="https://cran.yu.ac.kr/")
BiocManager::install()

BiocManager::install("scater")

library(devtools)

devtools::install_github("pekjoonwu/CELINA")