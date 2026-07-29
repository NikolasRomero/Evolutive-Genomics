
cd ~/popStructure

module load envs/anaconda3

VCF="../vcf_real/sara_sapho_filtered.vcf.gz"


module load apps/plink/2.0.0-a

## Include bi-allelic sites only (excluding singletons), apply a minor allele filter of 0.05 and prune sites to 1 per 10 kb.

plink2 \
    --vcf $VCF \
    --threads 8 \
    --allow-extra-chr \
    --geno 0.25 \
    --min-alleles 2 \
    --max-alleles 2 \
    --maf 0.05 \
    --bp-space 10000 \
    --export vcf id-paste=iid \
    --out sara_sapho_filtered_maf0.05_pruned

# Update the VCF variable to the pruned one:

VCF=sara_sapho_filtered_maf0.05_pruned

# generate allele frequency file
plink2 \
    --vcf ${VCF}.vcf \
    --threads 8 \
    --allow-extra-chr \
    --set-missing-var-ids @:# \
    --freq \
    --out ${VCF}

# create pca
plink2 \
    --vcf ${VCF}.vcf \
    --threads 8 \
    --allow-extra-chr \
    --set-missing-var-ids @:# \
    --read-freq ${VCF}.afreq \
    --pca \
    --out ${VCF}

# prune snps based on linkage disequilibrium (LD)
plink2 \
--vcf $VCF \
--threads 8 \
--allow-extra-chr \
--bad-ld \
--set-missing-var-ids @:# \
--min-alleles 2 \
--max-alleles 2 \
--mac 2 \
--indep-pairwise 50 10 0.2 \
--out $VCF

# extract LD-pruned sites
plink2 \
--vcf $VCF \
--threads 8 \
--allow-extra-chr \
--set-missing-var-ids @:# \
--min-alleles 2 \
--max-alleles 2 \
--mac 2 \
--extract $VCF.prune.in \
--export vcf id-paste=iid \
--out $VCF.ld_prune



