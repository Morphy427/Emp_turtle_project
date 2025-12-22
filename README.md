# Emp_turtle_project

Repository for turtle phylogenomic pipeline

Cette pipeline se déroule en 6 étapes distinctes:

    - Recuperation des données (scripts/1_Recuperation_Data)

    - Inference des orthologies (scripts/2_OrthoFinder)

    - Alignement des séquences (scripts/3_Alignement/Alignement.sh)

    - Ajustement des séquences alignés (scripts/3_Alignement/Trimal.sh)

    - Analyse des arbres de gène (scripts/4_Tree_analysis)

    - Concaténation et création de l'arbre final (scripts/5_Concatenation)


La pipeline peut être lancé via le script principal `launchPipeline.sh`. Pour éviter tout problème de chemin d'accès il doit être exécuté à la racine du répertoire.

Tous les fichiers `.log` sont présents dans le répertoire `logs` pour rechercher tous les problèmes qui peuvent survenir lors de l'analyse.

Une analyse manuelle peut être effectué en utilisant les différents scripts présents au sein de chacun des répertoires présents dans scripts/ . Cependant une attention particulière devra être apporté aux différents chemins d'accès.

