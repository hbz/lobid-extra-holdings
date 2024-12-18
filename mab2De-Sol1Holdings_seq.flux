infile
| open-file
| as-lines
| decode-aseq
| merge-same-ids 
| fix(FLUX_DIR + "mab2De-Sol1Holdings_seq.fix")
| encode-json(prettyPrinting="true")
| write(FLUX_DIR + outfile + ".json")
;