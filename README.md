Code reads in raw test files for both training and test directories.

Next, code combines together both tarinin g and test y_ datasets that contain list of activity Id's and also the subject Id.

Next the activity labels such as walking etc are read in to R.

Both X_ datasets are combined together and labels are added to be more descriptive.

Next, the columns are filtered out which do not contain mean or std in their descriptive names.

Finally, this data is aggregated to calculate the means per unique combination of Subject Id and Activity Id and written out as a csv file.

