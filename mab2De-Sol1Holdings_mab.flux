default infile="test/input/export_mab_HBZ60.example.mab";
default outfile="test/output/sol1Holding_mab.json";

infile
| open-file
| as-lines
| decode-mab
//| decode-marc21 // hbz18 normdata is gnd marc.
| fix(FLUX_DIR + "mab2De-Sol1Holdings_mab.fix") // creates holding information for ME records, currently metadata from ML records are not used.
| change-id(idliteral="almaMmsId")
| merge-same-ids  // merge records that belong to the same MMS ID.
| fix(FLUX_DIR + "combineHoldingsIntoHasItems.fix") // combine holding information in one hasItem statement.
| encode-json(prettyPrinting="true")
| write(FLUX_DIR + outfile, header="[",footer="]", separator=",")
;