
conda create -n sra-tools -c bioconda sra-tools pigz parallel

conda activate sra-tools

SRR24706287 Ficus_apollinaris
SRR24706125 Ficus_austrocaledonica
SRR24706157 Ficus_callosa
SRR24706179 Ficus_assimilis
SRR24706382 Ficus_ingens
SRR24706212 Ficus_platypoda
SRR24706402 Ficus_globosa
SRR24706401 Ficus_gommelleira
SRR24706366 Ficus_lutea
SRR24706331 Ficus_antandronarum

bash download_fastq.sh


conda deactivate
