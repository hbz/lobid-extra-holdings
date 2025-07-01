default outfile="prod/output/sol1Holding_sru.json.gz";
default outfile2="prod/output/sol1Holding_sru.tsv.gz";
default version="";

// The SRU records are provided as collections combining bibliographic and holding records
// Beside the combining collection tag there seems to be no linkage / reference between bibliographic and holdings.

"https://services.dnb.de/sru/zdb"
| open-sru(recordSchema="MARC21plus-xml", query="dnb.isil%3DDE-Sol1",version="1.1",maximumRecords="1000")
// Step 1: Read the data as generic xml and copy the ZDB-ID to the Holding-Records as 004
// This is necessary to create the holdings in Step 2.
| decode-xml
| handle-generic-xml(recordtagname="collection", attributemarker="#")
| fix(FLUX_DIR + "setReference004.fix")
| encode-xml(recordtag="collection", attributemarker="#", valuetag="value")

// Step 2:  Read the records again, but this time as marcXml.
// Filter out all records but the holdings of DE-Sol1 and build the holding information in  JSOn
| lines-to-records 
| read-string
| decode-xml
| handle-marcxml(ignorenamespace="true")
| fix(FLUX_DIR + "zdbSru2De-Sol1Holdings_marc.fix",*) // creates holding information for Holding Records of DE-Sol1

// Step 4: Combine multiple holdings for one resource to one holding array/record.
| change-id(idliteral="almaMmsId")
| merge-same-ids  // merge records that belong to the same MMS I
| fix(FLUX_DIR + "combineHoldingsIntoHasItems.fix") // combine holding information in one hasItem statement.
| encode-json // newline json is better for big file
| write(FLUX_DIR + outfile, compression="gzip") // compression is better for big file
;


// Step5: Create a lookup file for lobid that has the almaMmsId in column 1 and the serialized json array of the holdings in column2
FLUX_DIR + outfile
| open-file
| as-lines
| decode-json
| fix(FLUX_DIR + "prepareHoldingForLobidLookupTsv.fix") 
| encode-csv(includeHeader="true", separator="\t", noQuotes="true")
| write(FLUX_DIR + outfile2, compression="gzip")
;