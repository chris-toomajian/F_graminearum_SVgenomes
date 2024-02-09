#!/bin/bash -l
indata=/bulk/toomajia/ONT_assemblies/23522ONT/fastq/pass/*fastq
outdir=/bulk/toomajia/ONT_assemblies/23522ONTv0.2
outprefix=23522ONTv0.2

# load java
module load Java/1.8.0_162
module load gnuplot/5.2.5-foss-2018b

# run canu
time /homes/liu3zhen/software/canu/canu-1.9/Linux-amd64/bin/canu -d $outdir -p $outprefix \
        genomeSize=38m \
        minReadLength=5000 \
        minOverlapLength=1000 \
        -gridOptions="--time=6-00:00:00" \
        -nanopore-raw $indata \
        corOutCoverage=80 \
        &>$outprefix.log
