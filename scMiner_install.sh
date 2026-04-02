#!/bin/bash
trap 'echo "Error on line $LINENO. Exiting script."; exit 1' ERR

ENV_NAME="scMiner"

source $(conda info --base)/etc/profile.d/mamba.sh

# Create Conda environment if it doesn't exist
if ! mamba info --envs | grep -q "$ENV_NAME"; then
    echo "Creating Conda environment: $ENV_NAME"
    mamba env create -f scMiner_environment.yml -y || exit 1

    # Activate the Conda environment
    echo "Activating Conda environment: $ENV_NAME"
    mamba activate $ENV_NAME
    # mamba config append pinned_packages python=3.9.2
    mamba info --envs
    conda config --show pinned_packages

    rm -rf $CONDA_PREFIX/conda-meta/pinned
    echo "r-base>=4.2.3,<4.3" > $CONDA_PREFIX/conda-meta/pinned
    echo "python>=3.7.6,<=3.9.2" >> $CONDA_PREFIX/conda-meta/pinned
    
    mamba install -c conda-forge \
      r-remotes r-biocmanager -y || exit 1

    # R deps via conda (faster + no compile issues)
    mamba install -c conda-forge -c bioconda \
      r-matrix r-ggplot2 r-anndata r-dplyr r-gridextra \
      r-igraph r-pheatmap r-reshape2 r-rmarkdown r-sessioninfo \
      r-rcolorbrewer r-knitr r-kableextra r-openxlsx r-hdf5r \
      r-testthat r-devtools r-rcpp \
      bioconductor-biobase bioconductor-limma -y || exit 1

    # Install SuperCell's missing deps via conda first
    mamba install -c conda-forge -c bioconda \
      r-weightedcluster r-weights r-nloptr r-lme4 r-haven \
      r-mice r-rann r-corpcor r-matrixstats r-irlba \
      r-patchwork r-umap r-entropy r-rtsne r-cowplot \
      r-dbscan r-proxy bioconductor-bluster r-plotfunctions -y || exit 1
    
    # pip-only deps
    pip install \
      numpy==1.20.1 scipy==1.7.3 pandas==1.2.3 \
      scikit-learn==0.24.1 matplotlib==3.4.0 seaborn==0.11.1 \
      Pillow==8.1.2 llvmlite==0.36.0 numba==0.53.1 \
      anndata==0.8.0 h5py networkx python-louvain==0.15 \
      gensim==4.1.2 umap-learn pynndescent==0.5.2 \
      cwltool pecanpy fast-histogram get-version \
      humanfriendly isodate joblib kiwisolver legacy-api-wrap \
      lockfile lxml packaging patsy psutil prov pyparsing \
      sinfo smart-open tqdm importlib-metadata || exit 1

    # Installing GitHub R packages...
    echo "Installing scMiner..."
    Rscript -e "remotes::install_github('GfellerLab/SuperCell', dependencies=FALSE)" || exit 1
    Rscript -e "remotes::install_github('jyyulab/scMINER', dependencies=FALSE)" || exit 1

    # Installing scMiner Components...
    echo "Installing scMiner Components..."
    git clone https://github.com/jyyulab/MICA           # Clone the MICA repo
    cd MICA                                             # Switch to the MICA root directory
    pip install . || exit 1                                      # Install MICA and its dependencies
    mica -h                                             # Check if MICA works
    
    ## install SJARACNE
    cd ..                                               # Switch to conda env folder
    git clone https://github.com/jyyulab/SJARACNe.git   # Clone the SJARACNe repo
    cd SJARACNe                                         # Switch to the MICA root directory
    python setup.py build || exit 1                              # Build SJARACNe binary
    python setup.py install || exit 1                             # Build SJARACNe binary
    sjaracne -h
    cd ..
    
else
    echo "Conda environment $ENV_NAME already exists."
fi

echo "Setup complete! Run the following command to activate the environment:

mamba activate --stack $ENV_NAME

"
