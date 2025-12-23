#! /bin/bash
#SBATCH --job-name=Trimal
#SBATCH --mail-type=ALL
#SBATCH --mail-user=nicolas.vitry@etudiant.univ-rennes.fr
#SBATCH -o logs/trimal.log

. /local/env/envconda.sh

conda activate ./turtleProject

inputFolder=output/alignement/alignedSeq/
outputFolder=output/alignement/trimedSeq/
mkdir -p $outputFolder

echo "Début de l'ajustement des séquences"

for f in $inputFolder/*.fasta ; do
	ID=`basename $f .fasta`
    echo "traitement de :"$ID
	trimal -in $f -out ${outputFolder}/${ID}_trimal.fasta -automated1 -fasta
done

echo "Ajustement des séquences fait"
conda deactivate