# Getting-and-Cleaning-Data-run_analysis

To run the script, open the file titled run_analysis.R.  Run the entire script (in RStudio using windows, highlight all of the code and hit ctrl+enter).

Step #1, lines 1 through 42, Merges the training and the test sets to create one data set.

line 2: loaded the dplyr library first.
line 4: Downlaod the datafiles, which are stored in the working directory.  
line 5: Unzip the file in the working directory

lines 7-14: read the data tables into R
lines 17-27: I explored the data to figure out how to merge the data

lines 30-32: Merge test and train data for x, y, and subject
lines 34-37: verified that the mergest worked by looking at the number of rows and columns

lines 39-41: combined all data (x,y,subject) into 1 data frame, and verified it was all there, which completed step 1 of the project.

Step #2, lines 44-51
