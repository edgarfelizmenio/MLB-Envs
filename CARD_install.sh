#!/bin/bash

ENV_NAME="CARD"

source $(conda info --base)/etc/profile.d/mamba.sh

# Create Conda environment if it doesn't exist
if ! mamba info --envs | grep -1 "$ENV_NAME"; then
    echo "Creating Conda environment: $ENV_NAME"
    mamba env create -f CARD_environment.yml -y || exit 1

    # Activate the Conda environment
    echo "Activating Conda environment: $ENV_NAME"
    mamba activate --stack $ENV_NAME
    mamba info --envs

    # Run the R script to install Bioconductor and Github packages
    echo "Running R script to install Bioconductor and GitHub packages..."
    Rscript -e "devtools::install_github(c('xuranw/MuSiC', 
                           'YingMa0107/CARD'))" || exit 1

else
    echo "Conda environment $ENV_NAME already exists."
fi

echo "Setup complete! Run the following command to activate the environment:

mamba activate --stack $ENV_NAME

"
