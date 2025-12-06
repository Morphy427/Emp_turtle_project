#! /bin/bash
#SBATCH --job-name=Peut_etre
#SBATCH --mail-type=ALL
#SBATCH --mail-user=vincent.ducot@etudiant.univ-rennes.fr

. /local/env/envconda.sh

conda activate /home/genouest/tp_emp25_41033/tp60421/projetPhylo/turtleProject

threads=$SLURM_JOB_CPUS_PER_NODE
inputfolder=./genomes/
outputfolder=./output_of/

orthofinder -t $threads -d -o $outputfolder -f $inputfolder

conda deactivate