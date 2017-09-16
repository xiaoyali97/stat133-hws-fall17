warmup02
================
Xiaoya Li
September 15, 2017

``` r
load("~/UC_Berkeley/Stat133/HW2/nba2017-salary-points.RData")
ls()
```

    ## [1] "experience" "player"     "points"     "points1"    "points2"   
    ## [6] "points3"    "position"   "salary"     "team"

Exploratory Data Analysis
-------------------------

<br>

### Quantitative Variable

-   Use the summary() function to get a quick summary of descriptive statitstics for each numeric vector

``` r
summary(points)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##     0.0   156.0   432.0   546.6   780.0  2558.0

``` r
summary(points1)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##    0.00   21.00   58.00   92.47  120.00  746.00

``` r
summary(points2)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##     0.0    39.0   111.0   152.5   213.0   730.0

``` r
summary(points3)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##    0.00    3.00   32.00   49.71   78.00  324.00

``` r
summary(salary)
```

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ##     5145  1286160  3500000  6187014  9250000 30963450

-   Now, look up for functions that allow you to get the following statistics:

    -   mean (i.e. average)
    -   standard deviation
    -   minimum value
    -   maximum value
    -   median
    -   quartiles

``` r
mean(points)
```

    ## [1] 546.6054

``` r
sd(points)
```

    ## [1] 489.0156

``` r
min(points)
```

    ## [1] 0

``` r
max(points)
```

    ## [1] 2558

``` r
median(points)
```

    ## [1] 432

``` r
quantile(points)
```

    ##   0%  25%  50%  75% 100% 
    ##    0  156  432  780 2558

-   What are the typical values in each vector?
    In general, players get a average `points` of 547, with a standard deviation of 489. The minimum points is 0 while the maximum is 2558. The median of all the points is 432.

-   What's the spread in each vector?
    The interquantiles of `points` is 0, 156, 432, 780, 2558.

-   Look at the distribution: use hist() and boxplot()

``` r
hist(points)
```

![](up02-Xiaoya-Li_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-8-1.png)

``` r
boxplot(points, horizontal = TRUE)
```

![](up02-Xiaoya-Li_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-8-2.png)

-   You can also try to get a density curve (or density polygon). Find out how to do this.

``` r
plot(density(points), ylab = "frequency(%)", xlab = "points" )
```

![](up02-Xiaoya-Li_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-9-1.png)

Qualitative Variable
--------------------

-   Pick one of the categorical variables: `team` or `position`
-   If the variable that you choose is not an R factor, then use factor() to convert the object into a factor.
-   Use table() to get a frequency table (i.e. counts of each category).

``` r
team_fre <- table(team)
team_fre
```

    ## team
    ## ATL BOS BRK CHI CHO CLE DAL DEN DET GSW HOU IND LAC LAL MEM MIA MIL MIN 
    ##  14  15  15  15  15  15  15  15  15  15  14  14  15  15  15  14  14  14 
    ## NOP NYK OKC ORL PHI PHO POR SAC SAS TOR UTA WAS 
    ##  14  15  15  15  15  15  14  15  15  15  15  14

-   Find out how to use the obtained frequency table to calculate relative frequencies (proportions).

``` r
team_refre <- team_fre / length(team)
team_refre
```

    ## team
    ##        ATL        BOS        BRK        CHI        CHO        CLE 
    ## 0.03174603 0.03401361 0.03401361 0.03401361 0.03401361 0.03401361 
    ##        DAL        DEN        DET        GSW        HOU        IND 
    ## 0.03401361 0.03401361 0.03401361 0.03401361 0.03174603 0.03174603 
    ##        LAC        LAL        MEM        MIA        MIL        MIN 
    ## 0.03401361 0.03401361 0.03401361 0.03174603 0.03174603 0.03174603 
    ##        NOP        NYK        OKC        ORL        PHI        PHO 
    ## 0.03174603 0.03401361 0.03401361 0.03401361 0.03401361 0.03401361 
    ##        POR        SAC        SAS        TOR        UTA        WAS 
    ## 0.03174603 0.03401361 0.03401361 0.03401361 0.03401361 0.03174603

-   Use the frequencies (counts) and relative frequencies (proportions) to describe the overall distribution. All the team has either 14 players or 15 players.

-   Use barplot() to display the frequencies with a barchart.

``` r
barplot(team_fre, ylim=c(0,20))
```

![](up02-Xiaoya-Li_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-12-1.png)

Report your process
-------------------

-   What things were hard, even though you saw them in class?
    Understand what factor really is.

-   What was easy(-ish) even though we haven't done it in class?
    Using the `??` and `?` to search documentation for functions.

-   What type of "errors" you struggled with (if any)?
    To generate a more descriptive graph, including some labels and data on the graph.

-   What are the parts you are not fully understanding?
    What is factor and what's the different between vector.

-   What was the most time consuming part?
    Trying to figure out some specific instruction.

-   Did you collaborate with other students? If so, with who? In what manner?
    No. I worked alone.

-   Was there any frustrating issue? (e.g. RStudio cryptic error, one or more package not playing nice) Markdown syntax sometimes doesn't work well.
