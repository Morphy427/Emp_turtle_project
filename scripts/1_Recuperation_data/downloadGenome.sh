#! /bin/bash
#SBATCH --job-name=download
#SBATCH --mail-type=ALL
#SBATCH --mail-user=nicolas.vitry@etudiant.univ-rennes.fr
#SBATCH -o logs/downloadSeq.out

echo "Début du téléchargement des séquences"
# File to get all genomes nedeed
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/049/634/645/GCF_049634645.1_ASM4963464v1/GCF_049634645.1_ASM4963464v1_protein.faa.gz -O genomes/Pelodiscus_sinensis.fna.gz
gunzip genomes/Pelodiscus_sinensis.fna.gz 

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/013/100/865/GCF_013100865.1_CAS_Tse_1.0/GCF_013100865.1_CAS_Tse_1.0_protein.faa.gz -O genomes/Trachemys_scripta_elegans.fna.gz
gunzip genomes/Trachemys_scripta_elegans.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/015/237/465/GCF_015237465.2_rCheMyd1.pri.v2/GCF_015237465.2_rCheMyd1.pri.v2_protein.faa.gz -O genomes/Chelonia_mydas.fna.gz
gunzip genomes/Chelonia_mydas.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/011/386/835/GCF_011386835.1_ASM1138683v2/GCF_011386835.1_ASM1138683v2_protein.faa.gz -O genomes/Chrysemys_picta_bellii.fna.gz
gunzip Chrysemys_picta_bellii.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/016/161/935/GCF_016161935.1_ASM1616193v1/GCF_016161935.1_ASM1616193v1_protein.faa.gz -O genomes/Mauremys_reevesii.fna.gz
gunzip Mauremys_reevesii.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/965/140/235/GCF_965140235.1_rCarCar1.hap1/GCF_965140235.1_rCarCar1.hap1_protein.faa.gz -O genomes/Caretta_carett.fna.gz
gunzip genomes/Caretta_carett.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/027/887/155/GCF_027887155.1_rMalTer1.hap1/GCF_027887155.1_rMalTer1.hap1_protein.faa.gz -O genomes/Malaclemys_terrapin_pileata.fna.gz
gunzip genomes/Malaclemys_terrapin_pileata.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/020/497/125/GCF_020497125.1_ASM2049712v1/GCF_020497125.1_ASM2049712v1_protein.faa.gz -O genomes/Mauremys_mutica.fna.gz
gunzip genomes/Mauremys_mutica.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/009/764/565/GCF_009764565.3_rDerCor1.pri.v4/GCF_009764565.3_rDerCor1.pri.v4_protein.faa.gz -O genomes/Dermochelys_coriacea.fna.gz
gunzip genomes/Dermochelys_coriacea.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/033/958/435/GCF_033958435.1_ASM3395843v1/GCF_033958435.1_ASM3395843v1_protein.faa.gz -O genomes/Carettochelys_insculpta.fna.gz
gunzip genomes/Carettochelys_insculpta.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/030/867/095/GCF_030867095.1_rAllMis1/GCF_030867095.1_rAllMis1_protein.faa.gz -O genomes/Alligator_mississippiensis.fna.gz
gunzip genomes/Alligator_mississippiensis.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/009/819/535/GCF_009819535.1_rLacAgi1.pri/GCF_009819535.1_rLacAgi1.pri_protein.faa.gz -O genomes/Lacerta_agilis.fna.gz
gunzip genomes/Lacerta_agilis.fna.gz

echo "Fin du téléchargement des séquences"