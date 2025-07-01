default infile="test/input/sru_records_and_holdings.xml";

//Create mapping file of almaMmsIds:

infile
| open-file
| decode-xml
| handle-marcxml
| fix(FLUX_DIR + "zdbSru2LobidLink.fix")
| literal-to-object
| open-http(accept="application/json")
| as-records
| decode-json
| fix("retain('almaMmsId','zdbId')") 
| encode-csv(noQuotes="true",separator="\t")
| write(FLUX_DIR + "test/map/almaMmsId2ZdbId.tsv")
;

