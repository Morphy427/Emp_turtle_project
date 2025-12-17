# Emp_turtle_project

Repository for turtle phylogenomic pipeline

Cette pipeline se déroule en 6 étapes distinctes:
    - Recuperation des données (scripts/1_Recuperation_Data)
    - Inference des orthologies (scripts/2_OrthoFinder)
    - Sélection des orthogroupes d'intérêts (scripts/3_Alignement/groupOfInterest.sh)
    - Alignement des séquences (scripts/3_Alignement/Alignement.sh)
    - Ajustement des séquences alignés (scripts/4_Trimming)
    - Analyse phylogenetique (scripts/5_Reconciliation)

La pipeline peut être lancé via le script principal `launchPipeline.sh`. Pour éviter tout problème de chemin d'accès il doit être exécuté à la racine du répertoire.

Tous les fichiers `.log` sont présents dans le répertoire `logs` pour rechercher tous les problèmes qui peuvent survenir lors de l'analyse.

