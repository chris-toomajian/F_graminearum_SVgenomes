#!/bin/bash -l
#SBATCH --time=10:40:00
assembly=/homes/upasanad/project/strvariation/23389_mummer/23389.fasta
cds=/homes/upasanad/ph1_datasets/ncbi_dataset/data/GCA_900044135.1/cds_from_genomic.fna
perl /homes/upasanad/EDTA/EDTA.pl --genome $assembly --cds $cds --overwrite 1 --sensitive 1 --anno 1 --evaluate 1 --threads 10

