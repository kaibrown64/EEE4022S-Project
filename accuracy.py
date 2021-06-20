# Accuracy.py
# Created by Kai Brown
# read a classifier output file, and count the number of correct guesses
# Also counts the number of total guesses, and calculates the accuracy
import sys

filename = sys.argv[1]
resolution = sys.argv[2]

print("Accuracy of : " + filename)

#get file object reference to the file
with open(filename, "r") as file:
    #read content of file to string
    data = file.read()

    #get number of occurrences resolution
    correct = data.count(str(resolution))

    #get number of total guesses
    total = data.count("1:?")

accuracy = (100*correct/total)

print('Total Guesses : ', total)
print('Correct Guesses : ', correct)
print('Accuracy :', accuracy, '%')

