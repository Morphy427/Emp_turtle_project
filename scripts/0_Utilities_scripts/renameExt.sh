#! /bin/bash
#SBATCH --job-name=renameSeq
#SBATCH --mail-type=ALL
#SBATCH --mail-user=nicolas.vitry@etudiant.univ-rennes.fr
#SBATCH -o logs/renameSeq.out

# Script to rename ".fna" file in ".fa" file

for f in genomes/*.fna ; do
	speciesID=`basename $f .fna`
	mv $f genomes/$speciesID.fa
done

echo "Extensions changées"