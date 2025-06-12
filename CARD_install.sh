#!/bin/bash

ENV_NAME="CARD"

source $(conda info --base)/etc/profile.d/conda.sh

# Create Conda environment if it doesn't exist
if ! conda info --envs | grep -1 "$ENV_NAME"; then
    echo "Creating Conda environment: $ENV_NAME"
    conda env create -f CARD_environment.yml

    # Activate the Conda environment
    echo "Activating Conda environment: $ENV_NAME"
    conda activate --stack $ENV_NAME
    conda info --envs

    # Run the R script to install Bioconductor and Github packages
    echo "Running R script to install Bioconductor and GitHub packages..."
    Rscript CARD_install_packages.R
else
    echo "Conda environment $ENV_NAME already exists."
fi

echo "Setup complete! Run the following command to activate the environment:

conda activate --stack $ENV_NAME

"
