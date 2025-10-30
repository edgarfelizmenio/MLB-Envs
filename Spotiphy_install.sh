#!/bin/bash

ENV_NAME="Spotiphy"

source $(conda info --base)/etc/profile.d/conda.sh

# Create Conda environment if it doesn't exist
if ! conda info --envs | grep -1 "$ENV_NAME"; then
    echo "Creating Conda environment: $ENV_NAME"
    conda create -n Spotiphy-env python=3.9

    # Activate the Conda environment
    echo "Activating Conda environment: $ENV_NAME"
    conda activate --stack $ENV_NAME
    conda info --envs

    # Installing Spotiphy dependencies...
    echo "Installing Spotiphy dependencies..."
    conda install "setuptools<81"
    pip install torch==2.7.0 --index-url https://download.pytorch.org/whl/cu118
    pip install opencv-python-headless
    pip install 'numpy<2'
    pip install tensorflow[and-cuda]==2.16.2

    # Installing Spotiphy...
    echo "Installing Spotiphy..."
    pip install spotiphy==0.3.1
else
    echo "Conda environment $ENV_NAME already exists."
fi

echo "Setup complete! Run the following command to activate the environment:

conda activate --stack $ENV_NAME

"
