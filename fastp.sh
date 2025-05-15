#!/bin/bash
#SBATCH --job-name=fastp
#SBATCH --account=project_2002062
#SBATCH --partition=small
#SBATCH --time=3-00:00:00
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=100G

module load biokit

inutdir="./Raw_data/"
outdir="./Raw_trimmed"

mkdir -p $outdir

for file1 in $inputdir/*_1.fastq.gz;
do
file2=${file1/_1/_2};
Sample=$(basename "$file1" | sed 's/_1.*//')
fastp -i $file1 -I $file2 -o ${Sample}_1_trimmed.fastq.gz -O ${Sample}_2_trimmed.fastq.gz --length_required 100 -y -g;
done
