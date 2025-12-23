#!/bin/bash
#SBATCH --job-name=supermatrix
#SBATCH -o logs/supermatrix2.log


inputFolder=output/iqtree/alignements_markers_with_name_gene
outputFolder=output/concatenation
outputFile=$outputFolder/supermatrix.fasta
outputPartitions=$outputFolder/partitions.txt

mkdir -p $outputFolder

. /local/env/envconda.sh

conda activate ./turtleProject

python createSupermatrix.py $inputFolder $outputFile $outputPartitions

conda deactivate