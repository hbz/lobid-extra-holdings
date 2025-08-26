#!/bin/sh

Metafacture_Runner=$1

# Test function for Testing if harvesting or transformation failed
die() {
    local message=$1

    echo "$message" >&2
    exit 1
}

# Create Holdings from old ALEPH Seq Dump
echo "Start transformation for ALEPH Seq Data" && date
$Metafacture_Runner flux/mab2De-Sol1Holdings_seq_test.flux outfile2="test/output/sol1Holding_seq.tsv" || die 'Harvesting or Transformation of Seq Data failed'


# Create Holdings from  ZDB SRU Request
echo "Start transformation for SRU Data" && date
$Metafacture_Runner flux/zdbSru2De-Sol1Holdings_marc_test.flux outfile2="test/output/sol1Holding_sru.tsv" || die 'Harvesting or Transformation of ZDB SRU Data failed'

# Concatinate results
echo "Combine output in single file combinedDe-Sol1Holdings.tsv" && date
$Metafacture_Runner flux/combineFiles_test.flux
echo "Done" && date
