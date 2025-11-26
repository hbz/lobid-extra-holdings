default folderPath="prod/output";
default outfile="prod/output/combinedDe-Sol1Holdings.tsv.gz";
default fileName="sol1Holding_(seq|sru)\\.tsv\\.gz";


folderPath
| read-dir(fileNamePattern=fileName)
| open-file
| as-lines
| write(outfile, compression="gzip")
;
