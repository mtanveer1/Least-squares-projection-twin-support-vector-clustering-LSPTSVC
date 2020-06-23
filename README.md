# Least squares projection twin support vector clustering (LSPTSVC)

This is implementation of the paper: B. Richhariya, M. Tanveer,
Least squares projection twin support vector clustering (LSPTSVC), Information Sciences, Volume 533, 2020, Pages 1-23, https://doi.org/10.1016/j.ins.2020.05.001.

Description of files (Linear and non-linear cases):

main.m: selecting parameters of lsptsvc using k fold cross-validation. One can select parameters c1 (denoted by variable csv1), c2 (denoted by variable csv2), mu (denoted by variable mus) to be used in grid-search method.

lsptsvc.m: implementation of lsptsvc algorithm. Takes parameters c1, c2, mu (for non-linear case), training data and test data and provides accuracy obtained and running time.

For quickly reproducing the results of the lsptsvc algorithm, we have made a newd folder containing a sample dataset. One can simply run the main.m file to check the obtained results on this sample dataset. To run experiments on more datasets, simply add datasets in the newd folder and run main.m file. The code has been tested on Windows 10 with MATLAB R2017a.

* This code is for non-commercial and academic use only.

Please cite the following paper if you are using this code.

Reference: Least squares projection twin support vector clustering (LSPTSVC), Information Sciences, Volume 533, 2020, Pages 1-23, https://doi.org/10.1016/j.ins.2020.05.001.

For further details regarding working of algorithm, please refer to the paper.

If further information is required you may contact on: phd1701241001@iiti.ac.in.
