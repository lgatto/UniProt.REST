[![Build Status](https://travis-ci.org/lgatto/UniProt.REST.svg?branch=master)](https://travis-ci.org/lgatto/UniProt.REST)
[![codecov](https://codecov.io/gh/lgatto/UniProt.REST/branch/master/graph/badge.svg)](https://codecov.io/gh/lgatto/UniProt.REST)

# An R Interface to UniProt REST API

The *UniProt.RES* package is an R interface to UniProt's Proteins REST
API, giving access to key biological data from UniProt and data from
Large Scale Studies data mapped to UniProt.


## The [Proteins REST API](https://www.ebi.ac.uk/proteins/api/doc/swagger/)

> The Proteins REST API provides access to key biological data from
> UniProt and data from Large Scale Studies data mapped to
> UniProt. The services provide sequence feature annotations from
> UniProtKB, variation data from UniProtKB and mapped from Large Scale
> data sources (1000 Genomes, ExAC and COSMIC), proteomics data mapped
> from Large Scale sources (PeptideAtlas, MaxQB and EPD) and genome
> coordinate mappings.

## The API:

### Proteins

        get /proteins
            get list of UniProt entries
        get /proteins/{accession}
            get UniProt entry by accession
        get /proteins/{accession}/isoforms
            get UniProt isoform entries from parent normal entry accession
        get /proteins/{dbtype}:{dbid}
            get UniProt entries by uniprot cross reference and its id


```r
library("UniProt.REST")
```

```
## 
## This is 'UniProt.REST' version 0.1.0
```

```r
ac <- "P27361"
acs <- c("P27361", "P38398")

UniProtProtein(ac)
```

```
## A Protein retrieved from 'UnitProt.REST'
##  Available data for P27361:
##   accession name protein gene organism reference comment dbReference
##   proteinExistence keyword feature evidence sequence
```

```r
UniProtProteins(acs) ## works also as UniProtProtein(ac)
```

```
## $entry
## A Protein retrieved from 'UnitProt.REST'
##  Available data for P38398:
##   accession name protein gene organism reference comment dbReference
##   proteinExistence keyword feature evidence sequence
## 
## $entry
## A Protein retrieved from 'UnitProt.REST'
##  Available data for P27361:
##   accession name protein gene organism reference comment dbReference
##   proteinExistence keyword feature evidence sequence
```

```r
UniProtProteinIsoforms(ac)
```

```
## $entry
## A Protein retrieved from 'UnitProt.REST'
##  Available data for P27361-3:
##   accession name protein gene organism reference comment dbReference
##   proteinExistence sequence
## 
## $entry
## A Protein retrieved from 'UnitProt.REST'
##  Available data for P27361-2:
##   accession name protein gene organism reference comment dbReference
##   proteinExistence sequence
## 
## $entry
## A Protein retrieved from 'UnitProt.REST'
##  Available data for P27361-1:
##   accession name protein gene organism reference comment dbReference
##   proteinExistence sequence
```

### Variation

        get /variation
            get variation by search
        get /variation/{accession}
            get UniProt variation features by accession

### Features

        get /features
            get features of list of UniProt entries.
        get /features/type/{type}
            Search for features of given type and search terms.
        get /features/{accession}
            get UniProt features by accession

### Antigen

        get /antigen
            Get antigen of list of UniProt accessions.
        get /antigen/{accession}
            Get antigens mapped to UniProt by accession

### Proteomics

        get /proteomics
            Get proteomics peptides of list of UniProt accessions.
        get /proteomics/{accession}
            Get proteomics peptides mapped to UniProt by accession

### Proteomes

        get /proteomes
            Search Proteomes
        get /proteomes/genecentric/{upid}
            fetch proteome gene centric proteins by proteome upid
        get /proteomes/proteins/{upid}
            fetch proteome proteins by proteome upid
        get /proteomes/{upid}
            fetch proteome by proteome upid

### Coordinates

        get /coordinates
            query for entries with genomic location
        get /coordinates/{accession}
            Get Genome Coordinates by accession.
        get /coordinates/{dbtype}:{dbid}
            get by database cross reference: Ensembl, CCDS, HGNC or RefSeq
        get /coordinates/{taxonomy}/{chromosome}:{gstart}-{gend}
            get genome coordinate by genome locatio
