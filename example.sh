# make directory
mkdir -p out

# generate assembly (fasta)
./R_call.r R/gen_assembly.r gen.example \
	   ofn.fasta="out/example.fasta" \
	   ofn.table="out/example.tab"

# generate read coordinates
./R_call.r R/gen_read_coords.r gen.read.coords \
	   genome.table.ifn="out/example.tab" \
	   insert=200 insert.sd=100 read.length=150 \
	   ofn="out/example.coords"

# generate pair ended reads (fastq)
perl pl/generate_reads_pair.pl out/example.coords out/example.fasta out/R1.fastq out/R2.fastq

# plotting
./R_call.r R/plot_read_distrib.r plot.read.distrib \
	   ifn="out/example.coords" \
	   fdir="out/plots"
