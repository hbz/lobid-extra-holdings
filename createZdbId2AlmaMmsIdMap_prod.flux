//Create mapping file of almaMmsIds:

"https://services.dnb.de/sru/zdb"
| open-sru(recordSchema="MARC21plus-xml", query="dnb.isil%3DDE-Sol1",version="1.1",maximumRecords="100")
| decode-xml
| handle-marcxml
| fix(FLUX_DIR + "zdbSru2LobidLink.fix")
| literal-to-object
| open-http(accept="application/json")
| as-records
| decode-json
| fix("retain('almaMmsId','zdbId')") 
| encode-csv(noQuotes="true",separator="\t")
| write(FLUX_DIR + "map/almaMmsId2zdbId.tsv")
;

