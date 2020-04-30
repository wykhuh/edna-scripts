source("./lib/csv_cleanup.R")

metadata_file <- "./demo_data/metadata.csv"
taxonomy_file <- "./demo_data/taxonomy.txt"
sep <- ","

import_csv <- function(path, sep = ",", header = TRUE,
                       strings_factors = FALSE) {
  read.csv(path, sep = sep, header = header, stringsAsFactors = strings_factors)
}


metadata <- import_csv(metadata_file)
valid_barcodes <- metadata$sum.taxonomy

taxonomy <- import_csv(taxonomy_file)
raw_barcodes <- colnames(taxonomy)

new_barcodes <- reformat_sample_barcodes(
  raw_barcodes = raw_barcodes,
  valid_barcodes = valid_barcodes
)

# add new row to the taxonomy file that contain the new barcodes
updated_csv <- rbind(new_barcodes, taxonomy)

# create csv with updated data
new_filename <- rename_file(taxonomy_file)
write.table(updated_csv,
  file = new_filename, row.names = FALSE, col.names = TRUE, sep = sep
)
