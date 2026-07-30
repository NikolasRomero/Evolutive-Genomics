

# Copy the popgen and dstat files to your local computer
scp -r -J <user>@168.176.34.122 <user>@perseus:/scratchsan/C_computacion/<user>/genome_scans/popgen.w20s20.csv.gz .
scp -r -J <user>@168.176.34.122 <user>@perseus:/scratchsan/C_computacion/<user>/genome_scans/dstats.w20s20.csv.gz .
# Copy file containing the location of genes of interest in the genome 
scp -r -J fs20sanger_ac@168.176.34.122 fs20sanger_ac@perseus:/scratchsan/C_computacion/fs20sanger_ac/share/colorPatternGenes.csv .

# Unzip the file
gunzip Hmel218003o.popgen.w20s20.csv.gz 
gunzip Hmel218003o.dstats.w20s20.csv.gz 
