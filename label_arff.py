# Created by Kai Brown 
# Label .arff files and possibly delete unecessary flows

# Libraries
import sys
import arff
import os

# Variables
file_in = sys.argv[1] # File from netmate-flowcalc
file_out = sys.argv[2] # Ouput labelled .arff
resolution = sys.argv[3] # Resolution of this file
testNumber = sys.argv[4] # Number of this file
testLen = sys.argv[5] #length of file
secret_arff = "/home/kai/Desktop/volume-1/arffs/netmate.arff" # netmate sometimes saves here
# List of all resolutions in class:
resList = ['144p', '240p', '360p', '480p', '720p']


def main():
    print("Labelling " + resolution + '-' + testNumber + '-' + testLen + "...")
    # Load in output from netmate-flowcalc and label the resolution
    with open(file_in, 'r') as file:
        arffDict = arff.load(file)
        #print("labelling data...")
        # Add resList as the last attribute
        arffDict['attributes'].append(('resolution', resList))
        # Label every line in the file with file's resolution
        for line in arffDict['data']:
            line.append(resolution)
        #save ouput to a file
        if arffDict['data']:
            with open(file_out, 'w') as target:
                arff.dump(arffDict, target)
            print("saved!")
        else:
            print("EMPTY DATA FILE-------------------------------------------------------------")
    print("removing old netmate.arff...")
    os.remove(file_in)
    if os.path.isfile(secret_arff):
        print("removing secret netmate.arff...")
        os.remove(secret_arff)
    print("done")

# Don't run main on import:
if __name__ == '__main__':
    main()

