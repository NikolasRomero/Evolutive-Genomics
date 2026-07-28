#!/bin/bash

#Index again

conda activate samtools
samtools faidx GCA_917862395.2_iHelSar1.2_genomic.fna
conda deactivate

#Screen andvariable
screen -S call_variants

REF=~/reference/GCA_917862395.2_iHelSar1.2_genomic.fna

## We are going to call variants within the vcf folder using bcftools:

BCFTOOLS_PATH=/scratchsan/C_computacion/nr10sanger_ac/miniconda3/envs/bcftools_m/bin/
${BCFTOOLS_PATH}/bcftools mpileup -a AD,DP,SP -Ou -f $REF \
~/reference/align/*.sort.rmd.bam | ${BCFTOOLS_PATH}/bcftools call -f GQ,GP \
-mO z -o ./sara_sapho.vcf.gz

