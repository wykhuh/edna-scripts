# for a given barcode, find the matching valid barcode
fuzzy_find_matching_barcode <- function(valid_barcodes, target_barcode) {
  for (valid_barcode in valid_barcodes) {
    if (grepl(valid_barcode, target_barcode)) {
      return(valid_barcode)
    }
  }
  target_barcode
}

# remove columns in dataframe that contain the word 'blank'
remove_blank_samples <- function(df) {
  indx <- !grepl("blank", colnames(df))
  df[indx]
}

# returns a vector with cleaned up sample names
reformat_sample_barcodes <- function(raw_barcodes, valid_barcodes) {
  new_barcodes <- c()

  i <- 1
  for (barcode in raw_barcodes) {
    if (barcode == "sum.taxonomy") {
      new_barcodes[i] <- barcode
      i <- i + 1
      next
    }
    new_barcodes[i] <- fuzzy_find_matching_barcode(valid_barcodes, barcode)
    i <- i + 1
  }
  new_barcodes
}
