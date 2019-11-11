#!/bin/bash

rm -f *.fst *.pdf

################### Palavras ################
#
#aluna
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols   aluna.txt   | fstarcsort > aluna.fst
echo ""
fstrmepsilon aluna.fst | fsttopsort | fstprint --isymbols=syms.txt
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait aluna.fst | dot -Tpdf  > aluna.pdf

#1 - lemma2noun
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols   lemma2noun.txt   | fstarcsort > lemma2noun.fst
echo ""
fstrmepsilon lemma2noun.fst | fsttopsort | fstprint --isymbols=syms.txt
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2noun.fst | dot -Tpdf  > lemma2noun.pdf


#------
fstcompose aluna.fst lemma2noun.fst > aluna_c.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait aluna.fst | dot -Tpdf > aluna_c.pdf