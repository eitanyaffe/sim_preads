
SET=$1

# make directory
mkdir -p out/$SET

# generate assembly (fasta)
./R_call.r R/gen_assembly.r gen.$SET \
	   ofn.fasta="out/$SET/mol.fasta" \
	   ofn.table="out/$SET/mol.tab"
rc=$?; if [ $rc -ne 0 ]; then exit 1; fi

# generate read coordinates
./R_call.r R/gen_read_coords.r gen.read.coords \
	   genome.table.ifn="out/$SET/mol.tab" \
	   insert=200 insert.sd=100 read.length=150 \
	   ofn="out/$SET/mol.coords"
rc=$?; if [ $rc -ne 0 ]; then exit 1; fi

# generate pair ended reads (fastq)
perl pl/generate_reads_pair.pl out/$SET/mol.coords out/$SET/mol.fasta out/$SET/R1.fastq out/$SET/R2.fastq
rc=$?; if [ $rc -ne 0 ]; then exit 1; fi

# plotting
./R_call.r R/plot_read_distrib.r plot.read.distrib \
	   ifn="out/$SET/mol.coords" \
	   fdir="out/$SET/plots"
rc=$?; if [ $rc -ne 0 ]; then exit 1; fi
