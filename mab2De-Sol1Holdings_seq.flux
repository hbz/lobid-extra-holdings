infile
| open-file
| as-lines
| decode-aseq
| merge-same-ids 
| fix("nothing()")
| encode-json
| write(FLUX_DIR + outfile + ".json")
;