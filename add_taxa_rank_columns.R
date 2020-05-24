# This script will read all the Anacapa taxonomy resuts in given directory,
# break up the sum.taxonomy string into separate ranks, create columns for each
# each of the ranks, and output new files with the rank columns.

library(dplyr, warn.conflicts = FALSE)
library(tidyr)

# =============
# setup
# =============

ranks <- c(
  "superkingdom", "phylum", "class", "order", "family", "genus",
  "species"
)
output_directory <- "with_rank_columns"
sep <- ","

# =============
# functions
# =============

add_taxon_rank_columns <- function(file, output_file) {
  df <- read.csv(file, sep = sep)

  new_df <- df %>%
    separate(sum.taxonomy, ranks, ";", remove = FALSE)

  new_df[new_df == "NA"] <- ""

  print(paste("creating", output_file))
  write.csv(new_df, output_file, row.names = FALSE)
}

get_directory <- function() {
  args <- commandArgs(trailingOnly = TRUE)

  if (length(args) == 1 && file_test("-d", args[1])) {
    return(args[1])
  } else {
    stop("Must pass in the name of a directory.")
  }
}


# =============
# run script
# =============

directory <- get_directory()
nested_output_directory <- file.path(directory, output_directory)
dir.create(nested_output_directory)

files <- list.files(path = directory, full.names = TRUE)
for (file in files) {
  if (file_test("-f", file)) {
    file_name <- strsplit(file, directory)[[1]][2]
    output_file <- paste(nested_output_directory, file_name, sep = "")

    add_taxon_rank_columns(file, output_file)
  }
}
