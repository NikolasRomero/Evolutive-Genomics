
# We will use a vcf file of just a part of chromosome 18 to speed up this exercise.
# Convert the vcf file to geno.gz which is the format that Simon's scripts require
# Note, we do not filter for bi-allelic sites as we need to include monomorphic sites for pi and Dxy. This file does have a filter on missing data (max 10%).
VCF="/scratchsan/C_computacion/fs20sanger_ac/martin2019/Hmel218003o.subset.vcf.gz"

# Convert the vcf file to geno.gz which is the format that Simon Martin's script requires
module load apps/genomic-general/v0.5
parseVCF.py -i $VCF --skipIndels -o Hmel218003o.geno.gz

#/ create a file assigning individuals to populations
conda activate bcftools
bcftools query -l $VCF | awk '{print $1"\t"substr($1,1,12)}' > popmap.txt


# First, we will calculate pi for each species and Fst and dxy for each pair of species all in one go.

popgenWindows.py \
    --windType coordinate \
    -g Hmel218003o.geno.gz \
    -o Hmel218003o.popgen.w20s20.csv.gz \
    -w 20000 \
    -s 20000 \
    -m 10000 \
    -f phased \
    -T 2 \
    -p Hmel.mal.col -p Hmel.agl.per -p Hmel.ama.per -p Hmel.mel.gui -p Hnum.bsl.bra -p Htim.flo.per -p Htim.the.per -p Hcyd.chi.pan -p Hcyd.zel.col \
    --popsFile popmap.txt


# Next, we calculate fd and fdM to test for introgression between H. melpomene amaryllis and H. timareta thelxiopea using H. numata as outgroup. fd and fdM are measures of introgression suitable for small windows.

ABBABABAwindows.py \
    -g Hmel218003o.geno.gz \
    -o Hmel218003o.dstats.w20s20.csv.gz \
    -f phased \
    -w 20000 \
    -s 20000 \
    -m 100 \
    --minData 0.5 \
    -T 2 \
    -P1 Hmel.mal.col -P2 Hmel.ama.per -P3 Htim.flo.per -O Hnum.bsl.bra \
    --popsFile popmap.txt \
    --writeFailedWindows


