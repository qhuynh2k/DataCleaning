==================================================================
RUN_ANALYSIS.R
==================================================================

The RUN_ANALYSIS.R program requires the data files in the following
folders:


+ Main Folder:
	- activity_labels.txt	: links the class labels with their activity name.
	- features.txt		: list of all features
	- run_analysis.R	: tiny data R program
	- README.md		: describing how the tiny data R program works
	- CODEBOOK.md		: describing the variables in the tiny_data output file
	- tiny_data.txt		: output file created by run_analysis program

	+ test Folder
		- subject_test.txt	: test subject labels 
		- X_test.txt		: test set
		- y_test.txt		: test labels
	+ train Folder
		- subject_train.txt	: training subject labels
		- X_train.txt		: training set
		- y_train.txt		: training labels


==================================================================
The run_analysis R programs will create a tiny_data.txt file in the
Main Folder. The file contains the mean of in the 33 measurements 
broken down by subjects and activities. 


 