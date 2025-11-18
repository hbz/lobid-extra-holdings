default folderPath="test/output";
default outfile="test/output/combinedDe-Sol1Holdings.tsv";
default fileName="sol1Holding_(seq|sru)\\.tsv";

folderPath
| read-dir(filenamepattern=fileName)
| open-file
| as-lines
| write(outfile)
;
