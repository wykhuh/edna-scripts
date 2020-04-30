# scripts for eDNA analysis

### rename_sample_headers.R

`rename_sample_headers.R` - clean up the sample names from an Anacapa taxonomy table CSV using the sample names from a phyloseq metadata CSV. 

- The script create a new taxonomy file that has an extra header row with the new sample names. Users can review the changes, and delete old sample names.
- The sample names in the two files do not have to be in the same order. 

taxonomy sample names
```
sum.taxonomy,X16S_ASWS_B0.35.S35.L001,X16S_ASWS_E0.36.S36.L001	
```

metadata sample names
```
sum.taxonomy
ASWS_E0
ASWS_B0
```
updated taxonomy sample names

```
sum.taxonomy,X16S_ASWS_B0.35.S35.L001,X16S_ASWS_E0.36.S36.L001	
sum.taxonomy,ASWS_B0,ASWS_E0
```