# lobid-extra-holdings
Non-Alma holdings for lobid-resources (currently only DE-Sol1).

The holding for DE-Sol1 are provided as MAB and ALEPH Seq files. Find examples in `test/input`. Holdings are provided in separate records and items for the same resource need to be merged as different objects in `hasItem` for a single resource. Each item in `hasItem` represents a single holding item.

## To run transformation workflow process the flux file with your current metafacture runner.

### For test purposes run:

#### Test transformation of MAB Data:
`$ '/home/user/Downloads/metafix-runner-1.1.2/bin/metafix-runner' '/home/user/git/lobid-extra-holdings/mab2De-Sol1Holdings_mab.flux'`

#### Test transformation of ALEPH SEQ Data:
`$ '/home/user/Downloads/metafix-runner-1.1.2/bin/metafix-runner' '/home/user/git/lobid-extra-holdings/mab2De-Sol1Holdings_seq.flux'`

### For complete prod bulk run:
You need to have a mab or aleph seq file placed in `prod/input`

#### Transformation of MAB Data:
`$ '/home/user/Downloads/metafix-runner-1.1.2/bin/metafix-runner' '/home/user/git/lobid-extra-holdings/mab2De-Sol1Holdings_mab.flux' outfile="prod/output/<<YOUR_OUTPUT_FILE>>.json" infile='/home/user/git/lobid-extra-holdings/test/input/<<YOUR_INPUT_FILE>>.mab'`

#### Transformation of ALEPH SEQ Data:
`$ '/home/user/Downloads/metafix-runner-1.1.2/bin/metafix-runner' '/home/user/git/lobid-extra-holdings/mab2De-Sol1Holdings_seq.flux' outfile="test/output/<<YOUR_OUTPUT_FILE>>.json" infile='/home/user/git/lobid-extra-holdings/test/input/<<YOUR_INPUT_FILE>>.seq`
