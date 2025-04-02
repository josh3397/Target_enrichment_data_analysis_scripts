#!/bin/bash
#SBATCH --job-name=Trinity_assembly
#SBATCH --account=project_2002062
#SBATCH --partition=small
#SBATCH --time=3-00:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=100G
#SBATCH --gres=nvme:1000

module load biokit
module load trinity/2.15.1
for file1 in ./*_R1.fastq;
do
file2=${file1/R1/R2};
out=${file1%%.fastq}_trinity;
mkdir -p $LOCAL_SCRATCH/trinity_tmpfiles
Trinity --seqType fq --left $file1 --right $file2 --CPU $SLURM_CPUS_PER_TASK --SS_lib_type FR --no_version_check --max_memory 300G --output $LOCAL_SCRATCH/$out --workdir $LOCAL_SCRATCH/trinity_tmpfiles --full_cleanup
cp -R $LOCAL_SCRATCH/$out /Assembly/
done
