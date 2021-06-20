# Created by Kai Brown 
# Label .arff files and possibly delete unecessary flows

# Libraries
import sys
import arff
import os

# Variables
folder_in = sys.argv[1] # Folder containing only .arffs
file_out = sys.argv[2] # Ouput combined .arff

def main():
    print("___Combining arffs___")
    inputFiles = os.listdir(folder_in)
    # Open the first file, and append the rest
    with open(folder_in + inputFiles[0], 'r') as mainFile:
        for num, file in enumerate(inputFiles):
            if num == 0:
                print(folder_in + inputFiles[0])
                mainArff = arff.load(mainFile)
            else:
                with open(folder_in + file, 'r') as temp:
                    print(folder_in + file)
                    arffDict = arff.load(temp)
                    for line in arffDict['data']:
                        mainArff['data'].append(line)
        #save ouput to a file
        with open(file_out, 'w') as target:
            arff.dump(mainArff, target)
    print("done!")
    
# Don't run main on import:
if __name__ == '__main__':
    main()
