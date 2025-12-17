#! /bin/bash
#SBATCH --job-name=groupsOfInterest
#SBATCH --mail-type=ALL
#SBATCH --mail-user=nicolas.vitry@etudiant.univ-rennes.fr
#SBATCH -o logs/groupsOfInterest.out

inputFolder=output/outputOf/Results*/Orthogroup_Sequences
outputFolder=output/alignement
mkdir -p $outputFolder

echo "Début de la sélection des orthogroupes d'intérêt"
for f in $inputFolder/* ; do
	seqID=`basename $f `
	python sortingGroups.py $f $outputFolder
done
echo "Orthogroupes sélectionnées"