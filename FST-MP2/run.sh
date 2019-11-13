#!/bin/bash

rm -f *.fst *.pdf

# - create folders
rm -r FINALtransducers
rm -r AUXtransducers
rm -r FINALexamples
rm -r FINALpdf
rm -r TXTexamples
rm -r FSTexamples
mkdir FINALtransducers
mkdir AUXtransducers
mkdir FINALexamples
mkdir FINALpdf
mkdir TXTexamples
mkdir FSTexamples

# - Lemma
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols INItransducers/lemma.txt | fstarcsort > AUXtransducers/lemma.fst

# - Word Classes
# 1 - Noun
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols INItransducers/noun.txt | fstarcsort > AUXtransducers/noun.fst
# 2 - Adverb
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols INItransducers/adverb.txt | fstarcsort > AUXtransducers/adverb.fst
# 3 - Verb Indicative Present
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols INItransducers/verbip.txt | fstarcsort > AUXtransducers/verbip.fst
# 4 - Verb Indicative Past
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols INItransducers/verbis.txt | fstarcsort > AUXtransducers/verbis.fst
# 5 - Verb Indicative Future
fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols INItransducers/verbif.txt | fstarcsort > AUXtransducers/verbif.fst

# a. Concantenate
# 1 - Noun
fstconcat AUXtransducers/lemma.fst AUXtransducers/noun.fst > FINALtransducers/lemma2noun.fst
echo ""
fstrmepsilon FINALtransducers/lemma2noun.fst FINALtransducers/lemma2noun.fst
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2noun.fst | dot -Tpdf > FINALpdf/lemma2noun.pdf

# 2 - Adverb
fstconcat AUXtransducers/lemma.fst AUXtransducers/adverb.fst > FINALtransducers/lemma2adverb.fst
echo ""
fstrmepsilon FINALtransducers/lemma2adverb.fst FINALtransducers/lemma2adverb.fst
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2adverb.fst | dot -Tpdf > FINALpdf/lemma2adverb.pdf

# 3 - Verb Indicative Present
fstconcat AUXtransducers/lemma.fst AUXtransducers/verbip.fst > FINALtransducers/lemma2verbip.fst
echo ""
fstrmepsilon FINALtransducers/lemma2verbip.fst FINALtransducers/lemma2verbip.fst
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2verbip.fst | dot -Tpdf > FINALpdf/lemma2verbip.pdf

# 4 - Verb Indicative Past
fstconcat AUXtransducers/lemma.fst AUXtransducers/verbis.fst > FINALtransducers/lemma2verbis.fst
echo ""
fstrmepsilon FINALtransducers/lemma2verbis.fst FINALtransducers/lemma2verbis.fst
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2verbis.fst | dot -Tpdf > FINALpdf/lemma2verbis.pdf

# 5 - Verb Indicative Future
fstconcat AUXtransducers/lemma.fst AUXtransducers/verbif.fst > FINALtransducers/lemma2verbif.fst
echo ""
fstrmepsilon FINALtransducers/lemma2verbif.fst FINALtransducers/lemma2verbif.fst
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2verbif.fst | dot -Tpdf > FINALpdf/lemma2verbif.pdf

# b. Unite
# 1 - Verbs
fstunion AUXtransducers/verbis.fst AUXtransducers/verbip.fst > AUXtransducers/verbips.fst
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait verbips.fst | dot -Tpdf > verbips.pdf

fstunion AUXtransducers/verbif.fst AUXtransducers/verbips.fst > AUXtransducers/verb.fst
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait verb.fst | dot -Tpdf > verb.pdf

fstconcat AUXtransducers/lemma.fst AUXtransducers/verb.fst > FINALtransducers/lemma2verb.fst
fstrmepsilon FINALtransducers/lemma2verb.fst FINALtransducers/lemma2verb.fst
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2verb.fst | dot -Tpdf > FINALpdf/lemma2verb.pdf

# 2 - Lemma to Words
fstunion AUXtransducers/verb.fst AUXtransducers/adverb.fst > AUXtransducers/verb_adverb.fst
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait verbips.fst | dot -Tpdf > verbips.pdf

fstunion AUXtransducers/verb_adverb.fst AUXtransducers/noun.fst > AUXtransducers/word.fst
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait verb.fst | dot -Tpdf > verb.pdf

fstconcat AUXtransducers/lemma.fst AUXtransducers/word.fst > FINALtransducers/lemma2word.fst
fstrmepsilon FINALtransducers/lemma2word.fst FINALtransducers/lemma2word.fst
echo " "
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2word.fst | dot -Tpdf > FINALpdf/lemma2word.pdf

# 3 - Word to Lemma
fstinvert FINALtransducers/lemma2word.fst FINALtransducers/word2lemma.fst
fstrmepsilon FINALtransducers/word2lemma.fst FINALtransducers/word2lemma.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/word2lemma.fst | dot -Tpdf > FINALpdf/word2lemma.pdf

# TESTING

array=(  "cantar+V+is+1s" "barco+N+fp" "rapidamente" "cantar+V+ip+1s" "cantar+V+ip+2s" "cantar+V+ip+3s" "cantar+V+ip+1p" "cantar+V+ip+2p" "cantar+V+ip+3p" "cantar+V+is+2s" "cantar+V+is+3s" "cantar+V+is+1p" "cantar+V+is+2p" "cantar+V+is+3p"  "cantar+V+if+1s" "cantar+V+if+2s" "cantar+V+if+3s" "cantar+V+if+1p" "cantar+V+if+2p" "cantar+V+if+3p" "saltar+V+if+2p" "constantemente+ADV" "tubo"       "rema")
array2=( "lemma2verb"     "lemma2word" "word2lemma"  "lemma2verb"     "lemma2verb"     "lemma2verb"     "lemma2verb"     "lemma2verb"     "lemma2verb"     "lemma2verb"     "lemma2verb"     "lemma2verb"     "lemma2verb"     "lemma2verb"      "lemma2verb"     "lemma2verb"     "lemma2verb"     "lemma2verb"     "lemma2verb"     "lemma2verb"     "lemma2word"     "lemma2word"         "word2lemma" "word2lemma" )
array3=( "test1"          "test2"      "test3"       "test4"          "test5"          "test6"          "test7"          "test8"          "test9"          "test10"         "test11"         "test12"         "test13"         "test14"          "test15"         "test16"         "test17"         "test18"         "test20"         "test21"         "test22"         "test23"             "test24"     "test25"     )

for ((i=0;i<${#array[@]};++i)); do

    printf "%s + %s -> %s\n" "${array[i]}" "${array2[i]}" "${array3[i]}"

    #FIXME (keep files in folder and remove this line before submission)
    python3 word2fst.py -s syms.txt "${array[i]}" > "TXTexamples/""${array[i]}"".txt"

    #generate example.fst
    fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols "TXTexamples/""${array[i]}"".txt" | fstarcsort > "FSTexamples/""${array3[i]}"".fst"

    #generate example.pdf
    fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait "FSTexamples/""${array3[i]}"".fst" | dot -Tpdf > "FINALexamples/""${array3[i]}"".pdf"

    #generate example_converter.fst
    fstcompose "FSTexamples/""${array3[i]}"".fst" "FINALtransducers/""${array2[i]}"".fst" > "FSTexamples/""${array3[i]}""_""${array2[i]}"".fst"

    #generate example_converter.pdf
    fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait "FSTexamples/""${array3[i]}""_""${array2[i]}"".fst" | dot -Tpdf > "FINALexamples/""${array3[i]}""_""${array2[i]}"".pdf"
done
