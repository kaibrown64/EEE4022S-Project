#!/bin/bash

# split_pcaps.sh
# Created by Kai Brown
# This bash script will loop through a folder of recorded .pcaps, 
# splitting them to smaller files of n packets each, using the 
# Wireshark editpcap tool

APPDIR="/home/kai/Desktop/temp/volume-1/"
INDIR="${APPDIR}full-pcaps/"
OUTDIR="${APPDIR}pcaps/"
echo "---- split_pcaps.sh ----"

# Delete any files from previous runs in OUTDIR
echo "--- trashing old files..."
for filename in ${OUTDIR}*.pcap; do
	#sudo echo ${filename}
	[ -e "$filename" ] || continue
	sudo trash-put $filename
done

# Loop through INDIR for .pcaps
echo "--- Splitting..."
for filename in ${INDIR}*.pcap; do
	#echo "${filename}\n"
	[ -e "$filename" ] || continue
	# Extract resolution and number of test
	TAGS=$(basename "$filename" .pcap)
	RES=$(echo $TAGS | cut -d- -f1)
	NUM=$(echo $TAGS | cut -d- -f2)
	LEN=$(echo $TAGS | cut -d- -f3)
	# split pcap file
	sudo editcap -c100 "${filename}" "${OUTDIR}${RES}-${NUM}-${LEN}"
done


echo "--- Exiting split_pcaps.sh"
