#!/usr/bin/python
# -*- coding: utf-8 -*-

#Input: conllu from udpipe with annotated mwe deprel. If deprel is mwe - concatenate with
#the previous word. output: sentences like:
#Perhaps the prime minister - designate should aim to form an " emergency " rather+than a " national unity " government . 

import xml.etree.ElementTree as et
import sys
import re
from os.path import basename
import itertools
import numpy as np
from StringIO import StringIO

def isa_group_separator(line):
    return line=='\n'

def process_block(block):
    text = []
    for sent in block:
        attributes=sent.split()
        text.append(attributes)
    new_sentence = []
    for sentence in text:
        deprel = sentence[7]
        word = sentence[1]
        parent = sentence[6]
        if deprel != 'mwe':
            new_sentence.append(word)
        else:
            index_sent = text.index(sentence)
            word_prev = text[index_sent -1][1]
            print deprel, word, parent, word_prev
            new_sentence[-1] = word_prev+"+"+word
    print ' '.join(new_sentence)   

def read_corpus_conllu(filename):
    with open(filename) as f:
        data=[]
        while True:
            line = f.readline()
            if not line:
                if data:
                    process_block(data)
                break
            if line == "\n":
                if data:
                    process_block(data)
                    data = []
            else:
                data.append(line)

        
def main():
    argv = sys.argv
    if len(argv) != 2:
        print 'USAGE: %s <parsed corpus in conllu format>' % (argv[0])
        sys.exit(0)
    corpus_filename = argv[1]
    read_corpus_conllu(corpus_filename)

if __name__ == "__main__":
    main()
