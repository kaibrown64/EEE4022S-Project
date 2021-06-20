EEE4022S Project 2021
Author: Kai Brown
Supervisor: Joyce Mwangama
Electrical Engineering Department
University of Cape Town

Inferring the Resolution of Encrypted Youtube Streaming Traffic using Machine Learning

=== Summary ===
This github contains all the source code and packet capture data used in the Undergraduate thesis Inferring the Resolution of Encrypted Youtube Streaming Traffic using Machine Learning.
This project involved recording encryted traffic of youtube being watched at different qualities, and training machine learning classifiers to predict the quality.

=== Requirements ===
This project was run on an Ubuntu 20.04 LTS Virtual Machine
pip v21.1.2
python v3.8.5
Java JDK v11.0.11
Java JRE v11.0.11
Selenium v3.141.0
Wireshark v3.2.3
Netmate flow-calc v0.9.5
weka v3.8.5

== Source Code ===
---selenium_youtube.py
automatically visits youtube, selects a random video, and changes the quality to a set figure.

---split_pcaps.sh
Uses editcap from Wireshark to separate internet traffic, recorded with tcpdump on enp0s3 (VM ethernet NAT), to smaller files of a given packet count

--convert_pcaps.sh
Invokes netmate on individual pcap files, labels .arff files with resolution, and combines them to one .arff

--live_classifier.sh
A permanent bash loop that records a set amount of packets, invokes netmate to make it a .arff, removes source and destination ip addresses and ports, 
and uses a saved model to make a prediction on the data.

--accuracy.py
Calculates the accuracy of live classification outputs, scanning the ouput file as a string and searching for predictions



