
#log in and begin in you home directory on the cloud
#check where you are
pwd

# load the anaconda module
module load envs/anaconda3

#first create the directory were we will work
mkdir synteny
cd synteny

#create a directory for the input genomes
mkdir genomes
cd genomes

#download the files from ncbi (go to https://www.ncbi.nlm.nih.gov/datasets/genome/)
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/959/347/395/GCA_959347395.1_ilMecMaza1.1/GCA_959347395.1_ilMecMaza1.1_genomic.fna.gz

#Check that the file looks ok
zcat GCA_959347395.1_ilMecMaza1.1_genomic.fna.gz | head

#check how many chromosomes and scaffolds there are by grepping the fasta header, which always starts with a >
#very important to use quotes around the >
zgrep ">" GCA_959347395.1_ilMecMaza1.1_genomic.fna.gz

#download the files from ncbi (go to https://www.ncbi.nlm.nih.gov/datasets/genome/)
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/959/347/415/GCA_959347415.1_ilMecMess1.1/GCA_959347415.1_ilMecMess1.1_genomic.fna.gz

#Check that the file looks ok
zcat GCA_959347415.1_ilMecMess1.1_genomic.fna.gz | head

#check how many chromosomes and scaffolds there are by grepping the fasta header, which always starts with a >
#very important to use quotes around the >
zgrep ">" GCA_959347415.1_ilMecMess1.1_genomic.fna.gz


#make variables, genome file without gz and the taxon name
GENOME=GCA_959347395.1_ilMecMaza1.1_genomic.fna
TAXA_NAME=ilMecMaza1

#make a tab separated key-value file with the old seq name and the new seq name
zcat ${GENOME}.gz | grep ">" | awk -v taxa_name=$TAXA_NAME '{print $0"\t"taxa_name"_"$7}' | tr -d ">" > list_chr_names_$TAXA_NAME.txt

#we want a new directory for the renamed files
mkdir ../renamed_genomes

#run seqkit
conda activate seqkit.v2.1.11
zcat ${GENOME}.gz | seqkit replace -p "(.+)" -r '{kv}' -k list_chr_names_$TAXA_NAME.txt - > ../renamed_genomes/${GENOME%.*}_renamed.fa

#check the fasta headers, remember the qoutes ">"!
grep ">" ../renamed_genomes/${GENOME%.*}_renamed.fa

#Repeat with the other species

#make variables, genome file without gz and the taxon name
GENOME=GCA_959347415.1_ilMecMess1.1_genomic.fna
TAXA_NAME=ilMecMess1

#make a tab separated key-value file with the old seq name and the new seq name
zcat ${GENOME}.gz | grep ">" | awk -v taxa_name=$TAXA_NAME '{print $0"\t"taxa_name"_"$7}' | tr -d ">" > list_chr_names_$TAXA_NAME.txt

#we want a new directory for the renamed files
mkdir ../renamed_genomes

#run seqkit
conda activate seqkit.v2.1.11
zcat ${GENOME}.gz | seqkit replace -p "(.+)" -r '{kv}' -k list_chr_names_$TAXA_NAME.txt - > ../renamed_genomes/${GENOME%.*}_renamed.fa

#check the fasta headers, remember the qoutes ">"!
grep ">" ../renamed_genomes/${GENOME%.*}_renamed.fa


#go back to the synteny folder
cd ../
#deactivate seqkit
conda deactivate 

#make a directory for minimap
mkdir minimap
cd minimap
#make directories for the output and for log-files
mkdir output log


conda activate minimap2

minimap2 -t 2 ../renamed_genomes/GCA_959347395.1_ilMecMaza1.1_genomic_renamed.fa ../renamed_genomes/GCA_959347415.1_ilMecMess1.1_genomic_renamed.fa > output/MecMaza_MecMess.paf

#go to synteny folder

mkdir syntenyplotter
cd syntenyplotter
#create two files, one for intermediate files and one for the resultant plots
mkdir intermediate plots

#copy the script from the my scripts folder
cp  /scratchsan/C_computacion/kn9sanger_ac/scripts/Syntenyplotter_paf_wrapper.R ./
# copy the alignment file to the syntenyplotter folder
cp ../minimap/output/MecMaza_MecMess.paf ./

# Make sure you are in your local computer when running this! And change your_username!

scp -r -J nromerov@168.176.34.122 nromerov@perseus:/scratchsan/C_computacion/nromerov/synteny/syntenyplotter/ ./

cd syntenyplotter
ls
# check that the two additional folders we created are there, if not
mkdir intermediate plots

#run the script on your local computer
Rscript Syntenyplotter_paf_wrapper.R MecMaza_MecMess.paf ilMecMaza1 ilMecMess1










