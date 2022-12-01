
%specify the path
todays_path = 'C:\GitHub_Repos\codemas\01_Dez\';

% specify the input file
filename = 'input.csv';

%open the file
fid = fopen([todays_path filename]);

% load the file's data into a temporary cell array
temp = textscan(fid,'%n','Delimiter','\n');

% transfer the data to a matrix
data = temp{1};

% find the NaNs
data_indx = isnan(data);

%make an index variable of the NaNs which gives you the border betwen the
%elves
indx = find(data_indx);

%add 1 to the index so it works for the loop
indx = [1 ; indx];

% initialize the calories vector
calories_per_elf = NaN(size(indx,1)-1,1);

%loop through the elves and extract the calories per elf
for i = 1:size(indx,1)-1
  calories_per_elf(i) = nansum(data(indx(i):indx(i+1)));      
end

% find the elf with the most calories
answer_day1_1 = max(calories_per_elf);

% sort the elves to have the top elves at the top
sorted_calories = sort(calories_per_elf, 'descend');

% find the three elves with the most calories
answer_day1_2 = sum(sorted_calories(1:3));
