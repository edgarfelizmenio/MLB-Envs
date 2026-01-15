#!/bin/bash

ENV_NAME="HGCTSVG"

source $(conda info --base)/etc/profile.d/conda.sh

# Create Conda environment if it doesn't exist
if ! conda info --envs | grep -1 "$ENV_NAME"; then
    echo "Creating Conda environment: $ENV_NAME"
    conda env create -f ${ENV_NAME}_environment-cu124.yml

    # Activate the Conda environment
    echo "Activating Conda environment: $ENV_NAME"
    conda activate --stack $ENV_NAME
    conda info --envs

    # Install pytorch
    pip install torch==2.6.0 torchvision==0.21.0 torchaudio==2.6.0 --index-url https://download.pytorch.org/whl/cu124

    # Install pyg
    pip install torch_geometric
    
    # Optional pyg dependencies:
    pip install pyg_lib torch_scatter torch_sparse torch_cluster torch_spline_conv -f https://data.pyg.org/whl/torch-2.6.0+cu124.html

else
    echo "Conda environment $ENV_NAME already exists."
fi

echo "Setup complete! Run the following command to activate the environment:

conda activate --stack $ENV_NAME

"
