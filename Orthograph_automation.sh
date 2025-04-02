##script to automate the orthology inference uisng orthograph for all assembled reads
##Note that .conf files should be prepared for all the samples beforehand. And directories Orthograph_conf and Log folder should also be present before running the script

#!/bin/bash
#SBATCH --job-name=Orthograph
#SBATCH --account=project_2002062
#SBATCH --partition=small
#SBATCH --time=2-20:00:00
#SBATCH --ntasks=1
#SBATCH --mem=100G

export PATH="/Path_to_Orthograph/bin:$PATH"
for file1 in path_to_folder_with_assembled_fasta/*.fasta;
do
file2=$(basename "$file1" .fasta)
./orthograph-analyzer -c species_folder/Orthograph_conf/$file2.conf &> species_folder/Log/$file2.log.analyzer 
./orthograph-reporter -c species_folder/Orthograph_conf/$file2.conf &> Species_folder/Log/$file2.log.reporter
done
