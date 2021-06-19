#!/bin/bash

# convert_pcaps.sh
# Created by Kai Brown
# This bash script will loop through a folder of recorded .pcaps, 
# using netmate to convert them to .arffs. A python script
# called label_arffs.py is used to label them with the desired
# resolution, and a script called combine_arffs.py appends
# the data of each .arff file to a single .arff.

APPDIR="/home/kai/Desktop/temp/volume-1/"
INDIR="${APPDIR}pcaps/"
OUTDIR="${APPDIR}arffs/"	
SOURCEFILES="/home/kai/4022S/"
echo "---- convert_pcaps.sh ----"

# Delete any files from previous runs in OUTDIR
echo "--- trashing old files..."
for filename in ${OUTDIR}*.arff; do
	#sudo echo ${filename}
	[ -e "$filename" ] || continue
	sudo trash-put $filename
done

# Loop through INDIR for .pcaps
echo "--- Converting and labelling..."
cd $INDIR
for filename in ${INDIR}*.pcap; do
	#echo "${filename}\n"
	[ -e "$filename" ] || continue
	# Extract resolution and number of test
	TAGS=$(basename "$filename" .pcap)
	RES=$(echo $TAGS | cut -d- -f1)
	NUM=$(echo $TAGS | cut -d- -f2)
	echo $RES
	echo $NUM
	#echo "${TAGS}\n"
	# Convert each pcap file to arff using netmate
	sudo netmate -r /usr/local/etc/netmate/netAI-rules-stats-ni.xml -f $filename
	# Run python script to label the data and delete netmate.arff
	# Arguments: inputFile, outputFile, resolution, testNumber
	python3 ${SOURCEFILES}label_arff.py "${OUTDIR}netmate.arff" "${OUTDIR}${RES}-${NUM}.arff" "$RES" "$NUM"
done

echo "--- Combining .arffs..."
# Combine all the labelled .arffs to trainingData.arff in APPDIR
# Arguments: inputFolder, outputFile
python3 ${SOURCEFILES}combine_arffs.py "$OUTDIR" "${APPDIR}trainingData.arff"

echo "--- Exiting convert_pcaps.sh"
