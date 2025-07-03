#!/bin/sh

Metafacture_Runner=$1

# Create Mapping file for SRU

$Metafacture_Runner createZdbId2AlmaMmsIdMap_prod.flux

# Create Holdings from old ALEPH Seq Dump

$Metafacture_Runner mab2De-Sol1Holdings_seq_prod.flux outfile2="prod/output/combinedDe-Sol1Holdings.tsv.gz"

# Create Holdings from SRU Request

$Metafacture_Runner zdbSRUMarcBibliographicAndHoldings2De-Sol1Holdings_prod.flux outfile2="prod/output/combinedDe-Sol1Holdings.tsv.gz"

