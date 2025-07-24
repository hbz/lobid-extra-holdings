#!/bin/sh

Metafacture_Runner=$1

# Create Holdings from Strapi Export
echo "Start transformation for Strapi Export Data" && date
$Metafacture_Runner flux/strapi2lobid_test.flux outfile2="test/output/sol1Holding_strapiOut.tsv"

# Create Holdings from SRU Request
echo "Start transformation for SRU Data" && date
$Metafacture_Runner flux/zdbSru2De-Sol1Holdings_marc_test.flux outfile2="test/output/sol1Holding_sru.tsv"

# Concatinate results
echo "Combine output in single file combinedDe-Sol1Holdings.tsv" && date
$Metafacture_Runner flux/combineFiles_test.flux outfile="test/output/combinedDe-Sol1Holdings_withStrapi.tsv" fileName="sol1Holding_(strapiOut|sru)\\.tsv"
echo "Done" && date
