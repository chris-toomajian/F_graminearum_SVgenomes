#conda activate plotsr

plotsr --sr 23468.syri.out \
       --genomes 23468.genomes.txt \
       --tracks tracks.txt \
       --itx \
       -s 5000 \
       -o 23468_plot.png \
       -S 0.5 -W 15 -H 5 -f 15
