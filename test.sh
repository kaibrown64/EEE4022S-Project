JB="home/kai/JEFFFF-BROOO.pcap"
jbbase=$(basename "$JB" .pcap)
jeff=$(echo $jbbase | cut -d- -f1)
bro=$(echo $jbbase | cut -d- -f2)
echo $JB
echo $jbbase
echo $jeff
echo $bro
echo $jbbase | cut -d- -f1
echo $jbbase | cut -d- -f2
