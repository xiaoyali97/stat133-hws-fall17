#==============================================
#Title: HW04, Stat 133, functions
#Description: 
#   This R Script runs all unit tests on functions 
#Source: - functions.R
#Output: - test-reporter.txt
#Author: Xiaoya Li
#Date: 11-13-2017
#==============================================

library(testthat)

# source in functions to be tested
source('functions.R')

sink('../output/test-reporter.txt')
test_file('tests.R')
sink()
