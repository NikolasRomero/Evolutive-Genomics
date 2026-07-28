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

#Create a folder called vcf_Real
mkdir vcf_real
cd  vcf_real
# copy the sara_sapho file from the share directory
cp /scratchsan/C_computacion/nr10sanger_ac/biodiversity_genomics_course/data/Heliconius/VCF/sara_sapho_subset.vcf.gz ./

# you might need to define the variable again if you did it in the 'screen'
BCFTOOLS_PATH=/scratchsan/C_computacion/nr10sanger_ac/miniconda3/envs/bcftools_m/bin/

$BCFTOOLS_PATH/bcftools view -h sara_sapho_subset.vcf.gz

# Index VCF

$BCFTOOLS_PATH/bcftools index sara_sapho_subset.vcf.gz


