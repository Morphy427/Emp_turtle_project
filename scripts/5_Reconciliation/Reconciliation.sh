#! /bin/bash
#SBATCH --job-name=Reconciliation
#SBATCH --mem 50G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=nicolas.vitry@etudiant.univ-rennes.fr
#SBATCH -o logs/reconciliation.out


outputFile=output/geneRaxOut
mkdir -p $outputFile

python build_family_file.py output/alignement/trimedSeq NONE NONE NONE output/geneRaxOut/familyFile.txt

. /local/env/envconda.sh

conda activate ./turtleProject

inputSpecies=output/outputOf/Results*/Species_Tree/SpeciesTree_rooted.txt
inputFamilies=output/geneRaxOut/familyFile.txt

echo "Début de la réconciliation"
mpirun --mca pml ob1 --mca btl self,tcp generax \
    --families $inputFamilies \
    --rec-model UndatedDTL \
    --prefix $outputFile \
    --strategy SKIP \
    --si-strategy HYBRID \
    --species-tree $inputSpecies \
    --si-estimate-bl \
    --si-quartet-support \
    --prune-species-tree \
    --per-family-rates

echo "Fin de la réconciliation"
conda deactivate