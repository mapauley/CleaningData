Project README
================
Mark Pauley
4/22/2021

The dataset includes the following files:

-   `README.md`: This file

-   `runAnalysis.R`: Contains the commented script that does the
    analysis. The script must be run in a directory containing
    `features.txt`, `subject_train.txt`, `subject_test.txt`,
    `X_train.txt`, `X_test.txt`, `Y_train.txt`, and `Y_test.txt` from
    the project file. The script creates the file `dataSummary.csv`
    described below.

-   `CodeBook.md`: A file that describes the variables, data, and
    transformations performed to clean the data, although most of this
    is done below and with comments in `runAnalysis.R`.

-   `dataSummary.csv`: Summary of the data, with a header row. A 181 ×
    68 file containing the averages of each variable for each activity
    and each subject.

Briefly, `runAnalysis.R` does the following:

-   Loads the features, subjects, X, and Y files. A column (`Role`) is
    added in the subjects data frame indicating whether a given subject
    was used for training or testing. For the X data, the entries in
    `features.txt` are used as descriptive column names, and only the
    columns with “mean()” and “std()” are selected. For the Y files,
    activity numbers are converted to activity names.

-   Merges the data frames for training and testing subjects into
    individual frames.

-   Merges the two data frames resulting from the previous step into a
    single frame.

-   Computes summary statistics for the combined data set, grouped by
    subject, activity, and role (whether the subject was used for
    training or testing).

-   Writes the result from the previous step to a comma-delimited file,
    `dataSummary.csv`.
