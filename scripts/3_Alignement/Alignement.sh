#! /bin/bash
#SBATCH --job-name=Mafft
#SBATCH --cpus-per-task=10
#SBATCH --mail-type=ALL
#SBATCH --mail-user=nicolas.vitry@etudiant.univ-rennes.fr
#SBATCH -o logs/alignement.out

. /local/env/envconda.sh

conda activate /home/genouest/tp_emp25_41033/tp60421/turtleProject


threads=$SLURM_JOB_CPUS_PER_NODE
listFile=output/alignement/listOfGroup.txt
outputFolder=output/alignement/alignedSeq
mkdir -p $outputFolder

echo "Début de l'alignement"
while read filePath; do
    ID=`basename $filePath .fa`
    mafft --thread $threads --auto --anysymbol $filePath > ${outputFolder}/${ID}_mafft.fasta
    echo $ID
done < $listFile

echo "Alignement effectué"

conda deactivate