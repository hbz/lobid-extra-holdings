#!/bin/sh

Metafacture_Runner=$1

# Create Mapping file for SRU

echo "Create Mapping for SRU"
$Metafacture_Runner createZdbId2AlmaMmsIdMap_prod.flux

# Create Holdings from old ALEPH Seq Dump
echo "Start transformation for ALEPH Seq Data"
$Metafacture_Runner mab2De-Sol1Holdings_seq_bulk.flux outfile2="prod/output/combinedDe-Sol1Holdings_seq.tsv.gz"

# Create Holdings from SRU Request
echo "Start transformation for SRU Data"
$Metafacture_Runner zdbSRUMarcBibliographicAndHoldings2De-Sol1Holdings_bulk.flux outfile2="prod/output/combinedDe-Sol1Holdings_sru.tsv.gz"

# Concatinate results
echo "Combine output in single file combinedDe-Sol1Holdings.tsv.gz"
cat prod/output/*.tsv.gz > "prod/output/combinedDe-Sol1Holdings.tsv.gz"
