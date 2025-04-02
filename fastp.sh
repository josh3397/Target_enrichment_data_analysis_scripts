#!/bin/bash
#SBATCH --job-name=fastp
#SBATCH --account=project_2002062
#SBATCH --partition=small
#SBATCH --time=3-00:00:00
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=100G

for file1 in *_R1.fastq;
do
file2=${file1/R1/R2};
out=${file1%%.fastq}_output;
/path_to_/fastp -i $file1 -I $file2 -o ${file1}_trimmed -O ${file2}_trimmed --length_required 100 --low_complexity_filter --detect_adapter_for_pe;
done
