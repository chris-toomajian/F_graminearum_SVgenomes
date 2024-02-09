path_to_syri = /homes/upasanad/software/python/venv/bin/syri
refgenome = /homes/toomajia/Fg_GBS_reads/ref/ph1.fasta
python3 $path_to_syri -c out.sam -r refgenome -q 23522.trimmed.renamed.fasta -k -F S
