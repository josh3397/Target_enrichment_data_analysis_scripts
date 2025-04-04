##Script to merge the data from all four sequencing lanes (L1 to L4) for each R1 and R2


#!/bin/bash

for i in $(find ./ -type f -name "*.fastq.gz" | while read F; do basename $F | rev | cut -c 22- | rev; done | sort | uniq)

    do echo "Merging R1"

cat "$i"_L00*_R1_001.fastq.gz > "$i"_ME_L001_R1_001.fastq.gz

       echo "Merging R2"

cat "$i"_L00*_R2_001.fastq.gz > "$i"_ME_L001_R2_001.fastq.gz

done;