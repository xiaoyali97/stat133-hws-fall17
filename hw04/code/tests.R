#==============================================
#Title: HW04, Stat 133, functions
#Description: 
#   This R Script contains unit tests for all functions
#Author: Xiaoya Li
#Date: 11-09-2017
#==============================================

library(testthat)


context("remove_missing function")

test_that("remove_missing works",{
  expect_equal(remove_missing(c(1, 2, 3, NA)), c(1, 2, 3))
  expect_equal(remove_missing(c("1", "2", NA)), c("1", "2"))
  expect_equal(remove_missing(NA), logical(0))
  expect_equal(remove_missing(c(1,2,3)), c(1,2,3))
})


context("get_minimum function")

test_that("get_minimum works",{
  expect_equal(get_minimum(c(10, 2, 2)), 2)
  expect_equal(get_minimum(c(10, NA, 2)), 2)
  expect_equal(get_minimum(c(10, NA, 2), na.rm = TRUE), 2)
  expect_equal(get_minimum(as.numeric(c(NA,NA,NA))), as.numeric(NA))
})

test_that("get_minimum throws error", {
  expect_error(get_minimum(c("1", "2")))
})


context("get_maximum function")

test_that("get_maximum works",{
  expect_equal(get_maximum(c(10, 2, 2)), 10)
  expect_equal(get_maximum(c(10, NA, 2)), 10)
  expect_equal(get_maximum(c(10, NA, 2), na.rm = TRUE), 10)
})

test_that("get_maximum throws error", {
  expect_error(get_maximum(c("1", "2")))
})



context("get_range function")

test_that("get_range works", {
  expect_equal(get_range(c(10, 2)), 8)
  expect_equal(get_range(c(10, NA, 2)), 8)
  expect_equal(get_range(c(10, NA, 2), na.rm = TRUE), 8)
})

test_that("get_range throws error", {
  expect_error(get_range(c("1", "2")))
})


context("get_percentile10 function")

test_that("get_percentile10 works", {
  expect_equal(get_percentile10(c(1, 4, 7, NA, 10), na.rm = TRUE), 1.9)
  expect_equal(get_percentile10(c(10,10,10)), 10)
})

test_that("get_percentile10 throws error", {
  expect_error(get_percentile10(c("1", "2")))
  expect_error(get_percentile10(c(1, 4, 7, NA, 10)))
})


context("get_percentile90 function")

test_that("get_percentile90 works", {
  expect_equal(get_percentile90(c(1, 4, 7, NA, 10), na.rm = TRUE), 9.1)
  expect_equal(get_percentile90(c(10,10,10)), 10)
})

test_that("get_percentile90 throws error", {
  expect_error(get_percentile90(c("1", "2")))
  expect_error(get_percentile90(c(1, 4, 7, NA, 10)))
})


context("get_median function")

test_that("get_median works",{
  expect_equal(get_median(c(1, 4, 7, NA, 10)), 5.5)
  expect_equal(get_median(c(1, 4, 7, NA, 10), na.rm = TRUE), 5.5)
  expect_equal(get_median(c(10,10,10)), 10)
})

test_that("get_median throws error", {
  expect_error(get_median(c("1", "2")))
})


context("get_average function")

test_that("get_average works", {
  expect_equal(get_average(c(1, 4, 7, NA, 10)), as.numeric(NA))
  expect_equal(get_average(c(1, 4, 7, NA, 10), na.rm = TRUE), 5.5)
  expect_equal(get_average(c(10,10,10)), 10)
})

test_that("get_average throws error", {
  expect_error(get_average(c("1", "2")))
})


context("get_stdev function")

test_that("get_stdev works",{
  expect_equal(get_stdev(c(1, 4, 7, NA, 10)), as.numeric(NA))
  expect_equal(get_stdev(c(1, 4, 7, NA, 10), na.rm = TRUE), 3.872983)
  expect_equal(get_stdev(c(10,10,10)), 0)
})

test_that("get_stdev throws error",{
  expect_error(get_stdev(c("1", "2")))
})


context("get_quartile1 function")

test_that("get_quartile1 works", {
  
  expect_equal(get_quartile1(c(1, 4, 7, NA, 10), na.rm = TRUE), 3.25)
  expect_equal(get_quartile1(c(10,10,10)), 10)
})

