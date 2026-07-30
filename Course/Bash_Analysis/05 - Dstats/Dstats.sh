
# prepare SETS file
cp /scratchsan/C_computacion/fs20sanger_ac/07_Dsuite/martin2019_species.txt .
sed 's/Hnum.bsl.bra$/Outgroup/' martin2019_species.txt | grep -v "ind"  > melpomene.sets.txt
cat melpomene.sets.txt
