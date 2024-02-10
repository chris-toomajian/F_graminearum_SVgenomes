# F_graminearum_SVgenomes
Scripts used for the assembly of Fusarium graminearum genomes, the detection of TEs and other repetitive elements, and structural variation analysis with SyRI
Scripts used in the article "The landscape and predicted roles of structural variants in Fusarium graminearum genomes"

#Authors

Upasana Dhakal: 
Hye-Seon Kim: 
Christopher Toomajian: toomajia@ksu.edu

#Acknowledgements to:

[Sanzhen Liu](https://github.com/liu3zhenlab)

#System

Most scripts were written to run on Kansas State University's high performance computing cluster, [Beocat](https://beocat.ksu.edu/)

##Dependencies

- [gnuplot](https://sourceforge.net/p/gnuplot/gnuplot-main/merge-requests/) 5.2.5-foss-2018b
- [canu](https://github.com/marbl/canu) v1.9
- [SAMtools](https://github.com/samtools/samtools) 1.9-foss-2018b
- [minimap2](https://github.com/lh3/minimap2)
- [nanopolish](https://github.com/jts/nanopolish)
- [npcor](https://github.com/liu3zhenlab/npcor)
- [BWA](https://github.com/lh3/bwa) 0.7.17-GCC-8.3.0
- [pilon](https://github.com/broadinstitute/pilon) 1.24
- [busco](https://gitlab.com/ezlab/busco/-/releases#5.6.1)
- [EDTA](https://github.com/oushujun/EDTA)
- [SyRI](https://github.com/schneebergerlab/syri)
- [plotsr](https://github.com/schneebergerlab/plotsr)

##R libraries
- [readxl](https://www.rdocumentation.org/packages/readxl/versions/1.4.3)
- [RCircos](https://www.rdocumentation.org/packages/RCircos/versions/1.2.2) v1.2.2
- [stats](https://www.rdocumentation.org/packages/stats/versions/3.6.2) v3.6.2

## Code

<ins>canu23522.sh</ins> - script for running canu genome assembly software

Insert script for calling npcor!

<ins>pilon.sbatch</ins> - script for short read polishing, including running bwa-mem and pilon software

pilonBox.pl    /homes/upasanad/project/illumina_sequences/pilon_scripts/pilonBox.pl - This is a script of S Liu, but it doesn't appear at his GitHub

<ins>busco.cml3066.sh</ins> - script for running BUSCO software

<ins>edta.sh</ins> - script for running EDTA software

<ins>minimap2.sh</ins> - script to run minimap to align query genome assembly against reference assembly (PH-1) isolate

<ins>syri.sh</ins> - script to run SyRI software

<ins>syri.plot.sh</ins> - script to make SyRI plot based on output of SyRI software

<ins>rcircosnew.R</ins> - R code to generate RCircos plots

<ins>fisher_test.R</ins> - R code to perform Fishers exact test from 2x2 contingency tables

## Funannotate tutorial

See <ins>Funannotate_workflow.rst</ins> for the set of commands used to run Funannotate for genome annotation, in tutorial format.


## Usage
