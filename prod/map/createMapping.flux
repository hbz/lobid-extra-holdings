infile
| open-file
| as-lines
| decode-json
| fix(FLUX_DIR + "identifier.fix")
| encode-csv(separator="\t", noquotes="true")
| write(FLUX_DIR +"identifier.tsv")
;