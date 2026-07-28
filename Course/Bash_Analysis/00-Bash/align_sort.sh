#!/bin/bash
INDS=($(for i in ~/filteredReads/*.R1.trimmed.fastq.gz; do echo $(basename ${i%.R*}); done))
for IND in ${INDS[@]};
do
	# declare variables
	BWA_PATH=/scratchsan1/anaconda3/envs/bwa/bin/
	REF=~/reference/GCA_917862395.2_iHelSar1.2_genomic.fna
	FORWARD=~/filteredReads/${IND}.R1.trimmed.fastq.gz
	REVERSE=~/filteredReads/${IND}.R2.trimmed.fastq.gz
	OUTPUT=~/align/${IND}_sort.bam

	# read group string, required by Picard MarkDuplicates and GATK
	RG="@RG\tID:${IND}\tSM:${IND}\tPL:ILLUMINA\tLB:${IND}"

	# then align and sort
	echo "Aligning $IND with bwa"
	$BWA_PATH/bwa mem -t 4 -R "${RG}" $REF $FORWARD \
	$REVERSE | samtools view -b | \
	samtools sort -T ${IND} > $OUTPUT
done
