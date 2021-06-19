#!/bin/bash

# live_classifier.sh
# Created by Kai Brown
# This bash script will loop infinitely, recording a .pcap, 
# using netmate to convert it to a .arff. Weka's CLI
# is then used to add the resolution attribute, with ? labels.
# The previously saved weka classifier is then used to make a prediction
# on the captured packets, and append the output to a text file


APPDIR="/home/kai/Desktop/temp/volume-1/"
PCAPS="${APPDIR}pcaps/"
ARFFS="${APPDIR}arffs/"
WEKADIR="/home/kai/weka-3-8-5/"

# Loop until terminated predicting traffic:
while :; do
	# Delete files from previous iteration
	if test -f "${PCAPS}LIVE.pcap"; then
		echo "deleting ${PCAPS}LIVE.pcap"
		sudo trash-put "${PCAPS}LIVE.pcap"
	fi

	if test -f "${ARFFS}netmate.arff"; then
		echo "deleting ${ARFFS}netmate.arff"
		sudo trash-put "${ARFFS}netmate.arff"
	fi

	if test -f "${ARFFS}LIVE1.arff"; then
		echo "deleting ${ARFFS}LIVE1.arff"
		sudo trash-put "${ARFFS}LIVE1.arff"
	fi

	if test -f "${ARFFS}LIVE2.arff"; then
		echo "deleting ${ARFFS}LIVE2.arff"
		sudo trash-put "${ARFFS}LIVE2.arff"
	fi

	# Record 30 packets of traffic
	sudo tcpdump -i enp0s3 -w "${PCAPS}LIVE.pcap" -c 30
	# Analyse the recorded packets to .arff
	# output is netmate.arff in /home/kai/Desktop/test/volume-1/arffs/netmate.arff
	sudo netmate -r /usr/local/etc/netmate/netAI-rules-stats-ni.xml -f "${PCAPS}LIVE.pcap"
	# Remove the source and destination IP addresses and ports
	sudo java -cp "${WEKADIR}weka.jar" weka.filters.unsupervised.attribute.Remove -R 1,2,3,4 -i "${ARFFS}netmate.arff" -o "${ARFFS}LIVE1.arff"
	# Label the traffic with a ? class
	sudo java -cp "${WEKADIR}weka.jar" weka.filters.unsupervised.attribute.Add -T NOM -N resolution -L 144p,240p,360p,480p,720p -C last -W 1.0 -i "${ARFFS}LIVE1.arff" -o "${ARFFS}LIVE2.arff"
	# Classify the .arff file and save results to .txt
	sudo java -cp "${WEKADIR}weka.jar" weka.classifiers.trees.RandomForest -T "${ARFFS}LIVE2.arff" -l "${APPDIR}randomForest.model" -p 0 | tee -a "${APPDIR}classifications.txt"
	echo "Press [CTRL+C] to stop.."
	sleep 5
done





