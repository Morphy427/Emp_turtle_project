#!/bin/bash
#SBATCH --job-name=supermatrix
#SBATCH -o logs/supermatrix.log


inputFolder=output/iqtree/alignements_markers_with_name_gene
outputFolder=output/concatenation
outputFile=$outputFolder/supermatrix.fasta
outputPartitions=$outputFolder/partitions.txt

mkdir -p $outputFolder

. /local/env/envconda.sh

conda activate ./turtleProject

echo "Création du fichier de partitionnement et de la supermatrice"

python createSupermatrix.py $inputFolder $outputFile $outputPartitions

conda deactivate

echo "Supermatrice et fichier de partitionnement créée"