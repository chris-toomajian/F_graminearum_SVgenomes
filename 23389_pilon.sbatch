#!/bin/bash -l
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=2g
#SBATCH --time=0-23:00:00

module load SAMtools/1.9-foss-2018b
module load Java/1.8.0_192
module load BWA/0.7.17-GCC-8.3.0
cpunum=$SLURM_CPUS_PER_TASK
pilonJar=/homes/upasanad/software/pilon/pilon-1.24.jar
pe1=/homes/upasanad/project/illumina_sequences/23389_trim/23389_S20_merged_pair.p1.fastq.gz
pe2=/homes/upasanad/project/illumina_sequences/23389_trim/23389_S20_merged_pair.p2.fastq.gz
fasta=/homes/upasanad/project/nanopolish/23389new/23389ONTv0.2.contigs.np2.fasta
asm=`echo $fasta | sed 's/.*\///g'`
newasm=polished

# tmp directory
tmpdir=1otmp
mkdir $tmpdir

# aln
pushd $tmpdir

ln -s $fasta 
bwa index $asm

out=read2asm

# alignment
bwa mem $asm $pe1 $pe2 > $out.sam

# sam2bam
samtools view -@ $cpunum -b $out.sam -o $out.bam
samtools sort -@ $cpunum $out.bam -o $out.sort.bam
samtools index -@ $cpunum $out.sort.bam



popd
# pilon
java -Xmx64g -jar $pilonJar \
        --genome $fasta \
        --frags $tmpdir/$out.sort.bam \
        --output $newasm \
        --outdir . \
        --minmq 40 \
        --fix bases \
        --minqual 15 \
        --threads 32 \
        --changes --vcf &>$newasm.pilon.log

# cleanup
#rm $tmpdir -rf
perl /homes/upasanad/project/illumina_sequences/pilon_scripts/pilonBox.pl summary *.changes > test.changes.summary

