default folderPath="prod/output";
default outfile="prod/output/combinedDe-Sol1Holdings.tsv.gz";


folderPath
| read-dir(filenamepattern="sol1Holding_.*.*\\.tsv\\.gz")
| open-file
| as-lines
| write(outfile, compression="gzip")
;