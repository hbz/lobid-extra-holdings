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
$Metafacture_Runner flux/strapi2lobid_prod.flux outfile2="prod/output/sol1Holding_strapiOut.tsv.gz" || die 'Harvesting or Transformation of Seq Data failed'

# Create Holdings from ZDB SRU Request
echo "Start transformation for SRU Data" && date
$Metafacture_Runner flux/zdbSru2De-Sol1Holdings_marc_prod.flux outfile2="prod/output/sol1Holding_sru.tsv.gz" || die 'Harvesting or Transformation of ZDB SRU Data failed'

# Concatinate results
echo "Combine output in single file combinedDe-Sol1Holdings.tsv.gz" && date
$Metafacture_Runner flux/combineFiles_prod.flux outfile="prod/output/combinedDe-Sol1Holdings.tsv.gz" fileName="sol1Holding_(strapiOut|sru)\\.tsv.gz"
echo "Done" && date

numberOfLines=$(zcat ./prod/output/combinedDe-Sol1Holdings.tsv.gz | wc -l)
if [[ $numberOfLines -gt 80000 ]]; then
	cp ./prod/output/combinedDe-Sol1Holdings.tsv.gz ../lobid-resources/src/main/resources/alma/maps/combinedDe-Sol1Holdings.tsv.gz
    echo "Copy result to lobid-resources" && date
else
	echo "Number of lines ($numberOfLines) too small"
fi
