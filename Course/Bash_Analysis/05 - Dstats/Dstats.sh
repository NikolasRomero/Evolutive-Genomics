
# prepare SETS file
cp /scratchsan/C_computacion/fs20sanger_ac/07_Dsuite/martin2019_species.txt .
sed 's/Hnum.bsl.bra$/Outgroup/' martin2019_species.txt | grep -v "ind"  > melpomene.sets.txt
cat melpomene.sets.txt

#Necessary VCF
VCF="/scratchsan/C_computacion/fs20sanger_ac/martin2019/wgenome.martin2019.biallelic.mac2.prune10kb.vcf"

module load apps/Dsuite/main
Dsuite Dtrios $VCF melpomene.sets.txt

#Lets check
cat melpomene.sets_BBAA.txt | sort -nk 5 | column -t
cat melpomene.sets_Dmin.txt | sort -nk 5 | column -t

# load module
module load apps/Dsuite/main

# We need to give the program a defined species tree. This has already been created and you can copy it to your own folder.
cp /scratchsan/C_computacion/fs20sanger_ac/share/mel_tree.nwk ./

# Calulate D statistics and f4 ratios again, but assuming a tree
Dsuite Dtrios --tree mel_tree.nwk $VCF melpomene.sets.txt

# Calulate F-branch using the calculated f4-rations and assuming the specified tree
Dsuite Fbranch mel_tree.nwk melpomene.sets_tree.txt > melpomene.fbranch.txt

# Plot fbranch (fb)
/local64/usr_local/Dsuite/utils/dtools.py melpomene.fbranch.txt mel_tree.nwk

