default outfile="test/input/sru_records_and_holdings.xml";

"https://services.dnb.de/sru/zdb"
| open-sru(recordSchema="MARC21plus-xml", query="dnb.isil%3DDE-Sol1",version="1.1",maximumRecords="5",total="20")
| as-records
// following two steps create a single xml file from the multiple incoming sru requests, saved into a harvest tag
| match(pattern="<\\?xml version=.*?>", replacement="")
| write(outfile, header="<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<harvest>",footer="</harvest>")
;
