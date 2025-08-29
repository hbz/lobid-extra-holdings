#!/bin/sh

Metafacture_Runner=$1

# Create Holdings from Strapi Export
echo "Start transformation for Strapi Export Data" && date
$Metafacture_Runner flux/strapi2lobid_prod.flux outfile2="test/output/sol1Holding_strapiOut.tsv.gz"

# Create Holdings from SRU Request
echo "Start transformation for SRU Data" && date
$Metafacture_Runner flux/zdbSru2De-Sol1Holdings_marc_prod.flux outfile2="prod/output/sol1Holding_sru.tsv.gz"

# Concatinate results
echo "Combine output in single file combinedDe-Sol1Holdings.tsv.gz" && date
$Metafacture_Runner flux/combineFiles_prod.flux outfile="prod/output/combinedDe-Sol1Holdings.tsv.gz" fileName="sol1Holding_(strapiOut|sru)\\.tsv.gz"
echo "Done" && date
echo "Done" && date
