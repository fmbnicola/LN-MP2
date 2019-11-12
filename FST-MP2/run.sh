#!/bin/bash

rm -f *.fst *.pdf

# - Lemma
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols lemma.txt | fstarcsort > lemma.fst

# - Word Classes
# 1 - Noun
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols noun.txt | fstarcsort > noun.fst
# 2 - Adverb
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols adverb.txt | fstarcsort > adverb.fst
# 3 - Verb Indicative Present
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols verbip.txt | fstarcsort > verbip.fst
# 3 - Verb Indicative Past
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols verbis.txt | fstarcsort > verbis.fst
# 3 - Verb Indicative Future
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols verbif.txt | fstarcsort > verbif.fst

# a. Concantenate
# 1 - Noun
fstconcat lemma.fst noun.fst > lemma2noun.fst
echo ""
fstrmepsilon lemma2noun.fst lemma2noun.fst
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2noun.fst | dot -Tpdf > lemma2noun.pdf

# 2 - Adverb
fstconcat lemma.fst adverb.fst > lemma2adverb.fst
echo ""
fstrmepsilon lemma2adverb.fst lemma2adverb.fst
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2adverb.fst | dot -Tpdf > lemma2adverb.pdf

# 3 - Verb Indicative Present
fstconcat lemma.fst verbip.fst > lemma2verbip.fst
echo ""
fstrmepsilon lemma2verbip.fst lemma2verbip.fst
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2verbip.fst | dot -Tpdf > lemma2verbip.pdf

# 4 - Verb Indicative Past
fstconcat lemma.fst verbis.fst > lemma2verbis.fst
echo ""
fstrmepsilon lemma2verbis.fst lemma2verbis.fst
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2verbis.fst | dot -Tpdf > lemma2verbis.pdf

# 5 - Verb Indicative Future
fstconcat lemma.fst verbif.fst > lemma2verbif.fst
echo ""
fstrmepsilon lemma2verbif.fst lemma2verbif.fst
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2verbif.fst | dot -Tpdf > lemma2verbif.pdf

# b. Unite
# 1 - Verbs
fstunion verbis.fst verbip.fst > verbips.fst
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait verbips.fst | dot -Tpdf > verbips.pdf

fstunion verbif.fst verbips.fst > verb.fst
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait verb.fst | dot -Tpdf > verb.pdf

fstconcat lemma.fst verb.fst > lemma2verb.fst
fstrmepsilon lemma2verb.fst lemma2verb.fst
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2verb.fst | dot -Tpdf > lemma2verb.pdf

# 2 - Lemma to Words
fstunion verb.fst adverb.fst > verb_adverb.fst
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait verbips.fst | dot -Tpdf > verbips.pdf

fstunion verb_adverb.fst noun.fst > word.fst
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait verb.fst | dot -Tpdf > verb.pdf

fstconcat lemma.fst word.fst > lemma2word.fst
fstrmepsilon lemma2word.fst lemma2word.fst
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2word.fst | dot -Tpdf > lemma2word.pdf

# 3 - Word to Lemma
fstinvert lemma2word.fst word2lemma.fst
fstrmepsilon word2lemma.fst word2lemma.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait word2lemma.fst | dot -Tpdf > word2lemma.pdf

# - Test 1

# 1 - Noun
#aluna
#fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols aluna.txt | fstarcsort > aluna.fst
#fstrmepsilon aluna.fst | fsttopsort | fstprint --isymbols=syms.txt
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait aluna.fst | dot -Tpdf  > aluna.pdf
#echo ""
#fstcompose aluna.fst lemma2noun.fst > aluna_c.fst
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait aluna_c.fst | dot -Tpdf > aluna_c.pdf

# 2 - Adverb
#infelizmente
#fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols infelizmente.txt | fstarcsort > infelizmente.fst
#fstrmepsilon infelizmente.fst | fsttopsort | fstprint --isymbols=syms.txt
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait infelizmente.fst | dot -Tpdf  > infelizmente.pdf
#echo ""
#fstcompose infelizmente.fst lemma2adverb.fst > infelizmente_c.fst
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait infelizmente_c.fst | dot -Tpdf > infelizmente_c.pdf

