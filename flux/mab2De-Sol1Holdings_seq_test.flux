default infile="test/input/export_mab_hbz60.example.seq";
default outfile="test/output/sol1Holding_seq.json";
default outfile2="test/output/sol1Holding_seq.tsv";
default source="aleph seq";


infile
| open-file
| as-lines
| decode-aseq
| merge-same-ids // combines the aseq statements in single records.
| fix(FLUX_DIR + "../fix/mab2De-Sol1Holdings_seq.fix") // creates holding information for ME records, currently metadata from ML records are not used.
| change-id(idliteral="almaMmsId")
| merge-same-ids  // merge records that belong to the same MMS ID.
| fix(FLUX_DIR + "../fix/combineHoldingsIntoHasItems.fix") // combine holding information in one hasItem statement.
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
