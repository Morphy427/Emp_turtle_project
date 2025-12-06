# Script for subsampling the first 10 000 lines of a FASTA file

for f in ./genomes/*.fa ; do
	speciesID=`basename $f .fa`
	head -n 10000 $f > ./genomes/ech_genomes/$speciesID\_subSample.fa
done

