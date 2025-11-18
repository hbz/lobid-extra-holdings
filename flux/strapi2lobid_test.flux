default infile="test/input/strapi-export-holdings.ndjson";
default outfile="test/output/sol1Holding_strapiOut.json";
default outfile2="test/output/sol1Holding_strapiOut.tsv";
default source="strapi";


infile
| open-file
| as-lines
| decode-json(recordPath="data")
| fix(FLUX_DIR + "../fix/strapi2De-Sol1Holdings.fix")
| encode-json(prettyPrinting="true")
| write(outfile, header="[", footer="]", separator=",")
;

outfile
| open-file
| as-records
| decode-json(recordPath="*")  // Specify record path due to prettyPrinting and combining in one record.
| fix(FLUX_DIR + "../fix/prepareHoldingForLobidLookupTsv.fix", *)
| batch-log(batchsize="10")
| encode-csv(includeHeader="true", separator="\t", noQuotes="true")
| write(outfile2)
;
