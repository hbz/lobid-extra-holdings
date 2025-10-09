default infile="prod/output/sol1Holding_sru.json";

infile
| open-file
| as-lines
| decode-json
| list-fix-values("id")
| write(FLUX_DIR + "test.txt")
;