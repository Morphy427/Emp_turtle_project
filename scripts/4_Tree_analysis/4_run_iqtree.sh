#! /bin/bash
#SBATCH --job-name=iqtree
#SBATCH --mail-type=ALL
#SBATCH --mail-user=nicolas.vitry@etudiant.univ-rennes.fr
#SBATCH -o logs/iqtree.log
#SBATCH --cpus-per-task=20



#Filtre les alignements multiple pour ne garder que ceux dont la longueur est su^érieur à 650
#Crée un arbre de gène pour chaque alignement multiple/ orthogroupe

. /local/env/envconda.sh

conda activate /home/genouest/tp_emp25_41033/tp60421/turtleProject

THREADS=$SLURM_JOB_CPUS_PER_NODE

inputFolder=../clean_output/alignement/trimedSeq
outputFolder=../clean_output/iqtree/
outputFolderAll=../clean_output/iqtree/allSpecies

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



for f in $outputFolder*fasta; do
     ID=`basename $f .fasta`
     iqtree -T $THREADS -s "$outputFolder""$ID"".fasta" -m MFP --prefix $ID
     mv $ID* $outputFolderAll
done

conda deactivate

# # possible options:
# -m TESTONLY
# -m TEST
# -quiet
# ... 2> /dev/null
