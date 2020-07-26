library(testthat)

source("../lib/process_csv.R")

describe("get_delimiter", {
  it("returns , for comma delimited files", {
    file <- "./fixtures/comma.csv"

    expect_equal(get_delimiter(file), ",")
  })

  it("returns \t for tab delimited files", {
    file <- "./fixtures/tab.csv"

    expect_equal(get_delimiter(file), "\t")
  })

  it("returns ; for tab delimited files", {
    file <- "./fixtures/semicolon.csv"

    expect_equal(get_delimiter(file), ";")
  })
})
