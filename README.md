# Getting-and-Cleaning-Data-run_analysis

To run the script, open the file titled run_analysis.R.  Run the entire script (in RStudio using windows, highlight all of the code and hit ctrl+enter).  Once you run the script, check your working directory for a new file named, "meanColumnsGroupedByActivityAndVolunteer.txt"

Step 1, lines 1 through 42, Merges the training and the test sets to create one data set.

line 2: loaded the dplyr library first.
line 4: Downlaod the datafiles, which are stored in the working directory.  
line 5: Unzip the file in the working directory
lines 7-14: read the data tables into R
lines 17-27: I explored the data to figure out how to merge the data
lines 30-32: Merge test and train data for x, y, and subject
lines 34-37: verified that the mergest worked by looking at the number of rows and columns
lines 39-41: combined all data (x,y,subject) into 1 data frame, and verified it was all there, which completed step 1 of the project.

Step 2, lines 44-51, Extracts only the measurements on the mean and standard deviation for each measurement

line 45: use features.txt to return a vector of column (col) numbers (num) that include with mean( or std(
line 46: creates a data frame that selects only the column numbers from msdfeaturescolnum
line 47: Volunteer/activity/mean/standard deviation/combined. Adds ycombined and subcombined to the data frame
line 49-50: Eplore the new data frame

Step 3: lines 53-59, Uses descriptive activity names to name the activities in the data set

line 55: takes activity number and matches it to the activity description in the activity column of vamsdcombined
line 56: adds data frame from step 3 to namedactivities
line 57: reordered data to keep volunteer in first column.

Step 4: lines 61-70, Appropriately labels the data set with descriptive variable names.

line 62: examine the column names of new order to figure out how to make them more descriptive
line 63: change t to time @beginning of name
line 64: change f to frequency @beginning of name
line 65: change Acc to Acceleration
line 66: change mean to Mean
line 67: change std to StandardDeviation
line 68: removes all underscores from each variable name
line 69: examine the new column names of neworder

Step 5: lines 72-76, From the data set in step 4, create[s] a second, independent tidy data set with the average of each variable for each activity and each subject.
line 74: remove namedactivities C(1,3:69), group, summarize using piping
line 75: writes the table to working directory

