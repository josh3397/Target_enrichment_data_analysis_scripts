##Script to automate bwa mapping for trimmed fastq reads (gzipped). The script loops through forward and reverse reads for each sample, performs reference mapping, generates sorted bam files from sam and finally deletes sam files only to keep sorted bam files. As sam files can be quite heavy in size

#!/bin/bash

inputdir="./fastp_cleaned/"
outdir="./mapped/"
ref_seq=$1

mkdir -p "$outdir"

for R1 in $inputdir/*_1_trimmed.fastq.gz;
do
R2=${R1/_1_trimmed/_2_trimmed}


#R1=$(ls $inputdir | grep '_1_trimmed.fastq.gz')
#R2=$(ls $inputdir | grep '_2_trimmed.fastq.gz')

Sample=$(basename "$R1" | sed 's/_1_trimmed.*//')

echo "processing sample $Sample"
echo "forward read:$R1"
echo "reverse read:$R2"

bwa mem -k 30 $ref_seq $R1 $R2  > $outdir/${Sample}.sam
samtools view -bS $outdir/${Sample}.sam | samtools sort -o $outdir/${Sample}_sorted.bam

rm $outdir/${Sample}.sam

echo "done with $Sample"

done