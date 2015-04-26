---
title: "Course Project -Getting and Cleaning Data"
output: html_document
---
This document explains the R code (`run_analyis.R`) written for the "Getting and Cleaning Data" course project. The coding is done following the `5-step` instruction given in the project description.

### Step 1
* The training and the test data are extracted and loaded to `train_data` and `test_data` data frames.
* The train and test data frames are merged using `rbind()` function.

### Step 2
* Feature names are loaded and extracted to the dataframe `feature_names`.
* The `[mM]ean` and `[sS]td` of variables are stored in `selected_names` vector.
* Data frame with the selected mean and std variables are stored in `data_ans` data frame.

### Step 3
* The activity variable is mapped to the labels using the `mutate` function.

### Step 4
* Assignment of variable names is completed in `Step 2`.

### Step 5
* `ddply()` function is employed together with `colMeans()` to obtain the average of the variables for each activity and each volunteer.
* the tidy data `data_average` is written to `data_average.txt`.