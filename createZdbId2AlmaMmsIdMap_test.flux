default infile="test/input/sru_records_and_holdings.xml";
default outfile="test/output/sol1Holding_sru.json";
default outfile2="test/output/sol1Holding_sru.tsv";

//Create mapping file of almaMmsIds:

infile
| open-file
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
| write(FLUX_DIR + "test/map/almaMmsId2ZdbId.tsv")
;

