# This script will read all the Anacapa taxonomy resuts in given directory,
# break up the sum.taxonomy string into separate ranks, create columns for each
# each of the ranks, and output new files with the rank columns.

source("./lib/process_samples.R")
source("./lib/utils.R")
source("./lib/process_csv.R")

# =============
# setup
# =============

output_directory <- "with_rank_columns"
sep <- ","


# =============
# run script
# =============

directory <- get_directory()
full_directory <- file.path(directory, output_directory)
dir.create(full_directory)

files <- list.files(path = directory, full.names = TRUE)
for (file in files) {
  if (file_test("-f", file)) {
    file_name <- strsplit(file, directory)[[1]][2]
    output_file <- paste(full_directory, file_name, sep = "")
    df <- import_csv(file, sep = sep)
    add_taxon_rank_columns(df, output_file)
  }
}
