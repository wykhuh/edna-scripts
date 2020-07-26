import_csv <- function(path, sep = ",", header = TRUE,
                       strings_factors = FALSE) {
  read.csv(path, sep = sep, header = header, stringsAsFactors = strings_factors)
}
