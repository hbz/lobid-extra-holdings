# lobid-extra-holdings
Non-Alma holdings for lobid-resources (currently only DE-Sol1).

The holding for DE-Sol1 are provided as MAB and ALEPH Seq files, and for ZDB related resources as SRU/Marc records comining bibliographic as well as holding in on collection element . Find examples in `test/input`. Holdings are provided in separate records and items for the same resource need to be merged as different objects in `hasItem` for a single resource. Each item in `hasItem` represents a single holding item.

## Prerequisite

### Metafacture

For the metadata transformations [Metafacture](https://metafacture.org/) is used.
Until the SRU opener is part of an upcoming metafacture release (see: github.com/metafacture/metafacture-core/issues/510), a runner is included in the repo.

Paths in the following CLI commands may need to be adjusted.

### DE-Sol1 Strapi

In order to harvest the holdings from strapi  a running strapi instance for lobid-extra-holdings is needed.
[Look here how you set up a strapi-extra-holding instance locally.](https://github.com/hbz/strapi-extra-holdings)

The strapi instance replaces the static aleph data transformation since it allows to add, delete and change holding information.

### Transform aleph seq data for strapi

In order to import the Aleph Data into strapi it has to be transformed to match the structure of the contentTypes in strapi.
This transformation can be run with:

Test: `'./metafacture-core/flux.sh' 'flux/mab2De-Sol1Holdings_seq2strapi_test.flux'`
Prod: `'./metafacture-core/flux.sh' 'flux/mab2De-Sol1Holdings_seq2strapi_prod.flux'`

### Import transformed data into strapi

When the strapi instance is running you can import the result of the previous transformation with:
Test: `'./metafacture-core/flux.sh' 'flux/mab2De-Sol1_strapiImport_test.flux' API_TOKEN=... PATH="holdings"`
Prod: `'./metafacture-core/flux.sh' 'flux/mab2De-Sol1_strapiImport_prod.flux' API_TOKEN=... PATH="holdings"`

The API Key can be generated in the GUI of the Strapi instance under Settings.

### Export the data from strapi and save it locally

In order to use the strapi data in production for further processing it has to be exported to: `prod/input/strapi-export-holdings.ndjson`
This process will be automated when a productive strapi instance is deployed.

For test purposes `test/input/strapi-export-holdings.ndjson` exists.

## Creating a mapping file of extra holdings for lobid-resources

This process harvests SRU holdings and processes the locally saved strapi export.

### For test purposes run:

`bash harvestHoldings_test.sh './metafix-core/flux.sh'`

The tests use local sample files of the strapi export as well as a small sample of the SRU harvest.
If you want to update the testfiles for SRU you have to undo the outcommenting of the initial workjflow part of `flux/zdbSru2De-Sol1Holdings_marc_test.flux`

### Transformation of Strapi and SRU Data for production:
`bash harvestHoldings_prod.sh './metafix-core/flux.sh'`