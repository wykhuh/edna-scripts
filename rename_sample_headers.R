source("./lib/csv_cleanup.R")

# =============
# setup
# =============

metadata_file <- "./demo_data/metadata.csv"
results_directory <- "./demo_data/results"
output_directory <- "renamed_samples"
sep <- ","

# =============
# functions
# =============

import_csv <- function(path, sep = ",", header = TRUE,
                       strings_factors = FALSE) {
  read.csv(path, sep = sep, header = header, stringsAsFactors = strings_factors)
}


# =============
# run script
# =============

directory <- results_directory
nested_output_directory <- file.path(directory, output_directory)
dir.create(nested_output_directory)

metadata <- import_csv(metadata_file, sep = sep)
valid_barcodes <- metadata$sum.taxonomy

files <- list.files(path = directory, full.names = TRUE)
for (file in files) {
  if (file_test("-f", file)) {
    file_name <- strsplit(file, directory)[[1]][2]
    output_file <- paste(nested_output_directory, file_name, sep = "")

    results_content <- import_csv(file, sep = sep)
    raw_barcodes <- colnames(results_content)

    new_barcodes <- reformat_sample_barcodes(
      raw_barcodes = raw_barcodes,
      valid_barcodes = valid_barcodes
    )

    # add new row to the results file that contain the new barcodes
    updated_csv <- rbind(new_barcodes, results_content)

    # create file with updated data
    print(paste("creating", output_file))
    write.table(updated_csv,
      file = output_file, row.names = FALSE,
      col.names = TRUE, sep = sep
    )
  }
}
