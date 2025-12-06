#! /bin/bash
#SBATCH --job-name=conda
#SBATCH --mail-type=ALL
#SBATCH --mail-user=nicolas.vitry@etudiant.univ-rennes.fr

. /local/env/envconda.sh

echo "Start installation"

conda create -p turtleProject -c bioconda mafft iqtree orthofinder

echo "Installation finished" 