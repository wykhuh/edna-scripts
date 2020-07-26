# check if the directory passed as command line argument exists
get_directory <- function() {
  args <- commandArgs(trailingOnly = TRUE)

  if (length(args) == 1 && file_test("-d", args[1])) {
    return(args[1])
  } else {
    stop("Must pass in the name of a directory.")
  }
}
