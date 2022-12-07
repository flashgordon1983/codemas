function varargs_out = day07()
% this problem made me cry!

%specify the path
todays_path = 'C:\GitHub_Repos\codemas\07_Dez\';

% specify the input file
filename = 'input.txt';

%open the file
fid = fopen([todays_path filename]);
%fclose(fid);

i = 0;
cd1 = "";
%parse through the input and put it in sensible variables
while fid ~= -1
temp = fgetl(fid);

if temp == -1
break
elseif  (temp(1) == '$') & (temp(3) == 'c') & (temp(6) ~= '.')
   i = i + 1;
   temp_dir = textscan(temp, '%*1s %*2s %s', 'Delimiter', [' ']);
   dir(i,:) =  strcat(cd1, "/", temp_dir{:});
   cd1 = dir(i,:);
   %cd2 = temp_dir{:};
   k = 1;
   j =1 ;
elseif (temp(1) == '$') & (temp(3) == 'c') & (temp(6) == '.') 
    last_dir = strfind(cd1{1},"/");
    cd1{1} = cd1{1}(1:(last_dir(end)-1));
elseif (temp(1) == '$') & (temp(3) == 'l')
else
    if (temp(1) == 'd')
        
        temp_dir = textscan(temp, '%*3s %s', 'Delimiter', [' ']);
        contains{i,k} = strcat(dir(i,:) ,"/", temp_dir{:}) ;
        k = k+1;
    else
        filesizes(i,j) = cell2mat(textscan(temp, '%d %*s', 'Delimiter', [' ']));
        j = j +1;
    end
end



end

%match the directory names to line numbers
contains_num = NaN(198,8);
for i = 1:size(contains,1)
   for k = 1:size(contains,2)
       if isempty(contains{i,k})
           break
       end
    temp = contains{i,k}{:} ;
    for m = 1:size(dir,1)
    if strcmp ( dir{m} , temp)    
       contains_num(i,k) = m; 
    end
    end
   end 
end

%calculate the size of directories using a recursive function
contains_num(199:200,:) = NaN(2,8);
%contains_num(3:4,:) = NaN(2,2);
for dirs = 1:size(dir,1)
dir_sizes(dirs) = dir_size(dirs, filesizes,contains_num); 
end

%calculate the two answers
answer1 = sum(dir_sizes(dir_sizes<=100000));
free = 70000000 - dir_sizes(1);
large_enough = sort(dir_sizes(dir_sizes>=(30000000-free)));
answer2 = large_enough(1);

end 

function output = dir_size(directory, filesizes,contains_num)
% recursive funtion that calculates the directory sizes

output = sum(filesizes(directory,:),2);
for i = 1:size(contains_num,2)
   if contains_num(directory,i)== 0 
       break
   end
   if (isnan(contains_num(directory,i))) 
       break
   end

   output = output + dir_size(contains_num(directory,i), filesizes,contains_num);
   
end
end
