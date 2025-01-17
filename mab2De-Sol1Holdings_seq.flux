default infile="test/input/export_mab_hbz60.example.seq";
default outfile="test/output/sol1Holding_seq.json";

infile
| open-file
| as-lines
| decode-aseq
| merge-same-ids // combines the aseq statements in single records. 
| fix(FLUX_DIR + "mab2De-Sol1Holdings_seq.fix") // creates holding information for ME records, currently metadata from ML records are not used.
| change-id(idliteral="almaMmsId")
| merge-same-ids  // merge records that belong to the same MMS ID.
| fix(FLUX_DIR + "combineHoldingsIntoHasItems.fix") // combine holding information in one hasItem statement.
| encode-json(prettyPrinting="true")
| write(FLUX_DIR + outfile)
;