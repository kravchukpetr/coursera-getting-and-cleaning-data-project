# Code Book

This code book summarizes information about the variables, data and transformations used in the course project.

## R script explanation

The R script `run_analysis.R` perform following clean up procedures:

1. Load the activity and features info in `ActivityLabels` and `features` variables
2. Extract only the measurements on the mean and standard deviation columns from `features` and store indexes of this columns at    `MeasurementsIndex`
3. Get the list `MeasurementsNames` of column names what reflect mean and standard deviation. 
   Clean up the values from meaningless symbols
4. Loads training and test datasets at `train` and `test` variables, keeping only those columns which
   reflect a mean or standard deviation (i.e. which indexes in `MeasurementsIndex`)
5. Loads the activity and subject data for test and training datasets. So we get variables: `TrainActivities`, `TrainSubjects`,    `TestActivities`, `TestSubjects`
6. Merges Activities and Subject data with test and train datasets respectively using cbind() function. 
   As the result:`TrainAll` - for train data, `TestAll` - for test data
7. Merges the test and training sets together into `DataTotal` using rbind()
8. Rename column for `DataTotal` using `MeasurementsNames`
9. Convert the `activity` and `subject` columns into factors
10. Create a tidy dataset `DataMean` that contains the average (mean) value of each
   variable for each subject and activity pair. Doesthis using aggregate() function
11. `DataMean` tidy dataset write to a tab-delimited file called `tidy.txt`, which represent in this repo.


