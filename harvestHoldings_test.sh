#!/bin/sh

Metafacture_Runner=$1

# Test function for Testing if harvesting or transformation failed
die() {
    local message=$1

    echo "$message" >&2
    exit 1
}

# Create Holdings from Strapi Export
echo "Start transformation for Strapi Export Data" && date
$Metafacture_Runner -f flux/strapi2lobid_test.flux -v outfile2="test/output/sol1Holding_strapiOut.tsv" || echo "Harvesting or Transformation of Strapi-Export Data failed, Exit-Code: $? . Old file will be used."


# Create Holdings from  ZDB SRU Request
echo "Start transformation for SRU Data" && date
$Metafacture_Runner -f flux/zdbSru2De-Sol1Holdings_marc_test.flux -v outfile2="test/output/sol1Holding_sru.tsv" || echo "Harvesting or Transformation of Seq Data failed, Exit-Code: $? . Old file will be used."

# Concatenate results
echo "Combine output in single file combinedDe-Sol1Holdings.tsv" && date
$Metafacture_Runner -f flux/combineFiles_test.flux -v outfile="test/output/combinedDe-Sol1Holdings.tsv" -v fileName="sol1Holding_(strapiOut|sru)\\.tsv"
echo "Done" && date
