# scripts for eDNA analysis

## Scripts

### duplicate_sample_names.R

`duplicate_sample_names.R`  - Read all the files in a given directory and prints out
the duplicate sample names in each file. The files should have sample names in 
first row (e.g. Anacapa taxonomy results) or sample names in the first column
(e.g. field data or samples metadata).


#### Usage

1. Run the script. Pass in the name of the directory contains files for a research project. 


```
$  Rscript duplicate_sample_names.R <directory>
```
output
```
[1] "./project/16S.csv"
[1] "Duplicate sample names!!"
[1] "K0001_E4" "K0002_T9"
[1] "---------------"
[1] "./project/18S.csv"
[1] "OK"
[1] "---------------"
[1] "./project/metadata.csv"
[1] "OK"
[1] "---------------"
```

### rename_sample_headers.R

`rename_sample_headers.R` - Read all the Anacapa taxonomy result files in a given
directory, clean up the sample names in Anacapa files using the sample names from a
metadata file. 

- The script creates new files that has an extra header row with the new sample names. Users need to review the changes, and delete the row of old sample names.
- The sample names in the Anacapa results file amd metadata file do not have to be in the same order. 

Anacapa results sample names
```
sum.taxonomy,X16S_ASWS_B0.35.S35.L001,X16S_ASWS_E0.36.S36.L001	
```

metadata sample names
```
sum.taxonomy
ASWS_E0
ASWS_B0
```
updated Anacapa results sample names

```
sum.taxonomy,X16S_ASWS_B0.35.S35.L001,X16S_ASWS_E0.36.S36.L001	
sum.taxonomy,ASWS_B0,ASWS_E0
```

#### Usage

1. Edit the `setup` section of the script.

metadata_file: path for the metadata file
results_directory: path for the directory with the Anacapa results
output_directory: directory for the new files

2. Run the script

```
$  Rscript rename_sample_headers.R
```

A new directory will be created inside the original directory with the new files.


### add_taxa_rank_columns.R

`add_taxa_rank_columns.R` - Read all the Anacapa taxonomy result files in a given directory, break up the sum.taxonomy string into separate ranks, and create new files
with separate columns for each rank.

original file 
```
sum.taxonomy
s;p;c;;NA;g;s
```

new file
```
sum.taxonomy  superkingdom  phylum  class  order  family  genus  species
s;p;c;;NA;g;s s             p       c                     g      s
```

#### Usage

1. Edit the `setup` section of the script.

output_directory: directory for the new files


2. Run the script. Pass in the name of the directory that contains the Anacapa files.

```
$  Rscript add_taxa_rank_columns.R <directory>
```

A new directory will be created inside the original directory with the new files.


## Tests

To run tests.
```R
# RStudio console

> testthat::test_dir('tests')
```

To check code style.
```{bash}
# Terminal

$ Rscript ./lib/format_files.R
```