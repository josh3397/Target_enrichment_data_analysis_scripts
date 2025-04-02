##automating spades assembly for all fastq files (R1 and R2) in a directory
## Lines starting with #SBATCH are the parameters used by CSC compute node to run the batch job

#!/bin/bash
#SBATCH --job-name=Sawfly_TE_assembly
#SBATCH --account=project_2002062
#SBATCH --partition=small
#SBATCH --time=3-00:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=22
#SBATCH --mem-per-cpu=15G

module load biokit
for file1 in *_R1.fastq;
do
file2=${file1/R1/R2};
out=${file1%%.fastq}_assembly;
spades.py -1 $file1 -2 $file2 -o outout_folder/$out -t $SLURM_CPUS_PER_TASK
done
