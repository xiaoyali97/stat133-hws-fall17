#==============================================
#Title: HW04, Stat 133, functions
#Description: 
#   This R Script contains all functions that used 
#   in Grade Visualizer project
#Author: Xiaoya Li
#Date: 11-09-2017
#==============================================

#' @title remove_missing
#' @description remove all missing values of the input vector
#' @param x vector
#' @return vector without missing values
#' @example 
#' remove_missing(c(1, 4, 7, NA, 10))
remove_missing <- function(x){
  return(x[!is.na(x)])
}


#' @title get_minimum
#' @description find the minimum value of the input vector
#' @param x numeric vector
#' @param na.rm whether to remove missing values
#' @return vector of minimum value
#' @example 
#' get_minimum(c(1, 4, 7, NA, 10), na.rm = TRUE)
get_minimum <- function(x, na.rm = FALSE){
  if(!is.numeric(x)){
    stop("non-numeric argument")
  }
  if(na.rm){
    x = remove_missing(x)
  }
  x = sort(x)
  return(x[1])
}


#' @title get_maxmimum
#' @description find the maximum value of the input vector
#' @param x numeric vector
#' @param na.rm whether to remove missing values
#' @return vector of maximum value
#' @example 
#' get_maximum(c(1, 4, 7, NA, 10), na.rm = TRUE)
get_maximum <- function(x, na.rm = FALSE){
  if(!is.numeric(x)){
    stop("non-numeric argument")
  }
  if(na.rm){
    x = remove_missing(x)
  }
  x = sort(x, decreasing = TRUE)
  return(x[1])
}


#' @title get_range
#' @description compute the overall range of the input vector
#' @param x numeric vector
#' @param na.rm whether to remove missing values
#' @return vector of range
#' @example  
#' get_range(c(1, 4, 7, NA, 10), na.rm = TRUE)
get_range <- function(x, na.rm = FALSE){
  if(!is.numeric(x)){
    stop("non-numeric argument")
  }
  if(na.rm){
    x = remove_missing(x)
  }
  return(get_maximum(x) - get_minimum(x))
}


#' @title get_percentile10
#' @description compute the 10th percentile of the input vector
#' @param x numeric vector
#' @param na.rm whether to remove missing values
#' @return vector of the 10th percentile value
#' @example 
#' get_percentile10(c(1, 4, 7, NA, 10), na.rm = TRUE)
get_percentile10 <- function(x, na.rm = FALSE){
  if(!is.numeric(x)){
    stop("non-numeric argument")
  }
  if(na.rm){
    x = remove_missing(x)
  }
  return(quantile(x, seq(0, 1, 0.1), names = FALSE)[2])
}


#' @title get_percentile90
#' @description compute the 90th percentile of the input vector
#' @param x numeric vector
#' @param na.rm whether to remove missing values
#' @return vector of the 10th percentile value
#' @example 
#' get_percentile90(c(1, 4, 7, NA, 10), na.rm = TRUE)
get_percentile90 <- function(x, na.rm = FALSE){
  if(!is.numeric(x)){
    stop("non-numeric argument")
  }
  if(na.rm){
    x = remove_missing(x)
  }
  return(quantile(x, seq(0, 1, 0.1), names = FALSE)[10])
}


#' @title get_median
#' @description compute the median of the input vector
#' @param x numeric vector
#' @param na.rm whether to remove missing values
#' @return median of the vector
#' @example 
#' get_median(c(1, 4, 7, NA, 10), na.rm = TRUE)
get_median <- function(x, na.rm = FALSE){
  if(!is.numeric(x)){
    stop("non-numeric argument")
  }
  if(na.rm){
    x = remove_missing(x)
  }
  x_sort = sort(x)
  if(length(x_sort) %% 2 == 0){
    return((x_sort[length(x_sort)/2] +  x_sort[length(x_sort)/2 + 1]) / 2)
  }else{
    return(x_sort[(length(x_sort) + 1) / 2])
  }
}


#' @title get_average
#' @description compute the average (i.e. mean) of the input vector
#' @param x numeric vector
#' @param na.rm whether to remove missing values
#' @return average of the vector
#' @example 
#' get_average(c(1, 4, 7, NA, 10), na.rm = TRUE)
get_average <- function(x, na.rm = FALSE){
  if(!is.numeric(x)){
    stop("non-numeric argument")
  }
  if(na.rm){
    x = remove_missing(x)
  }
  total = 0
  for(i in 1:length(x)){
    total = total + x[i]
  }
  return(total / length(x))
}


#' @title get_stdev
#' @description compute the standard deviation of the input vector
#' @param x numeric vector
#' @param na.rm whether to remove missing values
#' @return standard deviation of the vector
#' @example 
#' get_stdev(c(1, 4, 7, NA, 10), na.rm = TRUE)
get_stdev <- function(x, na.rm = FALSE){
  if(!is.numeric(x)){
    stop("non-numeric argument")
  }
  if(na.rm){
    x = remove_missing(x)
  }
  mean = get_average(x)
  total_dev = 0
  for(i in 1:length(x)){
    total_dev = total_dev + (x[i] - mean) ^ 2 
  }
  return(round(sqrt(total_dev / (length(x) - 1)), 6))
}


#' @title get_quartile1
#' @description compute the first quartile of the input vector
#' @param x numeric vector
#' @param na.rm whether to remove missing values
#' @return the first quartile value
#' @example 
#' get_quartile1(c(1, 4, 7, NA, 10), na.rm = TRUE)
get_quartile1 <- function(x, na.rm = FALSE){
  if(!is.numeric(x)){
    stop("non-numeric argument")
  }
  if(na.rm){
    x = remove_missing(x)
  }
  return(quantile(x, seq(0, 1, 0.25), names = FALSE)[2])
}


