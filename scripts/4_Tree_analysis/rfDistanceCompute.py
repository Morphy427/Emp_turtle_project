#! /bin/python

#Calcule les score de Robinson foulds normalisé (RF/RF_max) et crée un fichier tsv contenant le nom des orthogroups ainsi que leurs RF normalisé

import os
import glob
from ete3 import Tree

ref_files = glob.glob("output/outputOf/Results*/Species_Tree/SpeciesTree_rooted.txt")
if not ref_files: raise FileNotFoundError("Arbre de référence non trouvé")
reference_tree = ref_files[0]
gene_trees_dir = "output/iqtree/allTrees"
output_file = "output/iqtree/rf_output/results_RF.tsv"


ref_tree = Tree(reference_tree)
gene_files = [f for f in os.listdir(gene_trees_dir)]


out = open(output_file, 'w')
out.write("Gene_tree\tRF_distance\n")


for file in sorted(gene_files):
    gene_path = os.path.join(gene_trees_dir, file)
    gene_tree = Tree(gene_path, format=1)

    for leaf in gene_tree:
        leaf.name = leaf.name.replace(".fa", "")
        
    rf, rf_max = ref_tree.robinson_foulds(gene_tree, unrooted_trees=True)[:2]

    #RF normalisé
    rf_norm = rf / rf_max if rf_max > 0 else 0.0

    out.write(f"{file}\t{rf_norm}\n")

out.close()
print(f"\nRésultats dans : {output_file}")
