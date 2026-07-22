#!/bin/bash
trap 'echo "Error on line $LINENO. Exiting script."; exit 1' ERR

ENV_NAME="NetBID2"

source $(conda info --base)/etc/profile.d/mamba.sh

# Create Conda environment if it doesn't exist
if ! mamba info --envs | grep -q "$ENV_NAME"; then
    echo "Creating Conda environment: $ENV_NAME"
    mamba env create -f NetBID2_environment.yml -y || exit 1

    # Activate the Conda environment
    echo "Activating Conda environment: $ENV_NAME"
    mamba activate $ENV_NAME
    # mamba config append pinned_packages python=3.9.2
    mamba info --envs
    conda config --show pinned_packages

    rm -rf $CONDA_PREFIX/conda-meta/pinned
    # echo "r-base>=4.2.3,<4.3" > $CONDA_PREFIX/conda-meta/pinned
    # echo "python>=3.7.6,<=3.9.2" >> $CONDA_PREFIX/conda-meta/pinned
    
    # Installing GitHub NetBID2...
    echo "Installing NetBID2..."
    Rscript -e "devtools::install_github('jyyulab/NetBID')" || exit 1
    
else
    echo "Conda environment $ENV_NAME already exists."
fi

echo "Setup complete! Run the following command to activate the environment:

mamba activate --stack $ENV_NAME

"
