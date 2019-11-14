#!/bin/bash

rm -f *.fst *.pdf

# - create folders
rm -r FINALtransducers AUXtransducers FINALexamples FINALpdf FSTexamples
#rm -r TXTexamples
mkdir FINALtransducers
mkdir AUXtransducers
mkdir FINALexamples
mkdir FINALpdf
#mkdir TXTexamples
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
fstrmepsilon FINALtransducers/lemma2noun.fst FINALtransducers/lemma2noun.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2noun.fst | dot -Tpdf > FINALpdf/lemma2noun.pdf

# 2 - Adverb
fstconcat AUXtransducers/lemma.fst AUXtransducers/adverb.fst > FINALtransducers/lemma2adverb.fst
fstrmepsilon FINALtransducers/lemma2adverb.fst FINALtransducers/lemma2adverb.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2adverb.fst | dot -Tpdf > FINALpdf/lemma2adverb.pdf

# 3 - Verb Indicative Present
fstconcat AUXtransducers/lemma.fst AUXtransducers/verbip.fst > FINALtransducers/lemma2verbip.fst
fstrmepsilon FINALtransducers/lemma2verbip.fst FINALtransducers/lemma2verbip.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2verbip.fst | dot -Tpdf > FINALpdf/lemma2verbip.pdf

# 4 - Verb Indicative Past
fstconcat AUXtransducers/lemma.fst AUXtransducers/verbis.fst > FINALtransducers/lemma2verbis.fst
fstrmepsilon FINALtransducers/lemma2verbis.fst FINALtransducers/lemma2verbis.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2verbis.fst | dot -Tpdf > FINALpdf/lemma2verbis.pdf

# 5 - Verb Indicative Future
fstconcat AUXtransducers/lemma.fst AUXtransducers/verbif.fst > FINALtransducers/lemma2verbif.fst
fstrmepsilon FINALtransducers/lemma2verbif.fst FINALtransducers/lemma2verbif.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2verbif.fst | dot -Tpdf > FINALpdf/lemma2verbif.pdf

# b. Unite
# 1 - Verbs
fstunion AUXtransducers/verbis.fst AUXtransducers/verbip.fst > AUXtransducers/verbips.fst
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait verbips.fst | dot -Tpdf > verbips.pdf

fstunion AUXtransducers/verbif.fst AUXtransducers/verbips.fst > AUXtransducers/verb.fst
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait verb.fst | dot -Tpdf > verb.pdf

fstconcat AUXtransducers/lemma.fst AUXtransducers/verb.fst > FINALtransducers/lemma2verb.fst
fstrmepsilon FINALtransducers/lemma2verb.fst FINALtransducers/lemma2verb.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2verb.fst | dot -Tpdf > FINALpdf/lemma2verb.pdf

# 2 - Lemma to Words
fstunion AUXtransducers/verb.fst AUXtransducers/adverb.fst > AUXtransducers/verb_adverb.fst
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait verbips.fst | dot -Tpdf > verbips.pdf

fstunion AUXtransducers/verb_adverb.fst AUXtransducers/noun.fst > AUXtransducers/word.fst
#fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait verb.fst | dot -Tpdf > verb.pdf

fstconcat AUXtransducers/lemma.fst AUXtransducers/word.fst > FINALtransducers/lemma2word.fst
fstrmepsilon FINALtransducers/lemma2word.fst FINALtransducers/lemma2word.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2word.fst | dot -Tpdf > FINALpdf/lemma2word.pdf

# 3 - Word to Lemma
fstinvert FINALtransducers/lemma2word.fst FINALtransducers/word2lemma.fst
fstrmepsilon FINALtransducers/word2lemma.fst FINALtransducers/word2lemma.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/word2lemma.fst | dot -Tpdf > FINALpdf/word2lemma.pdf

# TESTING

#array with test mames
array=(  "cantar+V+ip+1s" "canto" "cantar+V+ip+2s" "cantas" "cantar+V+ip+3s" "canta" "cantar+V+ip+1p" "cantais" "cantar+V+ip+2p" "cantamos" "cantar+V+ip+3p" "cantam" "cantar+V+is+1s" "cantei" "cantar+V+is+2s" "cantaste" "cantar+V+is+3s" "cantou" "cantar+V+is+1p" "cantastes" "cantar+V+is+2p" "cantaram" "cantar+V+is+3p" "cantamos" "cantar+V+if+1s" "cantarei" "cantar+V+if+2s" "cantarás" "cantar+V+if+3s" "cantará" "cantar+V+if+1p" "cantareis" "cantar+V+if+2p" "cantarão" "cantar+V+if+3p" "cantaremos" "barco+N+ms" "barco" "barco+N+fs" "barca" "barco+N+mp" "barcos" "barco+N+fp" "barcas" "ironicamente+ADV" "ironicamente")
#array with transducers to be tested
array2=( "lemma2verb" "lemma2word" "word2lemma" )
c=0
test="test"
for ((i=0;i<${#array[@]};++i)); do

  for ((j=0;j<${#array2[@]};++j)); do

      # counter and file name (test1, test2 ... and so on)
      ((c++))
      name=${test}${c}

      printf "%s + %s -> %s\n" "${array[i]}" "${array2[j]}" "${name}"

      #FIXME (keep files in folder and remove this line before submission)
      #python3 word2fst.py -s syms.txt "${array[i]}" > "TXTexamples/""${array[i]}"".txt"

      #generate example.fst
      fstcompile --isymbols=syms.txt --osymbols=syms.txt --keep_isymbols --keep_osymbols "TXTexamples/""${array[i]}"".txt" | fstarcsort > "FSTexamples/""${name}"".fst"

      #generate example.pdf
      fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait "FSTexamples/""${name}"".fst" | dot -Tpdf > "FINALexamples/""${name}"".pdf"

      #generate example_converter.fst
      fstcompose "FSTexamples/""${name}"".fst" "FINALtransducers/""${array2[j]}"".fst" > "FSTexamples/""${name}""_""${array2[j]}"".fst"

      #generate example_converter.pdf
      fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait "FSTexamples/""${name}""_""${array2[j]}"".fst" | dot -Tpdf > "FINALexamples/""${name}""_""${array2[j]}"".pdf"
    done
done
