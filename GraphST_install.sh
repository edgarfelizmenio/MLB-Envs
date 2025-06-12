#!/bin/bash

ENV_NAME="GraphST"

source $(conda info --base)/etc/profile.d/conda.sh

# Create Conda environment if it doesn't exist
if ! conda info --envs | grep -1 "$ENV_NAME"; then
    echo "Creating Conda environment: $ENV_NAME"
    conda env create -f GraphST_environment.yml

    # Activate the Conda environment
    echo "Activating Conda environment: $ENV_NAME"
    conda activate --stack $ENV_NAME
    conda info --envs

else
    echo "Conda environment $ENV_NAME already exists."
fi

echo "Setup complete! Run the following command to activate the environment:

conda activate --stack $ENV_NAME

"
