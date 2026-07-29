

CAPTUS_PATH='/scratchsan/gustavo.silva/miniforge3/envs/filo/bin/captus'

## QC

$CAPTUS_PATH clean -r /scratchsan/C_computacion/gustavo.silva/00_raw_reads \
--bbduk_path /scratchsan/gustavo.silva/miniforge3/envs/filo/bin/bbduk.sh \
--fastqc_path /scratchsan/gustavo.silva/miniforge3/envs/filo/bin/fastqc

## De novo assembly

$CAPTUS_PATH assemble -r 01_clean_reads --sample_reads_target 1_000_000

## Interesting genes extraction

$CAPTUS_PATH extract -a 02_assemblies -d artocarpus_333genes.fasta

## Alignment

$CAPTUS_PATH align -e 03_extractions

## Inference of gene trees unsing IQ-Tree

iqtree3='/scratchsan/gustavo.silva/miniforge3/envs/filo/bin/iqtree3'

## Obtain the trees

bash run_iqtree.sh

## Species tree inference with ASTRAÑ tree 3

astral-pro3='/scratchsan/gustavo.silva/miniforge3/envs/filo/bin/astral-pro3'

## Obtaning the species tree

bash run_astral-pro3.sh


