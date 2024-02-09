module load minimap2/2.18-GCCcore-10.2.0
#ref = /homes/toomajia/Fg_GBS_reads/ref/ph1.fasta 

minimap2 -ax asm5 --eqx /homes/toomajia/Fg_GBS_reads/ref/ph1.fasta 23522.fasta > out.sam
