#!/bin/bash
#SBATCH --job-name=rfDistances
#SBATCH --mail-type=ALL
#SBATCH --mail-user=nicolas.vitry@etudiant.univ-rennes.fr
#SBATCH -o logs/rfDistances2.log

#Lance le script python permettant de calculer les scores de robinson foulds
inputTable=../clean_output/iqtree/rf_output/results_RF.tsv
outputTable=../clean_output/iqtree/rf_output/RF_extracted.txt

. /local/env/envconda.sh

conda activate /home/genouest/tp_emp25_41033/tp60421/turtleProject

for f in ../clean_output/iqtree/allSpecies/*.treefile ; do
    mv $f ../clean_output/iqtree/allTrees
    echo $f "moved"
    done

python 4_RF_distance.py
python 4_extract_rf.py $inputTable $outputTable

conda deactivate
