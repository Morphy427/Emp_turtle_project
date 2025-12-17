#! /bin/bash
#SBATCH --job-name=orthoFinder
#SBATCH --cpus-per-task=10
#SBATCH --mail-type=ALL
#SBATCH --mail-user=nicolas.vitry@etudiant.univ-rennes.fr
#SBATCH -o logs/orthoFinder.out

. /local/env/envconda.sh

conda activate ./turtleProject

threads=$SLURM_JOB_CPUS_PER_NODE
inputfolder=genomes
outputfolder=output/outputOf
mkdir -p outputOf

echo "Orthofinder lancée"

orthofinder -t $threads -M dendroblast -S diamond -1 -X -o $outputfolder -f $inputfolder -d

echo "Orthofinder terminée"
conda deactivate




