default folderPath="test/output";
default outfile="test/output/combinedDe-Sol1Holdings.tsv";


folderPath
| read-dir(filenamepattern="sol1Holding_.*\\.tsv")
| open-file
| as-lines
| write(outfile)
;