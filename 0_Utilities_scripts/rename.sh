# Script to rename ".fna" file in ".fa" file

for f in ./genomes/*.fna ; do
	speciesID=`basename $f .fna`
	mv $f genomes/$speciesID.fa
done