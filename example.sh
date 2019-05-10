# make directory
mkdir -p out

# generate assembly
./R_call.r R/gen_assembly.r gen.example ofn.prefix="out/example"

# generate read coordinates
./R_call.r R/gen_read_coords.r gen.read.coords \
	   genome.table.ifn="out/example.tab" \
	   insert=200 insert.sd=100 read.length=150 \
	   ofn="out/example.coords"

# plotting
./R_call.r R/plot_read_distrib.r plot.read.distrib \
	   ifn="out/example.coords" \
	   fdir="plots"
