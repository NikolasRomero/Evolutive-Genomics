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

