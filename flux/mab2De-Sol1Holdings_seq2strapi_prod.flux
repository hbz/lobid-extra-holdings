default infile="prod/input/export_mab_hbz60.z9035.f.20250108.091329.seq";
default outfile="prod/output/sol1Holding_seq2strapi.json.gz";


infile
| open-file
| as-lines
| decode-aseq
| merge-same-ids // combines the aseq statements in single records. 
| fix(FLUX_DIR + "../fix/mab2De-Sol1Holdings_seq2strapi.fix") // creates holding information for ME records, currently metadata from ML records are not used.
| change-id(idliteral="almaMmsId")
| merge-same-ids  // merge records that belong to the same MMS ID.
| fix(FLUX_DIR + "../fix/combineItemsForStrapi.fix") // combine holding information in one hasItem statement.
| batch-log(batchsize="1000")
| encode-json // newline json is better for big file
| write(outfile, compression="gzip") // compression is better for big file
;