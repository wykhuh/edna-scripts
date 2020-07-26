library(testthat)

source("../lib/process_samples.R")

describe("fuzzy_find_matching_barcode", {
  context("original barcode does match a valid barcode")

  it("returns a valid barcode that matches the  original barcode", {
    valid_barcodes <- c("good", "great")
    original_barcode <- "xxx_good.xxx"
    results <- fuzzy_find_matching_barcode(valid_barcodes, original_barcode)

    expect_equal(results, "good")
  })

  context("original barcode does not match any valid barcode")

  it("returns original barcode", {
    valid_barcodes <- c("good", "great")
    original_barcode <- "xxx_bad.xxx"
    results <- fuzzy_find_matching_barcode(valid_barcodes, original_barcode)

    expect_equal(results, "xxx_bad.xxx")
  })

  context("partial matches")

  it("returns valid barcode if original barcode has extra characters", {
    valid_barcodes <- c("good", "great")
    original_barcode <- "xxx_xxgreatxx.xxx"
    results <- fuzzy_find_matching_barcode(valid_barcodes, original_barcode)

    expect_equal(results, "great")
  })

  it("returns original barcode if original doesn't have all the characters", {
    valid_barcodes <- c("good", "great")
    original_barcode <- "xxx_gre.xxx"
    results <- fuzzy_find_matching_barcode(valid_barcodes, original_barcode)

    expect_equal(results, "xxx_gre.xxx")
  })
})

describe("reformat_sample_barcodes", {
  valid_barcodes <- c("sum.taxonomy", "K0001", "water", "K0002")

  it("converts a vector of raw sample barcodes to valid barcodes", {
    raw_barcodes <- c(
      "sum.taxonomy", "X18S_K0001.S", "X18S_water.S",
      "X18S_K0002.S"
    )
    results <- reformat_sample_barcodes(raw_barcodes, valid_barcodes)

    expect_equal(results, c("sum.taxonomy", "K0001", "water", "K0002"))
  })

  it("handles a mixture of valid and invalid raw barcodes", {
    raw_barcodes <- c(
      "sum.taxonomy", "X18S_K0001.S", "X18S_water.S",
      "X18S_K0.S"
    )
    results <- reformat_sample_barcodes(raw_barcodes, valid_barcodes)

    expect_equal(results, c("sum.taxonomy", "K0001", "water", "X18S_K0.S"))
  })

  context("when raw and valid barcodes have different order")
  it("returns results based on the order of the raw barcodes", {
    raw_barcodes <- c(
      "sum.taxonomy", "X18S_water.S", "X18S_K0002.S",
      "X18S_K0001.S"
    )
    results <- reformat_sample_barcodes(raw_barcodes, valid_barcodes)

    expect_equal(results, c("sum.taxonomy", "water", "K0002", "K0001"))
  })
})

describe("remove_blank_samples", {
  it("removes column from dataframe that contain the word 'blank", {
    df <- data.frame(
      "sum.taxonomy" = c("dog", "cat"),
      "XX_sample_1.XX" = c(1, 10),
      "XX_blank_1.XX" = c(2, 20),
      "XX_sample_2.XX" = c(3, 30)
    )
    results <- remove_blank_samples(df)
    expected_columns <- c("sum.taxonomy", "XX_sample_1.XX", "XX_sample_2.XX")

    expect_equal(colnames(results), expected_columns)
  })
})

