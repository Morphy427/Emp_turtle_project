#!/bin/bash
#SBATCH --job-name=rfDistances
#SBATCH --mail-type=ALL
#SBATCH --mail-user=nicolas.vitry@etudiant.univ-rennes.fr
#SBATCH -o logs/rfDistances2.log

#Lance le script python permettant de calculer les scores de robinson foulds

rfFolder=output/iqtree/rf_output
inputTable=$rfFolder/results_RF.tsv
outputTable=$rfFolder/RF_extracted.txt

mkdir -p $rfFolder

. /local/env/envconda.sh

conda activate /home/genouest/tp_emp25_41033/tp60421/turtleProject

for f in output/iqtree/allSpecies/*.treefile ; do
    mv $f output/iqtree/allTrees
    echo $f "moved"
    done

python 4_RF_distance.py
python 4_extract_rf.py $inputTable $outputTable

conda deactivate
