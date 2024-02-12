#!/bin/sh
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=16G
#SBATCH --time=10-00:00:00

prefix=np
npmerge=/homes/liu3zhen/scripts2/npcor/npcormerge
splitseqDir=split
runlog=3o-run.log
joblog=3o-npmerge.log

date > $runlog
sh $npmerge -c . -p $prefix -d $splitseqDir -r "" -o $joblog >>$runlog
date >> $runlog

