library(styler)
library(lintr)

# will automatically fix issues in the code.
style_dir("./")

# will list any issues in the code in the RStudio's Marker panel. You will need
# to manually edit the files.
lint_dir("./")
