# Run tcpdump from desktop on enp0s3 (or your interface of choice)
# timeout after 660 seconds (11 mins) and save packets capture in volume-1/pcaps
sudo timeout 900 tcpdump -i enp0s3 -w ~/Desktop/temp/volume-1/15-min-pcaps/144p-1.pcap
# run selenium script youtube_selenium.py, watching a random video for 10 minutes
python3 ~/Desktop/volume-1/youtube_selenium.py 144p
# Use netmate to exctract traffic flows
sudo netmate -r /usr/local/etc/netmate/netAI-rules-stats-ni.xml -f ~/Desktop/volume-1/pcaps_cleaned/144p-1.pcap
# Run weka to train the classifier
./weka.sh

sudo python3 /home/kai/Desktop/volume-1/labelarff.py /home/kai/Desktop/volume-1/arffs/netmate.arff /home/kai/Desktop/volume-1/arffs/144p-3.arff 144p 3 

sudo netmate -r /usr/local/etc/netmate/netAI-rules-stats-ni.xml -f ~/Desktop/volume-1/pcaps/144p-2.pcap