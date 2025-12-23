#!/bin/bash
#SBATCH --job-name=copyMaker
#SBATCH -o logs/copy.log

#Permet de séparé dans un nouveau les orthogroupes que nous avons chois comme marqueurs après observation de la répartition des RF
inputFolder=output/iqtree/allTrees
outputFolder=output/iqtree/alignements_markers_with_name_gene
listFile=output/iqtree/rf_output/RF_extracted.txt

mkdir -p $outputFolder

while read -r filePath || [[ -n $filePath ]]; do
    cleanLine=$(echo $filePath | tr -d '\r')
    ID=`basename $cleanLine .treefile`
    cp -r $inputFolder/$ID.fasta $outputFolder/ 
    echo "copie de:"$ID
done < $listFile
