#!/bin/bash
set -x
trap 'echo "Error on line $LINENO. Exiting script."; exit 1' ERR

ENV_NAME="CELINA"

source $(conda info --base)/etc/profile.d/mamba.sh

# Create Conda environment if it doesn't exist
if ! mamba info --envs | grep -q "$ENV_NAME"; then
    echo "Creating Conda environment: $ENV_NAME"
    mamba env create -f CELINA_environment.yml -y || exit 1

    # Activate the Conda environment
    echo "Activating Conda environment: $ENV_NAME"
    mamba activate $ENV_NAME
    # mamba config append pinned_packages python=3.9.2
    mamba info --envs
    conda config --show pinned_packages

    rm -rf $CONDA_PREFIX/conda-meta/pinned
    
    # Installing GitHub R packages...
    echo "Installing CELINA..."
    Rscript -e "remotes::install_github('pekjoonwu/CELINA')" || exit 1
    
else
    echo "Conda environment $ENV_NAME already exists."
fi

echo "Setup complete! Run the following command to activate the environment:

mamba activate --stack $ENV_NAME

"
set +x