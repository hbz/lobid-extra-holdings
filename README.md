# lobid-extra-holdings
Non-Alma holdings for lobid-resources (currently only DE-Sol1).

The holding for DE-Sol1 are provided as MAB and ALEPH Seq files, and for ZDB related resources as SRU/Marc records comining bibliographic as well as holding in on collection element . Find examples in `test/input`. Holdings are provided in separate records and items for the same resource need to be merged as different objects in `hasItem` for a single resource. Each item in `hasItem` represents a single holding item.

The concept is the following:


```mermaid
flowchart TD
 subgraph s1["lobid-extra-holdings"]
        n5["Combine Holding Data"]
        n2["ALEPH-Transformation for<br>De-Sol1 Holdings Lobid Mapping"]
        n4["ZDB-Transformation for<br>De-Sol1 Holdings Lobid Mapping"]
        n6["Strapi-Transformation for<br>De-Sol1 Holdings Lobid Mapping"]
        n7["tsv for lobid-resources Transformation"]
  end
    n2 --> n5
    n4 --> n5
    n1["hbz60 Aleph<br>De-Sol1 Dump"] -- use local dump --> n2
    A["ZDB"] -- "query DE-Sol1 via SRU" --> n4
    n1 -. transform local dump to strapi data</br>(then it will be replaced) .-> n3["De-Sol1<br>Strapi"]
    n3 -.-> n6
    n6 -.-> n5
    n5 --> n7
    n8["Weekly Cronjob"] -.-> s1
    n9["lobid-resources ETL"] --> n7

    n5@{ shape: rounded}
    n2@{ shape: rounded}
    n4@{ shape: rounded}
    n6@{ shape: rounded}
    n7@{ shape: stored-data}
    n1@{ shape: stored-data}
    A@{ shape: db}
    n3@{ shape: db}
    n8@{ shape: event}
    n9@{ shape: procs}
```

Currently we are in the works of setting up the strapi that will replace the static ALEPH data transformation.

## To run transformation workflow process the flux file with your current metafacture runner.

For the transformations Metafacture is used. A runner is included in the repo.

Paths in the following CLI commands may need to be adjusted.

### For test purposes run:

`bash harvestHoldings_test.sh './metafix-core/flux.sh'`

If you want to update the testfiles for SRU you have to undo the outcommenting of the initial workjflow part of `flux/zdbSru2De-Sol1Holdings_marc_test.flux`

### For complete prod bulk run:
You need to have an aleph seq file placed in `prod/input` as well as an internet connection running to fetch data from SRU as well as from lobid resources.

#### Transformation of MAB Data:
`bash harvestHoldings_prod.sh './metafix-core/flux.sh'`
