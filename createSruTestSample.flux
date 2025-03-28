default outfile="test/input/sru_records_and_holdings.xml";

"https://services.dnb.de/sru/zdb"
| open-sru(recordSchema="MARC21plus-xml", query="dnb.isil%3DDE-Sol1",version="1.1",maximumRecords="20",total="20")
| as-records
| write(outfile)
;
