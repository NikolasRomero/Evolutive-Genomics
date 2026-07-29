## unfiltered sites

PATH_BCFTOOLS=/scratchsan1/anaconda3/envs/bcftools/bin/

${PATH_BCFTOOLS}bcftools view -H sara_sapho_subset.vcf.gz | wc -l

##Statistics

## Declare variables

VCF=../vcf_real/sara_sapho_subset.vcf.gz
OUT=sara_sapho

## Mean depth per site

conda activate vcftools
vcftools --gzvcf $VCF --site-mean-depth --out $OUT

## Proportion of missing data per site

vcftools --gzvcf $VCF --missing-site --out $OUT

## Missing data per individual

vcftools --gzvcf $VCF --missing-indv --out $OUT

## Mean depth per individual

vcftools --gzvcf $VCF --depth --out $OUT

## Heterozygocity and inbreeding coefficient per individual

vcftools --gzvcf $VCF --het --out $OUT

## Filtering

cd vcf_real

VCF_IN=sara_sapho_subset.vcf.gz
VCF_OUT=sara_sapho_filtered.vcf.gz

module load envs/anaconda3
conda activate vcftools


# perform the filtering with vcftools
vcftools --gzvcf $VCF_IN \
--remove-indv D5252__Hvenez --remove-indv R_843__Hccong_L3 \
--remove-indels --max-missing 0.75 --minQ 30 --min-meanDP 10 --max-meanDP 30 \
--minDP 10 --minGQ 20 \
--recode --stdout | gzip -c > $VCF_OUT
