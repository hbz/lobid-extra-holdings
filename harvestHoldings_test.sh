#!/bin/sh

Metafacture_Runner=$1

# Create Mapping file for SRU

$Metafacture_Runner createZdbId2AlmaMmsIdMap_test.flux

# Create Holdings from old ALEPH Seq Dump

$Metafacture_Runner mab2De-Sol1Holdings_seq_test.flux outfile2="test/output/combinedDe-Sol1Holdings.tsv"

# Create Holdings from SRU Request

$Metafacture_Runner zdbSRUMarcBibliographicAndHoldings2De-Sol1Holdings_test.flux outfile2="test/output/combinedDe-Sol1Holdings.tsv"

