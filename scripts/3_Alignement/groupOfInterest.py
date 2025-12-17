#! /bin/python

import sys

# In and out path 
inputfile = sys.argv[1]
outputFolder = sys.argv[2]

def isCountSeqOk(input_filename):
    """read the """
    #lecture du fichier fasta
    with open (input_filename, "r") as file:
    
        count_seq = 0
        str_file = file.readlines()
        for line in str_file:
            if line.startswith(">"):
                count_seq += 1
        
        return (count_seq > 15 and count_seq < 50)
    

def writeOut(outputFilename, fileName):
    with open(outputFilename, "a") as file:
            file.write(f"{str(fileName)}\n")


if __name__ == "__main__":
    if isCountSeqOk(inputfile):
        writeOut(outputFolder+"listOfGroup.txt", inputfile)
        print(f"added: {inputfile}")


    