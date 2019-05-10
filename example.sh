# make directory
mkdir -p out

# generate assembly
# TODO: copy and edit the gen.example function
./R_call.r gen_assembly.r gen.example ofn.prefix="out/x"

# generate read coordinates
./R_call.r gen_read_coords.r gen.read.coords \
	   genome.table.ifn="out/x.tab" \
	   base.length=100 insert=300 insert.sd=200 read.length=150 \
	   ofn="out/coord.tab"
