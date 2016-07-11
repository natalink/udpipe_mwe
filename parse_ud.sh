#/bin/bash
ROOT_FOLDER=/net/cluster/TMP/kljueva/kontext/ud/udpipe
INPUT_PATH=/net/cluster/TMP/kljueva/kontext/ud/udpipe/input
OUTPUT_PATH=/net/cluster/TMP/kljueva/kontext/ud/udpipe/output


for file in $(find $INPUT_PATH -name '*.txt' -print)
do
      curl -F 'data=@input_file' -F '@lang' http://lindat.mff.cuni.cz/services/udpipe/api/process;

done

