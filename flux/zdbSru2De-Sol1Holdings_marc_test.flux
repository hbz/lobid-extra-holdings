default infile="test/input/sru_records_and_holdings.xml";
default outfile="test/output/sol1Holding_sru.json";
default outfile2="test/output/sol1Holding_sru.tsv";
default version="test/";


// The SRU records are provided as collections combining bibliographic and holding records
// Beside the combining collection tag there seems to be no linkage / reference between bibliographic and holdings.

infile
| open-file
// Step 1: Read the data as generic xml and copy the ZDB-ID to the Holding-Records as 004
// This is necessary to create the holdings in Step 2.
| decode-xml
| handle-generic-xml(recordtagname="collection", attributemarker="#")
| fix(FLUX_DIR + "../fix/setReference004.fix")
| encode-xml(recordtag="collection", attributemarker="#", valuetag="value")

// Step 2:  Read the records again, but this time as marcXml.
// Filter out all records but the holdings of DE-Sol1 and build the holding information in  JSOn
| lines-to-records 
| read-string
| decode-xml
| handle-marcxml(ignorenamespace="true")
| fix(FLUX_DIR + "../fix/zdbSru2De-Sol1Holdings_marc.fix",*) // creates holding information for Holding Records of DE-Sol1

// Step 4: Combine multiple holdings for one resource to one holding array/record.
| change-id(idliteral="almaMmsId")
| merge-same-ids  // merge records that belong to the same MMS I
| fix(FLUX_DIR + "../fix/combineHoldingsIntoHasItems.fix") // combine holding information in one hasItem statement.
| encode-json(prettyPrinting="true")
| write(outfile, header="[",footer="]", separator=",")
;


// Step5: Create a lookup file for lobid that has the almaMmsId in column 1 and the serialized json array of the holdings in column2
outfile
| open-file
| as-records
| decode-json(recordPath="*")
| fix(FLUX_DIR + "../fix/prepareHoldingForLobidLookupTsv.fix")
| batch-log(batchsize="10")
| encode-csv(includeHeader="true", separator="\t", noQuotes="true")
| write(outfile2)
;