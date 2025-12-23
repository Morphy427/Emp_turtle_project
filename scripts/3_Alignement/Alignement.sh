#! /bin/bash
#SBATCH --job-name=Mafft
#SBATCH --mail-type=ALL
#SBATCH --mail-user=nicolas.vitry@etudiant.univ-rennes.fr
#SBATCH -o logs/alignement.log

. /local/env/envconda.sh

conda activate ./turtleProject



singleCopyFolder=output/outputOf/Results*/Single_Copy_Orthologue_Sequences
outputFolder=output/alignement/alignedSeq
mkdir -p $outputFolder

echo "Début de l'alignement"

for filePath in $singleCopyFolder/*.fa; do
    ID=`basename $filePath .fa`
    mafft -T AUTO --auto --anysymbol $filePath > $outputFolder/${ID}_mafft.fasta
done

echo "Alignement effectué"

conda deactivate