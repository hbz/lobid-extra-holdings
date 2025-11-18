default sruHarvest="test/input/sru_records_and_holdings.xml";
default outfile="test/output/sol1Holding_sru.json";
default outfile2="test/output/sol1Holding_sru.tsv";
default version="test/";
default source="sru/zdb";

// The SRU records are provided as collections combining bibliographic and holding records
// Beside the combining collection tag there seems to be no linkage / reference between bibliographic and holdings.


// FOR UPDATING THE TESTFILE DELETE THE COMMENT PREFIX FOR L 12-18

//"https://services.dnb.de/sru/zdb"
//| open-sru(recordSchema="MARC21plus-xml", query="dnb.isil%3DDE-Sol1", version="1.1", maximumRecords="5", total="20")
//| as-records
//// The following two steps create a single xml file from the multiple incoming sru requests, saved into a harvest tag
//| match(pattern="<\\?xml version=.*?>", replacement="")
//| write(sruHarvest, header="<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<harvest>", footer="</harvest>")
//;

// Step 1: Create mapping file of zdbId -> almaMmsIds, this will be used in later process in step 3:

sruHarvest
| open-file
| decode-xml
| handle-marcxml
| fix(FLUX_DIR + "../fix/zdbSru2LobidLink.fix")
| literal-to-object
| open-http(accept="application/json", header="User-Agent: lobid-extra-holdings for DE-Sol1 with Metafacture")
| as-records
| decode-json(recordPath="member")
| fix(FLUX_DIR + "../fix/zdbSru2LobidMap.fix")
| encode-csv(noQuotes="true", separator="\t")
| write("test/map/almaMmsId2ZdbId.tsv")
;

// Step 2: Read the data as generic xml and copy the ZDB-ID to the Holding-Records as 004
// This is necessary to create the holdings in Step 2.
sruHarvest
| open-file
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
| write(outfile, header="[", footer="]", separator=",")
;


// Step5: Create a lookup file for lobid that has the almaMmsId in column 1 and the serialized json array of the holdings in column2
outfile
| open-file
| as-records
| decode-json(recordPath="*")
| fix(FLUX_DIR + "../fix/prepareHoldingForLobidLookupTsv.fix",*)
| batch-log(batchsize="10")
| encode-csv(includeHeader="true", separator="\t", noQuotes="true")
| write(outfile2)
;
