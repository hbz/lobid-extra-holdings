//Create mapping file of almaMmsIds:

"https://services.dnb.de/sru/zdb?version=1.1&operation=searchRetrieve&query=dnb.isil%3DDE-Sol1&recordSchema=MARC21plus-xml"
| open-http // needs to be replaced by open-sru
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
| write(FLUX_DIR + "map/almaMmsId2zdbId.tsv")
;

