library("stringr")
library("tidyr")

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

# return ranks for a taxon string
get_ranks_for_taxon_string <- function(taxon_string) {
  phylum_ranks <- c("phylum", "class", "order", "family", "genus", "species")
  superkingdom_ranks <- c("superkingdom", phylum_ranks)

  count <- stringr::str_count(taxon_string, ";")
  if (count == 6) {
    ranks <- superkingdom_ranks
  } else if (count == 5) {
    ranks <- phylum_ranks
  } else {
    stop("Invalid taxonomy string.")
  }
  ranks
}

# create a copy of a file with taxon string broken up into separate columns
add_taxon_rank_columns <- function(df, output_file) {
  ranks <- get_ranks_for_taxon_string(df[1, 1][1])

  new_df <- df %>%
    tidyr::separate(sum.taxonomy, ranks, ";", remove = FALSE)

  new_df[new_df == "NA"] <- ""

  print(paste("creating", output_file))
  write.csv(new_df, output_file, row.names = FALSE)
}
