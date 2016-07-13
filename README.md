## Parsing parallel corpora with udpipe to compare MWEs in Hebrew and English

Universal Dependencies treebanks feature [MWE annotation](http://universaldependencies.org/u/dep/mwe.html). The dependency relation (deprel) 'mwe' is related mostly to functional mwes, e.g. multiword prepositions. First, we will extract the alignments for mwes from the parsed English-Hebrew corpus Haaretz:

1. Parse Haarezt with [UDpipe](https://ufal.mff.cuni.cz/udpipe)  
2. Concatenate the modes marked with mwe into one, e.g. *as well as* -> *as+well+as*
3. Run GIZA++ alignment