test_that("get_quartile1 throws error", {
  expect_error(get_quartile1(c(1, 4, 7, NA, 10)))
  expect_error(get_quartile1(c("1", "2")))
})


context("get_quartile3 function")

test_that("get_quartile3 works", {
  expect_equal(get_quartile3(c(1, 4, 7, NA, 10), na.rm = TRUE), 7.75)
  expect_equal(get_quartile3(c(10,10,10)), 10)
})

test_that("get_quartile3 throws error", {
  expect_error(get_quartile3(c(1, 4, 7, NA, 10)))
  expect_error(get_quartile3(c("1", "2")))
})


context("count_missing function")

test_that("count_missing works", {
  a <- c(1, 4, 7, NA, 10)
  b <- c("1", "2", NA, NA)
  expect_equal(count_missing(a), 1)
  expect_equal(count_missing(b), 2)
  expect_equal(count_missing(c(a,b)), 3)
  expect_equal(count_missing(c(1, 4, 7)), 0)
})


context("summary_stats function")

test_that("summary_stats returns a list",{
  expect_true(is.list(summary_stats(c(1, 4, 7, 10))))
  expect_true(is.list(summary_stats(c(1, 4, 7, NA, 10))))
})

test_that("summary_stats returns a list of 11 elements", {
  expect_equal(length(summary_stats(c(1, 4, 7, NA, 10))), 11)
})

test_that("summary_stats throws error", {
  expect_error(summary_stats(c('1', '2', '3')))
})


context("print_stats function")

test_that("print_stats prints value in 4 decimal places", {
  a_list <- list(
    one = 1,
    two = 2,
    three = 3
  )
  expect_output(print_stats(a_list),"\\.....\n")
})

test_that("the position of colons ':' fits the maximum length name", {
  a_list <- list(
    one = 1,
    two = 2,
    three = 3
  )
  expect_output(print_stats(a_list), "three: ")
})

test_that("print_stats throws error", {
  expect_error(print_stats(c(1,2)))
  expect_error(print_stats(NA))
})


context("rescale100 function")

test_that("rescale100 wouldn't exceed range 0 to 100",{
  expect_true(max(rescale100(c(-5,10,15), xmin = -10, xmax = 20)) <= 100)
  expect_true(min(rescale100(c(-5,10,15), xmin = -10, xmax = 20)) >= 0)
})

test_that("rescale100 works",{
  expect_equal(rescale100(c(18, 4, 17, 9), xmin = 0, xmax = 20), c(90, 20, 85, 45))
})

test_that("rescale100 throws error", {
  expect_error(rescale100(c("1", "2")))
})


context("drop_lowest function")

test_that("drop_lowest works",{
  expect_equal(drop_lowest(c(1,4,7,10)), c(4,7,10))
  expect_equal(drop_lowest(c(3,3,3)), c(3,3))
  expect_equal(drop_lowest(c(3,2,NA)), c(3,NA))
})

test_that("drop_lowest throws error",{
  expect_error(drop_lowest(c("1", "2")))
})


context("score_homework funtion")

test_that("score_homework works",{
  hws <- c(100, 80, 30, 70, 75, 85)
  expect_equal(score_homework(hws, drop = TRUE), 82)
  expect_equal(score_homework(hws, drop = FALSE), 73.3333)
  expect_equal(score_homework(c(hws, NA), drop = TRUE), 82)
})

test_that("score_homework throws error",{
  expect_error(score_homework(c("1", "2")))
})


context("score_quiz funtion")

test_that("score_quiz works",{
  quizzes <- c(100, 80, 70, 0)
  expect_equal(score_quiz(quizzes, drop = TRUE), 83.3333)
  expect_equal(score_quiz(quizzes, drop = FALSE), 62.5)
  expect_equal(score_quiz(c(quizzes, NA), drop = TRUE), 83.3333)
})

test_that("score_quiz throws error",{
  expect_error(score_quiz(c("1", "2")))
})


context("score_lab funtion")

test_that("score_lab works", {
  expect_equal(score_lab(12), 100)
  expect_equal(score_lab(3), 0)
})

test_that("score_lab throws error",{
  expect_error(score_lab(-2))
  expect_error(score_lab("4"))
})


