#!/bin/bash
#SBATCH --job-name=rfDistances
#SBATCH --mail-type=ALL
#SBATCH --mail-user=nicolas.vitry@etudiant.univ-rennes.fr
#SBATCH -o logs/rfDistances.log

#Lance le script python permettant de calculer les scores de robinson foulds

rfFolder=output/iqtree/rf_output
inputTable=$rfFolder/results_RF.tsv
outputTable=$rfFolder/RF_extracted.txt

mkdir -p $rfFolder

. /local/env/envconda.sh

conda activate ./turtleProject

for f in output/iqtree/allTrees/*.treefile ; do
    mv $f output/iqtree/allTrees
    echo $f "moved"
    done

python rfDistanceCompute.py
python extractRf.py $inputTable $outputTable

conda deactivate
