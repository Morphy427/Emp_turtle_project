#! /bin/bash
#SBATCH --job-name=pipeline
#SBATCH --mail-type=ALL
#SBATCH --mail-user=nicolas.vitry@etudiant.univ-rennes.fr
#SBATCH -o logs/pipelineLogs.out

# Création de tous les répertoires utiles
echo "Creation des répertoires utiles"
mkdir -p genomes
mkdir -p output
mkdir -p logs

# lancement de l'installation de l'environnement conda
JOB_CONDA=$(sbatch --parsable scripts/0_utilities_scripts/conda_make_turtle.sh)
echo "Installation de l'environnement lancé avec l'ID :"$JOB_CONDA

# Téléchargement des données
JOB_DOWNLOAD_SEQ=$(sbatch --parsable --dependency=afterok:$JOB_CONDA scripts/1_Recuperation_Data/downloadGenome.sh)
echo "Téléchargement des données en attente avec l'ID :"$JOB_DOWNLOAD_SEQ

# Script qui renome les fichier .fna en .fa pour orthofinder
JOB_RENAME_FA=$(sbatch --parsable --dependency=afterok:$JOB_DOWNLOAD_SEQ scripts/0_utilities_scripts/renameExt.sh)
echo "Changement des extensions en attente avec l'ID :"$JOB_RENAME_FA

# Script qui renome les identifiants des séquences pour ajouter le nom d'espèce
JOB_ADD_SPECIES_ID=$(sbatch --parsable --dependency=afterok:$JOB_RENAME_FA scripts/0_utilities_scripts/renameId.sh)
echo "Ajout des identifiants en attente avec l'ID :"$JOB_ADD_SPECIES_ID

# Script orthofinder
JOB_ORTHOFINDER=$(sbatch --parsable --dependency=afterok:$JOB_ADD_SPECIES_ID scripts/2_OrthoFinder/orthoFinder.sh)
echo "Orthofinder en attente avec l'ID :"$JOB_ORTHOFINDER

# Lancement de l'alignement
JOB_MAFFT=$(sbatch --parsable --dependency=afterok:$JOB_ORTHOFINDER scripts/3_Alignement/Alignement.sh)
echo "Alignement en attente avec l'ID :"$JOB_MAFFT

# Lancement du trimming des séquences
JOB_TRIMAL=$(sbatch --parsable --dependency=afterok:$JOB_MAFFT scripts/3_Alignement/Trimal.sh)
echo "Trimming en attente avec l'ID :"$JOB_TRIMAL

# Lancement du premier iqTree
JOB_FIRST_IQTREE=$(sbatch --parsable --dependency=afterok:$JOB_TRIMAL scripts/4_Tree_analysis/runIqtree.sh)
echo "Premier Iqtree en attente avec l'ID :"$JOB_FIRST_IQTREE

# Lancement du calcul des scores RF
JOB_RF_COMPUTE=$(sbatch --parsable --dependency=afterok:$JOB_FIRST_IQTREE scripts/4_Tree_analysis/runRfDistance.sh)
echo "Calcul des scores RF en attente avec l'ID :"$JOB_RF_COMPUTE

# Copie des arbres d'intérêt
JOB_COPY_MAKER=$(sbatch --parsable --dependency=afterok:$JOB_RF_COMPUTE scripts/5_Concatenation/copyMaker.sh)
echo "Copie des arbres d'intérêts en attente avec l'ID :"$JOB_COPY_MAKER

# Création de la supermatrice
JOB_SUPERMATRIX=$(sbatch --parsable --dependency=afterok:$JOB_COPY_MAKER scripts/5_Concatenation/createSupermatrix.sh)
echo "Création de la supermatrice en attente avec l'ID :"$JOB_SUPERMATRIX

# Lancement de l'iqtree final
JOB_FINAL_IQTREE=$(sbatch --parsable --dependency=afterok:$JOB_SUPERMATRIX scripts/5_Concatenation/finalIqtree.sh)
echo "Création de l'arbre final en attente avec l'ID :"$JOB_FINAL_IQTREE
