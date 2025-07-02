#!/bin/sh

Metafacture_Runner=$1

# Create Mapping file for SRU

echo "Create Mapping for SRU" && date
$Metafacture_Runner flux/createZdbId2AlmaMmsIdMap_prod.flux

# Create Holdings from old ALEPH Seq Dump
echo "Start transformation for ALEPH Seq Data" && date
$Metafacture_Runner flux/mab2De-Sol1Holdings_seq_bulk.flux outfile2="prod/output/sol1Holding_seq.tsv.gz"

# Create Holdings from SRU Request
echo "Start transformation for SRU Data" && date
$Metafacture_Runner flux/zdbSru2De-Sol1Holdings_marc_bulk.flux outfile2="prod/output/sol1Holding_sru.tsv.gz"

# Concatinate results
echo "Combine output in single file combinedDe-Sol1Holdings.tsv.gz" && date
cat prod/output/sol1Holding_sru.tsv.gz prod/output/sol1Holding_seq.tsv.gz > "prod/output/combinedDe-Sol1Holdings.tsv.gz"
echo "Done" && date
