


%specify the path
todays_path = 'C:\GitHub_Repos\codemas\02_Dez\';

% specify the input file
filename = 'input.txt';

%open the file
fid = fopen([todays_path filename]);
%fclose([todays_path filename]);

% load the file's data into a temporary cell array
temp = textscan(fid, '%s %s');

%transform the letters to numbers to better deal with them in matrices
data = zeros(size(temp{1},1),2);

data(:,1) = data(:,1) + (cell2mat(temp{1}) == 'A')*1 + (cell2mat(temp{1}) == 'B')*2 ...
            + (cell2mat(temp{1}) == 'C')*3;

data(:,2) = data(:,2) + (cell2mat(temp{2}) == 'X')*1 + (cell2mat(temp{2}) == 'Y')*2 ...
            + (cell2mat(temp{2}) == 'Z')*3;
        
% make a pay-out matrix

pay_out = [1 1 3;
           1 2 6;
           1 3 0;
           2 2 3;
           2 3 6;
           2 1 0;
           3 3 3
           3 1 6;
           3 2 0];
       
 for i =  1:size(data,1)
     
    data(i,3) = pay_out((pay_out(:,1) == data(i,1)) & (pay_out(:,2) == data(i,2) ),3);
         
 end
 
 data(:,4) = sum(data(:,2:3),2);
 
 answer1 = sum(data(:,4));
 
 %%part 2
 
 %transform the problem back to what we know
 

transform = [1 1 3;
             1 2 1;
             1 3 2;
             2 1 1;
             2 2 2;
             2 3 3;
             3 1 2;
             3 2 3;
             3 3 1];

         
 for i =  1:size(data,1)
     
    data(i,5) = transform ((transform (:,1) == data(i,1)) & (transform (:,2) == data(i,2) ),3);
         
 end
 
 %redo the calculations
 
  for i =  1:size(data,1)
     
    data(i,6) = pay_out((pay_out(:,1) == data(i,1)) & (pay_out(:,2) == data(i,5) ),3);
         
 end
 
 data(:,7) = sum(data(:,[5 6]),2);
 
 answer2 = sum(data(:,7));
 
        

