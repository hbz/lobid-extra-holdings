FLUX_DIR + "result.tsv" // Result of the Values in 077b in ALeph Dump
| open-file
| as-lines
| decode-csv(hasHeader="true",separator="\t")
| change-id(idliteral="zdbId",keepidliteral="true")
| stream-to-triples
| @x;

FLUX_DIR + "identifier.tsv" // Result of filter from bridge values
| open-file
| as-lines
| decode-csv(hasHeader="true",separator="\t")
| fix("
	unless exists('zdbId')
		reject()
	end
")
| change-id(idliteral="zdbId",keepidliteral="true")
| stream-to-triples
| @x;

@x
|wait-for-inputs("2")
|sort-triples
|collect-triples
|encode-json
|write(FLUX_DIR + "resultMissingZdb.txt");
