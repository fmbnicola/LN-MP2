#!/bin/bash

rm -f *.fst *.pdf

# Lemma
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols   lemma.txt   | fstarcsort > lemma.fst
echo ""
fstrmepsilon lemma.fst | fsttopsort | fstprint --isymbols=syms.txt
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lemma.fst | dot -Tpdf  > lemma.pdf

# Noun
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols   noun.txt   | fstarcsort > noun.fst
echo ""
fstrmepsilon noun.fst | fsttopsort | fstprint --isymbols=syms.txt
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait noun.fst | dot -Tpdf  > noun.pdf

# Test
fstconcat lemma.fst noun.fst > lemma2noun.fst
echo ""
fstrmepsilon lemma2noun.fst | fsttopsort | fstprint --isymbols=syms.txt
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2noun.fst | dot -Tpdf  > lemma2noun.pdf
