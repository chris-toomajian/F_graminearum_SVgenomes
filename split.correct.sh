#!/bin/sh

#################################
# supply full-path for inputs
#################################
prefix=np
npcor=/homes/liu3zhen/scripts2/npcor/npcor
reads=/homes/upasanad/project/nanopolish/23522/merged23522.fastq
ref=/homes/upasanad/project/nanopolish/23522/23522.1/23522ONTv0.3.contigs.np1.fasta
bam=/homes/upasanad/project/nanopolish/23522/alnsort23522.np1.bam
npDir=/homes/liu3zhen/software/nanopolish/nanopolish_0.11.0
scriptDir=/homes/liu3zhen/scripts2/npcor/utils
splitseqDir=split
javaModule=Java/1.8.0_192
samtoolsModule=SAMtools/1.9-foss-2018b
ncpu=4
log=run.log

date > $log

# spliting
echo "1. split fasta" &>>$log

if [ -d $splitseqDir ]; then
        rm -rf $splitseqDir
fi
mkdir $splitseqDir
cd $splitseqDir
perl $scriptDir/split.fasta.pl --num 1 --prefix $prefix --decrease $ref &>>../$log
cd ..

echo "2. run NP correction" &>>$log
# run correction
for ctg in $splitseqDir/*[0-6]; do
        echo "np: "$ctg >> $log
        $npcor -n $npDir -f $ctg -r $reads -b $bam \
                -s $scriptDir \
                -l $javaModule \
                -l $samtoolsModule \
                -c $ncpu \
                -g 8 \
                -y 1 \
                >> $log
done
