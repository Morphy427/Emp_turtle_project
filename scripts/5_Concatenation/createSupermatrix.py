#! /usr/bin/env python3

import os
import sys
from collections import defaultdict
from Bio import SeqIO


# -------------------------------------------

def build_supermatrix(fasta_dir, output_fasta, output_partition):
    print("--- Démarrage de la concaténation ---")
    
    # 1. Récupération de la liste des fichiers
    fasta_files = sorted([
        f for f in os.listdir(fasta_dir)
        if f.endswith((".fa", ".fasta", ".faa", ".fna", ".aln")) 
    ])

    if not fasta_files:
        sys.exit(f"Erreur : Aucun fichier FASTA trouvé dans {fasta_dir}")

    print(f"-> {len(fasta_files)} alignements trouvés.")

    # 2. PREMIÈRE PASSE : Identifier TOUTES les espèces présentes
    # C'est crucial pour éviter les décalages si une espèce manque dans les premiers gènes
    print("-> Scan des espèces (Passe 1)...")
    all_species = set()
    
    for fasta in fasta_files:
        path = os.path.join(fasta_dir, fasta)
        # On lit juste les headers pour aller vite
        with open(path, 'r') as f:
            for line in f:
                if line.startswith('>'):
                    # Nettoyage simple du nom (retire le > et les espaces)
                    sp_name = line.strip()[1:].split()[0]
                    all_species.add(sp_name)
    
    sorted_species = sorted(list(all_species))
    print(f"-> {len(sorted_species)} espèces identifiées au total.")

    # 3. SECONDE PASSE : Construction de la matrice et des partitions
    print("-> Construction de la supermatrice (Passe 2)...")
    
    supermatrix = {sp: "" for sp in sorted_species}
    partition_lines = []
    current_pos = 1  # IQ-TREE commence à compter à 1
    
    for fasta in fasta_files:
        path = os.path.join(fasta_dir, fasta)
        records = list(SeqIO.parse(path, "fasta"))

        if not records:
            continue

        # Vérification de la longueur de l'alignement
        aln_length = len(records[0].seq)
        gene_name = os.path.splitext(fasta)[0] # Nom du gène sans extension

        # Dictionnaire temporaire pour ce gène
        seqs_in_gene = {}
        for r in records:
            if len(r.seq) != aln_length:
                print(f"ATTENTION : Longueur incohérente dans {fasta}. Ignoré.")
                continue
            # Nettoyage ID (garde le premier mot avant espace)
            sp_id = r.id.split()[0] 
            seqs_in_gene[sp_id] = str(r.seq)

        # Remplissage de la supermatrice
        for sp in sorted_species:
            if sp in seqs_in_gene:
                supermatrix[sp] += seqs_in_gene[sp]
            else:
                # Si l'espèce est absente de ce gène, on met des gaps
                supermatrix[sp] += "-" * aln_length

        # Enregistrement de la partition
        end_pos = current_pos + aln_length - 1
        # Format : DNA, NomGene = Debut-Fin
        partition_lines.append(f"{gene_name} = {current_pos}-{end_pos}")
        
        current_pos += aln_length

    # 4. Écriture du fichier Supermatrice (Format FASTA ou PHYLIP)
    # Ici format FASTA séquentiel (plus simple à lire)
    print(f"-> Écriture de la matrice : {output_fasta}")
    os.makedirs(os.path.dirname(output_fasta), exist_ok=True)
    
    with open(output_fasta, "w") as out:
        for sp in sorted_species:
            out.write(f">{sp}\n")
            out.write(f"{supermatrix[sp]}\n")

    # 5. Écriture du fichier de Partitions (Format NEXUS)
    print(f"-> Écriture des partitions : {output_partition}")
    with open(output_partition, "w") as out:
        out.write("#nexus\n")
        out.write("begin sets;\n")
        for line in partition_lines:
            out.write(f"\tcharset {line};\n")
        out.write("end;\n")

    print("--- Terminé avec succès ---")

if __name__ == "__main__":
    build_supermatrix(sys.argv[1], sys.argv[2], sys.argv[3])