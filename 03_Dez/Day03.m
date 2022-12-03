

%specify the path
todays_path = 'C:\Git_hub_Repositories\codemas\03_Dez\';

% specify the input file
filename = 'input.txt';

%open the file
fid = fopen([todays_path filename]);
%fclose([todays_path filename]);

% load the file's data into a temporary cell array an transfer it to data
temp = textscan(fid, '%s');
data = temp{1};


compare_string = 'abcdefghijklmnopqrstuvwxyzABCDEFGHYJKLMNOPQRSTUVWXYZ';

##double_items = zeros(size(data,1),100);

for k = 1:size(data,1)
temp_char = data{k};
clear find_letters
  for i = 1:size(temp_char,2)/2

  find_letters(i,1) = strfind(compare_string, temp_char(i));
  find_letters(i,2) = strfind(compare_string, temp_char(i+size(temp_char,2)/2));

  end

double_items(k) = intersect(find_letters(:,1), find_letters(:,2));

end

answer1 = sum(double_items,2);

%part II

for k = 0:(size(data,1)/3)-1
clear find_letters
  for j = 1:3
  temp_char = data{(k*3)+j};

    for i = 1:size(temp_char,2)

    find_letters(i,j) = strfind(compare_string, temp_char(i));

    end
  end



badges(k+1) = intersect(find_letters(:,1),intersect( find_letters(:,2),find_letters(:,3)));

end


answer2 = sum(badges,2);

