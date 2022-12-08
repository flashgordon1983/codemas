

%specify the path
todays_path = 'C:\GitHub_Repos\codemas\08_Dez\';

% specify the input file
filename = 'input.txt';

%importdata([todays_path filename])

%open the file
fid = fopen([todays_path filename]);
%fclose(fid);

% load the file's data into a temporary cell array an transfer it to data
temp = textscan(fid, '%c');%, 'Delimiter', ['/n']);
data = temp{1};
my_fact = factor(size(data,1));
data = reshape(str2num(data),99,99)'; %,5,5) %


tall_trees = zeros(size(data,1),size(data,2));
tall_trees([1 end],1:end)=1;
tall_trees(1:end,[1 end])=1;
for i = 2:size(data,1)-1
    for j = 2:size(data,2)-1
        tall_trees(i,j) = (data(i,j) > max(data(1:i-1,j))) | ...
                          (data(i,j) > max(data(i+1:end,j))) | ...
                          (data(i,j) > max(data(i,1:j-1))) | ...
                          (data(i,j) > max(data(i,j+1:end))) ;
        
    end
end

answer1 = sum(sum(tall_trees));

scenic_score = zeros(size(data,1),size(data,2));

for i = 2:size(data,1)-1
    for j = 2:size(data,2)-1
        if (data(i,j) > max(data(1:i-1,j)))
            temp_scenic_score(1) = i -1;
        else
            temp_scenic_score(1) = i - max((find(data(i,j) <= data(1:i-1,j))));
        end
        if (data(i,j) > max(data(i+1:end,j)))
            temp_scenic_score(2) = size(data,1)-i;
        else
            temp_scenic_score(2) = min((find(data(i,j) <= data(i+1:end,j))));
        end
        if (data(i,j) > max(data(i,1:j-1)))
            temp_scenic_score(3) = j -1;
        else
            temp_scenic_score(3) = j - max((find(data(i,j) <= data(i,1:j-1))));
        end
        if (data(i,j) > max(data(i,j+1:end)))
            temp_scenic_score(4) = size(data,2)-j;
        else
            temp_scenic_score(4) = min((find(data(i,j) <= data(i,j+1:end))));
        end
        scenic_score(i,j) = temp_scenic_score(1)*temp_scenic_score(2)*...
                            temp_scenic_score(3)*temp_scenic_score(4);
    end
end


answer2 = max(max(scenic_score));
