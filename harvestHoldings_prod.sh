#!/bin/sh

Metafacture_Runner=$1

# Create Mapping file for SRU

$Metafacture_Runner flux/createZdbId2AlmaMmsIdMap_prod.flux

# Create Holdings from old ALEPH Seq Dump
echo "Start transformation for ALEPH Seq Data" && date
$Metafacture_Runner flux/mab2De-Sol1Holdings_seq_prod.flux outfile2="prod/output/sol1Holding_seq.tsv.gz"

# Create Holdings from SRU Request
echo "Start transformation for SRU Data" && date
$Metafacture_Runner flux/zdbSru2De-Sol1Holdings_marc_prod.flux outfile2="prod/output/sol1Holding_sru.tsv.gz"

# Concatinate results
echo "Combine output in single file combinedDe-Sol1Holdings.tsv.gz" && date
$Metafacture_Runner flux/combineFiles_prod.flux
echo "Done" && date
