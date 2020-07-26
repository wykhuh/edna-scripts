source("./lib/process_samples.R")
source("./lib/process_csv.R")

# =============
# setup
# =============

metadata_file <- "./demo_data/rename_sample_headers/metadata.csv"
results_directory <- "./demo_data/rename_sample_headers/results"
output_directory <- "renamed_samples"
sep <- ","


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
