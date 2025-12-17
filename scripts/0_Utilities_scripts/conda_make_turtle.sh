#! /bin/bash
#SBATCH --job-name=conda
#SBATCH --mail-type=ALL
#SBATCH --mail-user=nicolas.vitry@etudiant.univ-rennes.fr
#SBATCH -o logs/conda.out

. /local/env/envconda.sh

echo "Start installation"

conda create -p turtleProject python=3.10 --yes
conda activate turtleProject
conda install -c bioconda generax=2.0.4 -y
conda install bioconda::trimal -y
mamba install orthofinder=2.5.5 -y
conda list
conda deactivate

echo "Installation finished" 