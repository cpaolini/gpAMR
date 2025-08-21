#!/bin/bash

if [[ -v LMOD_CMD ]]; then
    echo "LMOD_CMD is defined: $LMOD_CMD"
    type module

    if [ -d $HOME/.conda ]; then
        temp_dir=$(mktemp -d $SCRATCH/.conda.XXXXXX)
        mv $HOME/.conda $temp_dir
        ls -l $temp_dir
    fi

    module load conda
    conda create -n gpamr_env python=3.10 -y

    conda activate gpamr_env
    conda update -n base -c conda-forge conda -y
    conda install numpy -y

    # https://anaconda.org/search?q=gpcam
    conda install conda-forge::gpcam -y

    python3.10 -c "import gpcam"
    #python3.10 -c "from gpcam import GPOptimizer"

    conda deactivate
    conda remove -n gpamr_env python=3.10 -y

else
    echo "LMOD_CMD is not defined"
fi
