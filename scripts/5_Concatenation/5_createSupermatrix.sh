#!/bin/bash
#SBATCH --job-name=supermatrix
#SBATCH -o logs/supermatrix2.log


inputFolder=../clean_output/iqtree/alignements_markers_with_name_gene
outputFolder=../clean_output/concatenation
outputFile=../clean_output/concatenation/supermatrix.fasta
outputPartitions=../clean_output/concatenation/partitions.txt

mkdir -p $outputFolder

. /local/env/envconda.sh

conda activate /home/genouest/tp_emp25_41033/tp60421/turtleProject

python 5_create_supermatrix.py $inputFolder $outputFile $outputPartitions

conda deactivate