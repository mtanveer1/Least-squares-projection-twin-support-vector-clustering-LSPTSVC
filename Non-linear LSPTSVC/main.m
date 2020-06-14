clc;
clear all;
close all;
file1 = fopen('Result.txt','a+');
fprintf(file1,'%s\n',date);

             
for load_file = 1:4
    %% initializing variables
 
    %% to load file
    switch load_file

	case 1
            file= 'ds2c2sc13'; 
                    test_start = 151; 
                     cvs1=10^-5;
                      cvs2=0.0001;
                      mus=0.03125;
                      
     case 2
            file= 'spherical_5_2';          
                    test_start = 2001; 
                     cvs1=0.001;
                      cvs2=0.0001;
                      mus=2;     
                      
       case 3
            file='elliptical_10_2'
                    test_start = 561;
                   cvs1=10^-5;
                      cvs2=0.001;
                      mus=32;
                      
        case 4
             file = '2d-4c-no4'             
                    test_start = 961; 
                     cvs1=10;
                      cvs2=100000;
                      mus=4;

        otherwise
            continue;
    end
 
filename = strcat('./newd/',file,'.txt');

    A = load(filename);
    [m,n] = size(A);

  % Dividing the data in training and testing    
  [no_input,no_col] = size(A);
  test_start=ceil(no_input*0.5)+1;
    test = A(test_start:m,:);
    train = A(1:test_start-1,:);
    x1 = train(:,1:no_col-1);
    y1 = train(:,no_col);
% 	    
    [no_test,no_col] = size(test);
    xtest0 = test(:,1:no_col-1);
    ytest0 = test(:,no_col);
	Y=y1;

    %Combining all the column in one variable
     A=[x1 y1];    %training data
    A_test=[xtest0,ytest0];    %testing data

    min_c1=cvs1;
    min_c2=cvs2;
    min_mu=mus;
   
 [accuracy,time,ite] = lsptsvc(A,A_test,Y,min_c1,min_c2,min_mu)
 fprintf(file1,'%s\t%g\t%g\t%g\t%g\t%g\t%g\t%g\tite %g\n',file,size(A,1),size(A_test,1),accuracy,min_c1,min_c2,min_mu,time,ite);

end