
%Today I would like to express my admiration for my lab, who all solved the
%coding puzzle before me! 

%specify the path
todays_path = 'C:\GitHub_Repos\codemas\06_Dez\';

% specify the input file
filename = 'input.txt';

%open the file
fid = fopen([todays_path filename]);

% load the file's data into a temporary cell array and transfer it to data
temp = textscan(fid, '%s');
fclose(fid);
data = temp{1};
data = data{1};

%loop to find all strings of 4 unique characters
k = 1;
for i = 4:size(data,2)
   
  unique_str = unique(data(i-3:i));
  if size(unique_str,2) == 4
      start_signals(k) = i;
      k = k +1;
  end
       
end

%loop to find all strings of 14 unique characters
k = 1;
for i = 14:size(data,2)
    
  unique_str = unique(data(i-13:i));
  if size(unique_str,2) == 14
      start_messages(k) = i;
      k = k +1;
  end
       
end