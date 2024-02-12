#Merge the fastqreads;
cat *fastq > merged23522.fastq

#indexing;
f5=/homes/upasanad/project/ONT_assemblies/23522ONT/fast5
fq=/homes/upasanad/project/nanopolish/23522/merged23522.fastq
seq_sum=sequencing_summary.txt
np_dir=/homes/liu3zhen/software/nanopolish/nanopolish_0.11.0
$np_dir/nanopolish index -d $f5 -s $seq_sum $fq

#indexing without sequence summary file;
f5=/homes/upasanad/project/ONT_assemblies/23522ONT/fast5
fq=/homes/upasanad/project/nanopolish/23522/merged23522.fastq
np_dir=/homes/liu3zhen/software/nanopolish/nanopolish_0.11.0
$np_dir/nanopolish index -d $f5 $fq

#indexing code that worked for indexing reference genome;
ref=/homes/upasanad/project/ONT_assemblies/23522ONTv0.3/23522ONTv0.3.contigs.fasta
/homes/liu3zhen/software/minimap2/minimap2 -x map-ont -d 23522merged.mmi $ref

#alignment code that worked;
/homes/liu3zhen/software/minimap2/minimap2 -ax map-ont 23522merged.mmi merged23522.fastq 1>aln23522.sam 2>aln23522.log
 
#code that worked for converting sam to bam and sort bam and index bam;
module load SAMtools/1.9-foss-2018b
samtools view -b 23522aln.sam -o 23522aln.bam
samtools sort 23522aln.bam > 23522alnsort.bam
samtools view 23522alnsort.bam | head
samtools index 23522alnsort.bam
