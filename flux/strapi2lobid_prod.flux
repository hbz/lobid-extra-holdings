default infile="prod/input/strapi-export-holdings.ndjson";
default outfile="prod/output/sol1Holding_strapiOut.json";
default outfile2="prod/output/sol1Holding_strapiOut.tsv";
default source="strapi";


infile
| open-file
| as-lines
| decode-json(recordPath="data")
| fix(FLUX_DIR + "../fix/strapi2De-Sol1Holdings.fix")
| encode-json // newline json is better for big file
| write(outfile, compression="gzip") // compression is better for big file
;

outfile
| open-file
| as-lines
| decode-json
| fix(FLUX_DIR + "../fix/prepareHoldingForLobidLookupTsv.fix", *)
| batch-log(batchsize="1000")
| encode-csv(includeHeader="true", separator="\t", noQuotes="true")
| write(outfile2, compression="gzip")
;
