#/bin/bash
INPUT_PATH_ENG=/net/cluster/TMP/kljueva/kontext/ud/udpipe_hebrew/input/corpus/eng
INPUT_PATH_HEB=/net/cluster/TMP/kljueva/kontext/ud/udpipe_hebrew/input/corpus/heb
OUTPUT_PATH=/net/cluster/TMP/kljueva/kontext/ud/udpipe/output

#/net/projects/udpipe/bin/udpipe-latest /net/projects/udpipe/models/udpipe-ud-1.2-160523/english-ud-1.2-160523.udpipe --tokenize --tag --parse --outfile=/net/cluster/TMP/kljueva/kontext/ud/udpipe_hebrew/output/{}.conllu /net/cluster/TMP/kljueva/kontext/ud/udpipe_hebrew/input/corpus/eng/head100.en.txt

/net/projects/udpipe/bin/udpipe-latest /net/projects/udpipe/models/udpipe-ud-1.2-160523/hebrew-ud-1.2-160523.udpipe --tokenize --tag --parse --outfile=/net/cluster/TMP/kljueva/kontext/ud/udpipe_hebrew/output/{}.conllu /net/cluster/TMP/kljueva/kontext/ud/udpipe_hebrew/input/corpus/heb/head100.he.txt


