save.table=function(x, ofn, verbose=T)
{
    if (verbose) cat(sprintf("saving result table: %s\n", ofn))
    write.table(x, ofn, quote=F, row.names=F, sep="\t")
}

# seq.vec: list of strings
# xcoverage: vector of read xcoverage (same length as seq.vec)
# ofn: filename
# line.width: length of line
save.seq.vector=function(seq.list, xcov, circ, ofn.fasta, ofn.table, line.width=80)
{
    df = data.frame(contig=names(seq.list), length=0, xcov=xcov, circ=circ)

    N = length(seq.list)
    lines = NULL
    for (i in 1:N) {
        contig = names(seq.list)[i]
        seq.v = seq.list[[i]]
        M = length(seq.v)
        mm = t(matrix("", ceiling(M/line.width), line.width))
        mm[1:M] = seq.v
        mm = t(mm)
        ss = apply(mm, 1, function(x) paste(x, collapse=""))

        lines = c(lines, sprintf(">%s", contig))
        lines = c(lines, ss)
        df$length[i] = M
    }

    cat(sprintf("saving fasta file: %s\n", ofn.fasta))
    fc = file(ofn.fasta)
    writeLines(lines, fc)
    close(fc)

    save.table(df, ofn.table)
}

gen.example=function(ofn.fasta, ofn.table)
{
    get.seq=function(N) {
        nts = c("A", "G", "C", "T")
        seq.i = floor(runif(N) * 4) + 1
        seq.v = nts[seq.i]
    }
    a = get.seq(10000)
    b = get.seq(10000)
    p = get.seq(2000)
    seq.list = list(m1=c(a,p,b), m2=p)
    xcov = c(100,1000)
    circ = c(F,T)
    save.seq.vector(seq.list=seq.list, xcov=xcov, circ=circ, ofn.fasta=ofn.fasta, ofn.table=ofn.table)
}
