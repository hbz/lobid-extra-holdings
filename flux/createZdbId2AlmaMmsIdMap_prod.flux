//Create mapping file of almaMmsIds:

"https://services.dnb.de/sru/zdb"
| open-sru(recordSchema="MARC21plus-xml", query="dnb.isil%3DDE-Sol1",version="1.1",maximumRecords="100")
| decode-xml
| handle-marcxml
| fix(
	"do list(path:'0167 ', 'var':'$i')
		if any_match('$i.2','DE-600')
			copy_field('$i.a','zdblobidLink')
		end
	end
	prepend('zdblobidLink','https://lobid.org/resources/')
	unless exists('zdblobidLink')
		reject()
	end
	retain('zdblobidLink')")
| literal-to-object
| open-http(accept="application/json")
| as-records
| decode-json
| fix("retain('almaMmsId','zdbId')") 
| encode-csv(noQuotes="true",separator="\t")
| write("prod/map/almaMmsId2zdbId.tsv")
;

