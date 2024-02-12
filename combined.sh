#!/bin/bash
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=96G
#SBATCH --time=0-23:59:59

module load Java/1.8.0_192
gatk=/homes/liu3zhen/software/GATK/gatk4/gatk-4.1.0.0/gatk

oriasm=/homes/upasanad/project/nanopolish/23522/23522.1/23522ONTv0.3.contigs.np1.fasta
newasm=23522ONTv0.3.contigs.np2.fasta

# merge sequences
cat np.*/polished/polished* > $newasm

# merge VCFs
vcflist=4o-vcf.list
if [ -f $vcflist ]; then
	rm $vcflist
fi

vcfs=`find . -mindepth 2 -maxdepth 3 -name "np*vcf" -type f`

vcfcol=4o-vcf_collection
if [ -d $vcfcol ]; then
	rm -rf $vcfcol
fi
mkdir $vcfcol

for evcf in $vcfs; do
	vcfname=`echo $evcf | sed 's/.*\///g'` # directory name
	vcfout=$vcfcol/${vcfname}.vcf
	echo $vcfout >> $vcflist
	grep -e "^##contig" -e "^##nanopolish_window" -v $evcf > $vcfout;
done

mergevcf=4o-npcor.vcf
seqdict=`echo $oriasm | sed 's/fasta$/dict/g'`
if [ ! -f $seqdict ]; then
	$gatk CreateSequenceDictionary -R $oriasm
fi
$gatk MergeVcfs -O $mergevcf -I $vcflist -D $seqdict

# cleanup
rm -rf $vcfcol

