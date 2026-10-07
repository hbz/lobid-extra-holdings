"test/map/almaMmsId2ZdbId.tsv"
| open-file
| as-lines
| decode-csv(separator="\t")
| fix("fix/containedInLobidLink.fix")
| literal-to-object
| catch-object-exception
| open-http(accept="application/json", header="User-Agent: lobid-extra-holdings for DE-Sol1 with Metafacture")
| as-records
| decode-json(recordPath="member")
| fix("fix/articleHoldings.fix")
| encode-json
| write("test/output/articleHoldings.json")
;
