Codebook
================
Mark Pauley
4/22/2021

### Load packages

``` r
library(data.table)
```

Per the assignment desciption, this file is to describe “the variables,
the data,and any transformations or work that you performed to clean up
the data called.” Most of this is done in the commented script,
`run_analysis.R`. However, the correct merging of the two data sets
relies on a given subject not being used for both training and testing.
This is confirmed below.

``` r
# Read the files containing the training and test subjects
trainSubjects <-
  fread("./subject_train.txt",
        header = FALSE,
        col.names = c("Subject"))
testSubjects <-
    fread("./subject_test.txt",
          header = FALSE,
          col.names = c("Subject"))

# Were any test subjects also training subjects?
testInTrain <- unique(testSubjects) %in% unique(trainSubjects)
testInTrain
```

    ## [1] FALSE

``` r
# Were any training subjects also test subjects?
trainInTest <- unique(trainSubjects) %in% unique(testSubjects)
trainInTest
```

    ## [1] FALSE

Because `unique(testSubjects) %in% unique(trainSubjects)` is FALSE and
`unique(trainSubjects) %in% unique(testSubjects)` is FALSE, no test
subject was also a training subject and vice versa.
