# lobid-extra-holdings
Non-Alma holdings for lobid-resources (currently only DE-Sol1).

The holding for DE-Sol1 are provided as MAB and ALEPH Seq files. Find examples in `test/input`. Holdings are provided in separate records and items for the same resource need to be merged as different objects in `hasItem` for a single resource. Each item in `hasItem` represents a single holding item.

## To run transformation workflow process the flux file with your current metafacture runner.

For the transformations Metafacture is used. 

You need the current runner of metafacture fix release: https://github.com/metafacture/metafacture-fix/releases

Paths in the following CLI commands may need to be adjusted.

### For test purposes run:

#### Test transformation of MAB Data:
`$ '/path/to/your/metafix-runner-1.1.2/bin/metafix-runner' 'mab2De-Sol1Holdings_mab.flux'`

#### Test transformation of ALEPH SEQ Data:
`$ '/path/to/your/metafix-runner-1.1.2/bin/metafix-runner' 'mab2De-Sol1Holdings_seq.flux'`

### For complete prod bulk run:
You need to have a mab or aleph seq file placed in `prod/input`

#### Transformation of MAB Data:
`$ '/path/to/your/metafix-runner-1.1.2/bin/metafix-runner' 'mab2De-Sol1Holdings_mab.flux' outfile="prod/output/<<YOUR_OUTPUT_FILE>>.json" infile='prod/input/<<YOUR_INPUT_FILE>>.mab'`

#### Transformation of ALEPH SEQ Data:
`'/path/to/your/metafix-runner-1.1.2/bin/metafix-runner' 'mab2De-Sol1Holdings_seq.flux'  outfile="prod/output/<<YOUR_OUTPUT_FILE>>.json" infile='prod/input/<<YOUR_INPUT_FILE>>.seq'`