#' @title get_quartile3
#' @description compute the third quartile of the input vector
#' @param x numeric vector
#' @param na.rm whether to remove missing values
#' @return the third quartile value
#' @example 
#' get_quartile3(c(1, 4, 7, NA, 10), na.rm = TRUE)
get_quartile3 <- function(x, na.rm = FALSE){
  if(!is.numeric(x)){
    stop("non-numeric argument")
  }
  if(na.rm){
    x = remove_missing(x)
  }
  return(quantile(x, seq(0, 1, 0.25), names = FALSE)[4])
}



#' @title count_missing
#' @description calculates the number of missing values NA
#' @param x numeric vector
#' @return number of missing values
#' @example 
#' count_missing(c(1, 4, 7, NA, 10))
count_missing <- function(x){
  return(sum(is.na(x)))
}


#' @title summary_stats
#' @description give a list of summary statistics of a vector, including
#'              minimum, 10th percentile, first quartile, median, mean, 
#'              third quartile, 90th percentile, maximum, range, 
#'              standard deviation and number of missing values
#' @param x numeric vector
#' @return a list of summary statistics
#' @example 
#' summary_stats(c(1, 4, 7, NA, 10))
summary_stats <- function(x){
  if(!is.numeric(x)){
    stop("non-numeric argument")
  }
  stats <- list(
    minimum = get_minimum(x, na.rm = TRUE),
    percent10 = get_percentile10(x, na.rm = TRUE),
    quartile1 = get_quartile1(x, na.rm = TRUE),
    median = get_median(x, na.rm = TRUE),
    mean = get_average(x, na.rm = TRUE),
    quartile3 = get_quartile3(x, na.rm = TRUE),
    percent90 = get_percentile90(x, na.rm = TRUE),
    maximum = get_maximum(x, na.rm = TRUE),
    range = get_range(x, na.rm = TRUE),
    stdev = get_stdev(x, na.rm = TRUE),
    missing = count_missing(x)
  )
  return(stats)
}


#' @title print_stats
#' @description prints the values of the input list in a nice format
#' @param x list
#' @example 
#' print_stats(summary_stats(c(1, 4, 7, NA, 10)))
print_stats <- function(x){
  if(!is.list(x)){
    stop("argument is not a list")
  }
  longest = get_maximum(nchar(names(x)))
  label <- format(names(x), width = longest)
  for(i in 1:length(x)){
    cat(label[i], ": ", sprintf("%.4f\n", x[[i]]), sep = "")
  }
}


#' @title rescale100
#' @description rescale a vector with a potential scale from 0 to 100
#' @param x numeric vector
#' @param xmin minimum value of x
#' @param xmax maximum value of x
#' @return vector in rescaled units
#' @example 
#' rescale100(c(18, 15, 16, 4, 17, 9), xmin = 0, xmax = 20)
rescale100 <- function(x, xmin, xmax){
  if(!is.numeric(x)){
    stop("non-numeric argument")
  }
  return(100 * ((x - xmin) / (xmax - xmin)))
}


#' @title drop_lowest
#' @description dropping the lowest value of the input vector
#' @param x numeric vector of length n
#' @return a numeric vector of length n-1
#' @example 
#' drop_lowest(c(10, 10, 8.5, 4, 7, 9))
drop_lowest <- function(x){
  xmin = get_minimum(x, na.rm = TRUE)
  for(i in 1:length(x)){
    if(x[i] == xmin){
      return(x[-i])
    }
  }
}


#' @title score_homework
#' @description compute a single homework value
#' @param x numeric vector of homework scores (of length n)
#' @param drop logical argument whether to drop the lowest one
#' @return average of the homework scores
#' @example 
#' score_homework(c(100, 80, 30, 70, 75, 85), drop = TRUE)
#' score_homework(c(100, 80, 30, 70, 75, 85), drop = FALSE)
score_homework <- function(x, drop = FALSE){
  if(!is.numeric(x)){
    stop("non-numeric argument")
  }
  if(drop){
    x = drop_lowest(x)
  }
  return(round(get_average(x, na.rm = TRUE), 4))
}


#' @title score_quiz
#' @description compute a single quiz value
#' @param x numeric vector of quiz scores (of length n)
#' @param drop logical argument whether to drop the lowest one
#' @return average of the quiz scores
#' @example 
#' score_homework(c(100, 80, 70, 0), drop = TRUE)
#' score_homework(c(100, 80, 70, 0), drop = FALSE)
score_quiz <- function(x, drop = FALSE){
  if(!is.numeric(x)){
    stop("non-numeric argument")
  }
  if(drop){
    x = drop_lowest(x)
  }
  return(round(get_average(x, na.rm = TRUE), 4))
}


#' @title score_lab
#' @description give a lab score based on the lab attendance
#' @param x numeric value of lab attendance
#' @return the corresponding lab scores
#' @example 
#' score_lab(12)
score_lab <- function(x){
  if(!is.numeric(x)){
    stop("non-numeric argument")
  }
  if(x < 0 | x > 12){
    stop("argument out of range")
  }
  if(x == 12 | x == 11){  score = 100 }
  else if(x == 10){  score = 80 }
  else if(x == 9){  score = 60 }
  else if(x == 8){ score = 40 }
  else if(x == 7){   score = 20 }
  else{  score = 0}
  return(score)
}

