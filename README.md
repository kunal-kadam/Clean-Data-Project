# Clean-Data-Project
Project done by Kunal kadam


The project is done for the Getting and Cleaning Data course in Specialization in data Science with R on Coursera. 
The repository contains CodeBook.md , run_analysis.R , Cleandata1.txt

Steps followed in preparing the project :

1. Download the dataset if it does not already exist in the working directory
2. Load the activity, feature info, training and test datasets
3. Merge the dataset seperated in (train_x,test_x),(train_y,test_y),(sample_x,sample_y) row wise
4. Merges the three datasets created as (x_full, y_full, sample_full) column wise
5. Extract the mean and std related variables from the merged data set
6. Change the name of the variable with the help of featuers_info
7. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
8. The end result is created in the file Cleandata1.txt.
