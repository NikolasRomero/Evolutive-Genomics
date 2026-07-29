scp -r -J nromerov@168.176.34.122 nromerov@perseus:/scratchsan/C_computacion/nromerov/vcf/popStructure/sara_sapho_filtered_maf0.05_pruned.eigenvec ./
scp -r -J nromerov@168.176.34.122 nromerov@perseus:/scratchsan/C_computacion/nromerov/vcf/popStructure/sara_sapho_filtered_maf0.05_pruned.eigenval ./
# Download a file with population information from my folder
cp ../../../fs20sanger_ac/share/sara_sapho_info.txt ./

scp -r -J nromerov@168.176.34.122 nromerov@perseus:/scratchsan/C_computacion/nromerov/vcf/popStructure/sara_sapho_info.txt ./
