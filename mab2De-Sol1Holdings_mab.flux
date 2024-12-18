infile
| open-file
| as-lines
| decode-mab
//| decode-marc21 // hbz18 normdata is gnd marc.
| fix("nothing()")
| encode-yaml
| write(FLUX_DIR + outfile + ".json")
;