#! /bin/bash
#SBATCH --job-name=change_name
#SBATCH --mail-type=ALL
#SBATCH --mail-user=marina.vitre@etudiant.univ-rennes.fr

#Remodifie les nom des séquence fasta pour ne laisser que le nom de l'espèce


INDIR=/projects/shared_tp_storage/tp_emp25_41033/truite/output/alignement_E/alignedSeq
OUTDIR=/projects/shared_tp_storage/tp_emp25_41033/truite/output/alignement_E/rename_alignedSeq

mkdir -p $OUTDIR

for f in "$INDIR"/*.fasta; do
    awk '
    /^>/ {
        split($1, a, ">")
        print ">" a[2]
        next
    }
    {
        print
    }' "$f" > "$OUTDIR/$(basename "$f")"
done
