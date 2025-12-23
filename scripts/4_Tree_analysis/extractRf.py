import pandas as pd
import sys



def filterRfScores(RfScore):
    if RfScore <= 0.5:
        return RfScore

def extractRF(inputTSV):
    dfOfScore = pd.read_csv(inputTSV, sep="\t", header=0)
    genesFiltered =[]
    for i, line in dfOfScore.iterrows():
        if filterRfScores(line['RF_distance']):
            genesFiltered.append(line['Gene_tree'])
    
    return genesFiltered

def writeList(listOfGenes, outputFile):
    with open(outputFile, 'w') as file:
        for id in listOfGenes:
            file.write(f"{id}\n")



if __name__ == "__main__":
    # inputTable = "EMP/analyse_local_turtle/results_RF.tsv"
    # outpuData = "EMP/analyse_local_turtle/RF_extracted.txt"    
    inputTable = sys.argv[1]
    outpuData = sys.argv[2]
    writeList(extractRF(inputTable), outpuData)
