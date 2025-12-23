#! /bin/bash
#SBATCH --job-name=change_name
#SBATCH --mail-type=ALL
#SBATCH --mail-user=nicolas.vitry@etudiant.univ-rennes.fr

#Remodifie les nom des séquence fasta pour ne laisser que le nom de l'espèce


INDIR=genomes
OUTDIR=output/renamed_seq

mkdir -p $OUTDIR

for f in "$INDIR"/*.fa; do
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
