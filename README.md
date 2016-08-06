## Parsing parallel corpora with udpipe to compare MWEs in Hebrew and English

Universal Dependencies treebanks feature [MWE annotation](http://universaldependencies.org/u/dep/mwe.html). The dependency relation (deprel) 'mwe' is related mostly to functional mwes, e.g. multiword prepositions. First, we will extract the alignments for mwes from the parsed English-Hebrew corpus Haaretz:

1. Parse Haarezt with [UDpipe](https://ufal.mff.cuni.cz/udpipe)  
2. Concatenate the modes marked with mwe into one, e.g. *as well as* -> *as+well+as*
3. Run GIZA++ alignment

### Parsing with UDPipe
Examples of the parsed sentences (not parallel, containing mwe):

```
1       Perhaps perhaps ADV     RB      _       4       advmod  _       _
2       the     the     DET     DT      Definite=Def|PronType=Art       4       det     _       _
3       prime   prime   ADJ     JJ      Degree=Pos      4       amod    _       _
4       minister        minister        NOUN    NN      Number=Sing     6       compound        _       SpaceAfter=No
5       -       -       PUNCT   HYPH    _       6       punct   _       SpaceAfter=No
6       designate       designate       NOUN    NN      Number=Sing     8       nsubj   _       _
7       should  should  AUX     MD      VerbForm=Fin    8       aux     _       _
8       aim     aim     VERB    VB      VerbForm=Inf    0       root    _       _
9       to      to      PART    TO      _       10      mark    _       _
10      form    form    VERB    VB      VerbForm=Inf    8       xcomp   _       _
11      an      a       DET     DT      Definite=Ind|PronType=Art       13      det     _       _
12      "       "       PUNCT   ``      _       13      punct   _       SpaceAfter=No
13      emergency       emergency       NOUN    NN      Number=Sing     10      dobj    _       SpaceAfter=No
14      "       "       PUNCT   ''      _       13      punct   _       _
15      rather  rather  ADV     RB      _       22      case    _       _
16      than    than    ADP     IN      _       15      mwe     _       _
17      a       a       DET     DT      Definite=Ind|PronType=Art       22      det     _       _
18      "       "       PUNCT   ``      _       20      punct   _       SpaceAfter=No
19      national        national        ADJ     JJ      Degree=Pos      20      amod    _       _
20      unity   unity   NOUN    NN      Number=Sing     22      compound        _       SpaceAfter=No
21      "       "       PUNCT   ''      _       20      punct   _       _
22      government      government      NOUN    NN      Number=Sing     10      nmod    _       SpaceAfter=No
23      .       .       PUNCT   .       _       8       punct   _       _

```
HEbrew parse:
```
1-2     מאז     _       _       _       _       _       _       _       _
1       מ       _       ADP     ADP     _       8       advmod  _       _
2       אז      _       ADV     ADV     _       1       mwe     _       _
3       99      _       NUM     NUM     _       1       mwe     _       _
4       '       _       PUNCT   PUNCT   _       8       punct   _       _
5-6     האוניברסיטאות   _       _       _       _       _       _       _       _
5       ה       _       DET     DET     PronType=Art    6       det:def _       _
6       אוניברסיטאות    _       NOUN    NOUN    Gender=Fem|Number=Plur  8       nsubj   _       _
7       אינן    _       VERB    VERB    Gender=Fem|Negative=Neg|Number=Plur|Person=3|VerbForm=Part|VerbType=Cop 8       neg     _       _
8       מאפשרות _       AUX     AUX     Gender=Fem|Number=Plur|VerbForm=Part|VerbType=Mod       0       root    _       _
9-11    לממונה  _       _       _       _       _       _       _       _
9       ל       _       ADP     ADP     _       11      case    _       _
10      ה_      _       DET     DET     PronType=Art    11      det:def _       _
11      ממונה   _       NOUN    NOUN    Gender=Masc|Number=Sing 8       iobj    _       _
12      לפקח    _       VERB    VERB    HebBinyan=PIEL|VerbForm=Inf     8       xcomp   _       _
13-14   עליהן   _       _       _       _       _       _       _       _
13      עליהן   _       ADP     ADP     _       14      case    _       _
14      הן_     _       PRON    PRON    Gender=Fem|Number=Plur|Person=3|PronType=Prs    12      nmod    _       _
15      .       _       PUNCT   PUNCT   _       8       punct   _       _

```
### Some issues with parsing Haaretz

During parsing, I encountered some problems with m:n alignment and sentence segmentation that come from the original parallel corpus. Compare the content of files heb/Haaretz_2009_03_23.txt_heb.snt.aligned and eng/Haaretz_2009_03_23.txt_eng.snt.aligned
```
 דיווח : יחידת קומנדו נחתה בסוריה חודש לפני הפצצת הכור. יו.סי מלמן 
```
```
The Associated Press.
```
The output of the parser:
```
1       דיווח   _       NOUN    NOUN    Gender=Masc|Number=Sing 0       root    _       _
2       :       _       PUNCT   PUNCT   _       1       punct   _       _
3       יחידת   _       NOUN    NOUN    Definite=Red|Gender=Fem|Number=Sing     5       nsubj   _       _
4       קומנדו  _       NOUN    NOUN    Gender=Masc|Number=Sing 3       nmod:smixut     _       _
5       נחתה    _       VERB    VERB    Gender=Fem|Number=Sing|Person=3|Tense=Past      1       conj:discourse  _       _
6       בסוריה  _       ADP     ADP     _       7       case    _       _
7       חודש    _       NOUN    NOUN    Gender=Masc|Number=Sing 5       nmod    _       _
8       לפני    _       ADP     ADP     _       9       case    _       _
9       הפצצת   _       NOUN    NOUN    Definite=Red|Gender=Fem|Number=Sing     7       nmod    _       _
10-11   הכור    _       _       _       _       _       _       _       SpaceAfter=No
10      ה       _       DET     DET     PronType=Art    11      det:def _       _
11      כור     _       NOUN    NOUN    Gender=Masc|Number=Sing 9       nmod:smixut     _       _
12      .       _       PUNCT   PUNCT   _       1       punct   _       _

1       יוסי    _       PROPN   PROPN   _       0       root    _       _
2       מלמן    _       PROPN   PROPN   _       1       name    _       _
3       .       _       PUNCT   PUNCT   _       1       punct   _       _
```
```
1       The     the     DET     DT      Definite=Def|PronType=Art       3       det     _       _
2       Associated      associated      PROPN   NNP     Number=Sing     3       compound        _       _
3       Press   Press   PROPN   NNP     Number=Sing     0       root    _       SpaceAfter=No
4       .       .       PUNCT   .       _       3       punct   _       _
```

Because it can't be predicted how the parser will segment the sentences, it is impossible(IMHO) to properly parallalize the corpus without some larger efforts. Though, some hacking can be done: before parsing, insert the <align id="x"> number before each sentence, and after parsing substitute accordingly to vert format.  
