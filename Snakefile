#This is a snakemake workflow to perform basic bioinformatics pre-processing of standard illumina data - adaptor trimming, bwa mapping and generating sorted bam files

#SAMPLES = ["sample_1", "sample_2", "sample_3"]
#print('samples are:', SAMPLES)

files = glob_wildcards("Raw_data/{sample}_1.fastq.gz")
rule all:
	input:
		expand("Sorted_bam/{sample}_sorted.bam", sample=files.sample),

rule trimming:
	input:
		a ="Raw_data/{sample}_1.fastq.gz",
		b ="Raw_data/{sample}_2.fastq.gz",
	output:
		c ="Raw_trimmed/{sample}_1_trimmed.fq.gz",
		d ="Raw_trimmed/{sample}_2_trimmed.fq.gz"
	shell: """
		fastp -i {input.a} -I {input.b} -o {output.c} -O {output.d} --length_required 100 -y -g
	"""
		
rule mapping:
	input:
		ref_seq="ref.fna"
		e="Raw_trimmed/{sample}_1_trimmed.fq.gz",
		f="Raw_trimmed/{sample}_2_trimmed.fq.gz"
	output:
		"Mapped/{sample}.sam"
	shell: """
		bwa mem -k 30 {input.ref_seq} {input.e} {input.f} > {output}
	"""
rule samtools_sort:
	input:
		"Mapped/{sample}.sam"
	output:
		"Sorted_bam/{sample}_sorted.bam"
	shell: """
		samtools view -bS {input} | samtools sort -o {output}
	"""

 