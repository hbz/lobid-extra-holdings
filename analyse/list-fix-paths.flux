default infile="prod/input/export_mab_hbz60.z9035.f.20250108.091329.seq";
default RECORDTYPE="ML";

infile
| open-file
| as-lines
| decode-aseq
| merge-same-ids // combines the aseq statements in single records. 
| fix(FLUX_DIR + "mab2path_seq.fix") // creates holding information for ME records, currently metadata from ML records are not used.
| change-id(idliteral="almaMmsId",keepidliteral="true")
| merge-same-ids  // merge records that belong to the same MMS ID.
| fix(FLUX_DIR + "filterRecords.fix")

// For Fields:
//| stream-to-triples
//| count-triples(countBy = "predicate")
//| sort-triples(by="object",numeric="true", order="DECREASING")
//| template("${s}\t|\t${o}")
//| encode-json

// For: Fix-Paths
| list-fix-paths(count="false")
| write(FLUX_DIR + "paths.txt")
;