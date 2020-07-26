# Read all the files in a given directory and prints out the duplicate
# sample names in each file.

source("./lib/process_csv.R")
source("./lib/process_samples.R")
source("./lib/utils.R")

directory <- get_directory()
filenames <- list.files(directory,
  pattern = "*.*", full.names = TRUE,
  recursive = TRUE
)

for (file in filenames) {
  print(file)
  delim <- get_delimiter(file)
  df <- read.csv(file, header = F, sep = delim, stringsAsFactors = FALSE)

  second_row <- df[2, ]
  if (is_edna_results(second_row)) {
    sample_names_row <- unname(unlist(df[1, ]))
    display_duplicate_values(sample_names_row)
  } else {
    sample_names_row <- t(df)[1, ]
    display_duplicate_values(sample_names_row)
  }
  print("---------------")
}
