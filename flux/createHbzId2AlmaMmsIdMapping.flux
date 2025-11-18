// infile is in https://wolke.hbz-nrw.de/index.php/apps/files/files/1074301?dir=/oi-austausch/SolingenHoldings/de-Sol1HoldingsFromBridgeAfterAlephShutDown.jsonl.gz
// it is the latest bridge dump of DE-Sol1 after shutting down DE-Sol1
// This workflow creates a lookupfile for test and prod to replace hbzIds with almaMmsIds or zdbIds with almaMmsIds


infile
| open-file
| as-lines
| decode-json
| fix(FLUX_DIR + "../fix/hbzId2AlmaMmsId.fix")
| encode-csv(separator="\t", noquotes="true")
| write(FLUX_DIR + "../prod/map/identifier.tsv")
;
