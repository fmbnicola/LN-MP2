#!/bin/bash

rm -f *.fst *.pdf

################### Palavras ################
#
#aluna
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols   aluna.txt   | fstarcsort > aluna.fst
#infelizmente
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols   infelizmente.txt   | fstarcsort > infelizmente.fst
#lavais
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols   lavais.txt   | fstarcsort > lavais.fst
echo ""
fstrmepsilon aluna.fst | fsttopsort | fstprint --isymbols=syms.txt
fstrmepsilon infelizmente.fst | fsttopsort | fstprint --isymbols=syms.txt
fstrmepsilon lavais.fst | fsttopsort | fstprint --isymbols=syms.txt
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait aluna.fst | dot -Tpdf  > aluna.pdf
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait infelizmente.fst | dot -Tpdf  > infelizmente.pdf
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lavais.fst | dot -Tpdf  > lavais.pdf

# - Word Classes
# 1 - Noun
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols   lemma2noun.txt   | fstarcsort > lemma2noun.fst
echo ""
fstrmepsilon lemma2noun.fst | fsttopsort | fstprint --isymbols=syms.txt
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2noun.fst | dot -Tpdf  > lemma2noun.pdf
# 2 - Adverb
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols   lemma2adverb.txt   | fstarcsort > lemma2adverb.fst
echo ""
fstrmepsilon lemma2adverb.fst | fsttopsort | fstprint --isymbols=syms.txt
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2adverb.fst | dot -Tpdf  > lemma2adverb.pdf
# 3 - Verb Indicative Present
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols   lemma2verbip.txt   | fstarcsort > lemma2verbip.fst
echo ""
fstrmepsilon lemma2verbip.fst | fsttopsort | fstprint --isymbols=syms.txt
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2verbip.fst | dot -Tpdf  > lemma2verbip.pdf

# - Test
# 1 - Noun
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2noun.fst | dot -Tpdf > lemma2noun.pdf
fstcompose aluna.fst lemma2noun.fst > aluna_c.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait aluna_c.fst | dot -Tpdf > aluna_c.pdf
# 2 - Adverb
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2adverb.fst | dot -Tpdf > lemma2adverb.pdf
fstcompose infelizmente.fst lemma2adverb.fst > infelizmente_c.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait infelizmente_c.fst | dot -Tpdf > infelizmente_c.pdf
# 3 - Verb Indicative Present
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2verbip.fst | dot -Tpdf > lemma2verbip.pdf
fstcompose lavais.fst lemma2verbip.fst > lavais_c.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lavais_c.fst | dot -Tpdf > lavais_c.pdf
