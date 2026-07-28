 conda activate picard

 picard MarkDuplicates REMOVE_DUPLICATES=true \
 ASSUME_SORTED=true VALIDATION_STRINGENCY=SILENT \
 MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 \
 INPUT=wgs1_sort.bam \
 OUTPUT=wgs1.sort.rmd.bam \
 METRICS_FILE=wgs1.rmd.bam.metrics

conda deactivate

# Now we need to index all bam files again and that's it!

conda activate samtools
samtools index *.rmd.bam
conda deactivate
