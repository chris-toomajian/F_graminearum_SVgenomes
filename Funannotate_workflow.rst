
.. _tutorials:

**Funannotate Workflow**

This protocol was originally generated by nextgenusfs github (https://github.com/nextgenusfs/funannotate/blob/master/docs/tutorials.rst) and we used this tutorial (https://funannotate.readthedocs.io/en/latest/tutorials.html) as a template for modifying the codes for our samples, listed below. As such, what follows copies most of large sections of this previous tutorial, only making modifications that are specific to our usage of Funannotate.

1.	Fusarium graminearum 23389 (KSU23389.fa)
2.	Fusarium graminearum 23468 (KSU23468.fa)
3.	Fusarium graminearum 23473 (KSU23473.fa)
4.	Fusarium graminearum 23522 (KSU23522.fa)

The following section will walk-through usage of funannotate for genome assembly with RNA seq Data.

**Using a Genome Assembly and RNA-seq Data**
                                                              
This the “gold standard” in a sense and if the RNA-seq data is high quality should lead to a high-quality annotation. Paired-end stranded RNA-seq data will yield the best results, although unstranded and/or single ended reads can also be used. 
This protocol utilized publicly available RNA-seq data from NCBI-Sequence Read Archive for Fusarium graminearum generated from spores (SRR1179894), mycelium (SRR1179897), hyphae grown on liquid YAPD medium (SRR9054433), and additional mRNA data from genome assembly (e.g. GCF_000240135.3 for PH1_mrna). We start with the following files in your folder:

.. code-block:: none

  MyAssembly_23389.fa
  SRR1179894_R1.fastq.gz (spores)                                                            
  SRR1179894_R2.fastq.gz (spores)
  SRR1179897_R1.fastq.gz (mycelium)                                                              
  SRR1179897_R2.fastq.gz (mycelium)                                                              
  SRR9054433_R1.fastq.gz (hyphae grown on liquid YAPD medium)                                                              
  SRR9054433_R2.fastq.gz (hyphae grown on liquid YAPD medium)                                                              
  PH1_mRNA.fastq.gz (mRNAs from GCF_000240135.3)

Funannotate can accommodate a variety of input data and depending on the data you have available you will use funannotate slightly differently, although the core modules are used in the following order:
clean –> sort –> mask –> train –> predict –> update –> annotate
                                                              
1.	Haploid fungal genome? This step is optional. Then run funannotate clean. Will also run funannotate sort to rename fasta headers.
.. code-block:: 
  funannotate clean -i KSU23389.fa --minlen 1000 -o KSU23389.cleaned.fa
2.	Now sort your scaffolds by length and rename with a simple fasta header to avoid downstream problems.
.. code-block:: 
  funannotate sort -i KSU23389.cleaned.fa -b scaffold -o KSU23389.cleaned.sorted.fa
3.	Now we want to softmask the repetitive elements in the assembly.
.. code-block:: 
  funannotate mask -i KSU23389.cleaned.sorted.fa --cpus 12 -o MyAssembly_23389.fa
4.	Now you have a cleaned up/renamed assembly where repeats have been softmasked, run funannotate train to align RNA-seq data, run Trinity, and then run PASA.
.. code-block::
  funannotate train -i MyAssembly_23389.fa -o fun \                                                              
    --left SRR1179894_R1.fastq.gz SRR1179897_R1.fastq.gz SRR9054433_R1.fastq.gz \                                                             
    --right SRR1179894_R2.fastq.gz SRR1179897_R2.fastq.gz SRR9054433_R2.fastq.gz \                                                              
    --nanopore_mrna PH1_mrna.fastq.gz \                                                              
    --stranded RF --jaccard_clip --species "Fusarium graminearum" \                                                              
    --strain STRAIN --cpus 12

You’ll notice that I flipped on the --jaccard_clip option, since we have a fungal genome we are expected high gene density. This script will run and produce an output directory called fun and sub-directory called training where it will house the intermediate files.
                                                              
5.	After training is run, the script will tell you what command to run next, in this case it is funannotate predict with the following options:
.. code-block:: 
  funannotate predict -i MyAssembly_23389.fa -o fun \
    --species "Fusarium graminearum" --strain 23389 \
    --cpus 12

The script will run through the gene prediction pipeline. Note that the scripts will automatically identify and reuse data from funannotate train, including using the PASA gene models to train Augustus. If some gene models are unable to be fixed automatically, it will warn you at the end of the script which gene models need to be manually fixed (there might be some errors in tbl2asn I’ve not seen yet or cannot be fixed without manual intervention).
                                                              
6.	Since we have RNA-seq data, we will use the funannotate update command to add UTR data to the predictions and fix gene models that are in disagreement with the RNA-seq data.
.. code-block:: 
  funannotate update -i fun --cpus 12

Since we ran funannotate train those data will be automatically parsed and used to update the UTR data using PASA comparison method. The script will then choose the best gene model at each locus using the RNA-seq data and pseudoalignment with Kallisto. The outputs from this script are located in the fun/update_results folder. User will be alerted to any gene models that need to be fixed before moving onto functional annotation.
                                                              
7.	Now we have NCBI compatible gene models, we can now add functional annotation to the protein coding gene models. This is done with the funannotate annotate  
command. But first we want to run InterProScan, Phobius, and antiSMASH.

7-1)	Running InterProScan5. You could install this locally and run with protein sequences. Otherwise, there are two other options, run from docker or run remotely using EBI servers. For our KSU samples, we have run InterProScan5 locally. 
.. code-block:: 
  #run using docker
  funannotate iprscan -i fun -m docker --cpus 12

  #run locally (Linux only)
  funannotate iprscan -i fun -m local --iprscan_path /my/path/to/interproscan.sh

7-2)	Now we want to run Phobius. Phobius can be run by using perl to execute the main script within a directory containing the source code. To complete this step, download the phobius source code here: https://phobius.sbc.su.se/data.html. Below is the general syntax for phobius:
.. code-block:: 
  perl /PATH/TO/phobius/phobius.pl /PATH/TO/update_results/proteins.fa

The code above will print out the results to the terminal. The code below is a general syntax used to write the phobius results to a text file “result.phobius”:
.. code-block:: 
  perl /PATH/TO/phobius/phobius.pl /PATH/TO/update_results/proteins.fa > results.phobius

7-3)	If annotating a fungal genome and you are interested in secondary metabolism gene clusters, you can run antiSMASH
.. code-block:: 
  funannotate remote -i fun -m antismash -e your-email@domain.edu

8.	Finally, you can run the funannotate annotate script incorporating the data you generated. Passing the funannotate folder will automatically incorporate the interproscan, antismash, phobius results.
.. code-block:: 
  funannotate annotate -i fun --cpus 12

Your results will be in the fun/annotate_results folder.
