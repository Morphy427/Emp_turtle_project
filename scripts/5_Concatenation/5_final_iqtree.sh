#! /bin/bash
#SBATCH --job-name=iqtree
#SBATCH --mail-type=ALL
#SBATCH --mail-user=nicolas.vitry@etudiant.univ-rennes.fr
#SBATCH -o logs/iqtree.log


#Crée un nouvel arbre de gène à partir des meilleurs arbres d'espèces
inputFile=output/concatenation/supermatrix.fasta
partitionFile=output/concatenation/partitions.txt

. /local/env/envconda.sh

conda activate /home/genouest/tp_emp25_41033/tp60421/turtleProject

iqtree -T AUTO -s $inputFile -p $partitionFile -m MFP -B 1000 --prefix "finalTree"

conda deactivate
