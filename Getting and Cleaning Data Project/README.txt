run_analysis Description:
First we load in the required packages. If package is not in library, please install first using install.packages.
Next, we start reading in each of the individual files as seen in the zipped folder. Then add column names to each variable.
We want a product that has more of the datasets merged, so we add the activities and participant columns.
Then we actually perform the merge.
Because we only want a subset of the data, use gprep to search for specific variables. Then change some variable names to be more descript.
Once we do that, we want to create a tidy dataset so we take the mean of each column to make it have meaning, and save the result.