# 3 - Verb Indicative Present
#lavais
#fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols lavais.txt | fstarcsort > lavais.fst
#fstrmepsilon lavais.fst | fsttopsort | fstprint --isymbols=syms.txt
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lavais.fst | dot -Tpdf  > lavais.pdf
#echo ""
#fstcompose lavais.fst lemma2verbip.fst > lavais_c.fst
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lavais_c.fst | dot -Tpdf > lavais_c.pdf

# 4 - Verb Indicative Past
#lavei
#fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols lavei.txt | fstarcsort > lavei.fst
#fstrmepsilon lavei.fst | fsttopsort | fstprint --isymbols=syms.txt
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lavei.fst | dot -Tpdf  > lavei.pdf
#echo ""
#fstcompose lavei.fst lemma2verbis.fst > lavei_c.fst
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lavei_c.fst | dot -Tpdf > lavei_c.pdf

# 5 - Verb Indicative Future
#lavarao
#fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols lavarao.txt | fstarcsort > lavarao.fst
#fstrmepsilon lavarao.fst | fsttopsort | fstprint --isymbols=syms.txt
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lavarao.fst | dot -Tpdf  > lavarao.pdf
#echo ""
#fstcompose lavarao.fst lemma2verbif.fst > lavarao_c.fst
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lavarao_c.fst | dot -Tpdf > lavarao_c.pdf

# - Test 2

# 1 - Noun
#aluna
#fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols aluna.txt | fstarcsort > aluna.fst
#fstrmepsilon aluna.fst | fsttopsort | fstprint --isymbols=syms.txt
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait aluna.fst | dot -Tpdf  > aluna.pdf
#echo ""
#fstcompose aluna.fst lemma2word.fst > aluna_c.fst
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait aluna_c.fst | dot -Tpdf > aluna_c.pdf

# 2 - Adverb
#infelizmente
#fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols infelizmente.txt | fstarcsort > infelizmente.fst
#fstrmepsilon infelizmente.fst | fsttopsort | fstprint --isymbols=syms.txt
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait infelizmente.fst | dot -Tpdf  > infelizmente.pdf
#echo ""
#fstcompose infelizmente.fst lemma2word.fst > infelizmente_c.fst
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait infelizmente_c.fst | dot -Tpdf > infelizmente_c.pdf

# 3 - Verb Indicative Present
#lavais
#fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols lavais.txt | fstarcsort > lavais.fst
#fstrmepsilon lavais.fst | fsttopsort | fstprint --isymbols=syms.txt
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lavais.fst | dot -Tpdf  > lavais.pdf
#echo ""
#fstcompose lavais.fst lemma2word.fst > lavais_c.fst
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lavais_c.fst | dot -Tpdf > lavais_c.pdf

# - Test 3

# 1 - Noun
#alunas
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols aluno_N_fp.txt | fstarcsort > aluno_N_fp.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait aluno_N_fp.fst | dot -Tpdf  > aluno_N_fp.pdf
echo ""
fstcompose aluno_N_fp.fst word2lemma.fst > aluno_N_fp_c.fst
fstprint --isymbols=syms.txt aluno_N_fp_c.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait aluno_N_fp_c.fst | dot -Tpdf > aluno_N_fp_c.pdf

#lavamos
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols lavar_V_pi_1p.txt | fstarcsort > lavar_V_pi_1p.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lavar_V_pi_1p.fst | dot -Tpdf  > lavar_V_pi_1p.pdf
echo ""
fstcompose lavar_V_pi_1p.fst word2lemma.fst > lavar_V_pi_1p_c.fst
fstprint --isymbols=syms.txt lavar_V_pi_1p_c.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait lavar_V_pi_1p_c.fst | dot -Tpdf > lavar_V_pi_1p_c.pdf
