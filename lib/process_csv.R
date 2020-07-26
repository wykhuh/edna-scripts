library("stringr")

import_csv <- function(path, sep = ",", header = TRUE,
                       strings_factors = FALSE) {
  read.csv(path, sep = sep, header = header, stringsAsFactors = strings_factors)
}

# returns the delimiter for a  delimited file
get_delimiter <- function(file) {
  first_line <- readLines(file, n = 1)
  comma_count <- stringr::str_count(first_line, ",")
  tab_count <- stringr::str_count(first_line, "\t")
  semicolon_count <- stringr::str_count(first_line, ";")

  df <- data.frame(
    commas = comma_count, tabs = tab_count,
    semicolons = semicolon_count
  )
  most_common_delim <- colnames(sort(df, decreasing = TRUE)[1])

  if (most_common_delim == "commas") {
    ","
  } else if (most_common_delim == "tabs") {
    "\t"
  } else {
    ";"
  }
}
