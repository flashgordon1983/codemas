%specify the path
todays_path = 'C:\Git_hub_Repositories\codemas\04_Dez\';

% specify the input file
filename = 'input.txt';

%open the file
fid = fopen([todays_path filename]);
%fclose([todays_path filename]);

% load the file's data into a temporary cell array an transfer it to data
temp = textscan(fid, '%d', 'Delimiter', ['-' ',']);
data = temp{1};

data = (reshape(data,4,1000))';



contains = (data(:,1) >= data(:,3) & data(:,2) <= data(:,4))...
           | (data(:,1) <= data(:,3) & data(:,2) >= data(:,4));

answer1 = sum(contains);

%another method
##overlaps   = (data(:,1) >= data(:,3) & data(:,2) <= data(:,4))...
##           | (data(:,1) <= data(:,3) & data(:,2) >= data(:,3))...
##           | (data(:,3) >= data(:,1) & data(:,4) <= data(:,2))...
##           | (data(:,3) <= data(:,1) & data(:,4) >= data(:,1));
##



overlaps = ~ ((data(:,2) < data(:,3))...
           | (data(:,1) > data(:,4)));

answer2 = sum(overlaps);

##look = data(~overlaps,1:4);
