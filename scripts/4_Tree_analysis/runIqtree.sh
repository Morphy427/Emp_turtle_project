#! /bin/bash
#SBATCH --job-name=iqtree
#SBATCH --mail-type=ALL
#SBATCH --mail-user=nicolas.vitry@etudiant.univ-rennes.fr
#SBATCH -o logs/iqtree.log
#SBATCH --cpus-per-task=15

. /local/env/envconda.sh

conda activate ./turtleProject

THREADS=$SLURM_CPUS_PER_TASK

inputFolder=output/alignement/trimedSeq
outputFolder=output/iqtree/
outputFolderAll=output/iqtree/allTrees

mkdir -p $outputFolder
mkdir -p $outputFolderAll


for f in $inputFolder/*.fasta; do
    awk '
    /^>/ {
        if (NR > 1 && len > 650) exit 0
        len = 0
        next
    }
    {
        gsub(/[ \t\r\n]/, "")
        len += length($0)
    }
    END {
        if (len > 650) exit 0
        else exit 1
   }' "$f" && cp "$f" $outputFolder
done

echo "Début du premier iqtree sur tous les gènes"

for f in $outputFolder*fasta; do
     ID=`basename $f .fasta`
     iqtree -T $THREADS -s "$outputFolder""$ID"".fasta" -m MFP --prefix $ID
     mv $ID* $outputFolderAll
done

echo "Fin du premier iqtree"

conda deactivate
