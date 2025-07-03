// infile is from wolke oi-austausch/SolingenHoldings/de-Sol1HoldingsFromBridgeAfterAlephShutDown.jsonl.gz
// It is a bulk download of lobid resources filter to DE_SOl1 holdings.

infile
| open-file
| as-lines
| decode-json
| fix(FLUX_DIR + "identifier.fix")
| encode-csv(separator="\t", noquotes="true")
| write(FLUX_DIR +"identifier.tsv")
;