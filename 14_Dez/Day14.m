
clear all

close all


%specify the path
todays_path = pwd;

% specify the input file
filename = 'Input.txt';

%open the file
fid = fopen([todays_path '\' filename]);
i =1;

data = nan(163,60);


while  1

temp = fgetl(fid);

  if temp == -1

    break
  end


temp = regexp(temp, '\d*','match');

temp = cellfun(@str2num, temp);

data(i,1:size(temp,2)) = temp;

i = i +1;



end




size_Y = max(max(data(:,2:2:60)));
size_X = max(max(data(:,1:2:59)));


chamber = nan(size_Y+1,size_X+2);
chamber(size_Y+2,:) = 99;



for i = 1:sum(~isnan(data(:,1)),1)
  for k = 1:2:(sum(~isnan(data(i,:))))-2
    chamber(min([data(i,k+1)+1 data(i,k+3)+1]):max([data(i,k+1)+1 data(i,k+3)+1]),...
            min([data(i,k+2) data(i,k)]):max([data(i,k+2) data(i,k)])) = 1;

##    chamber(data(i,k+1)+1:data(i,k+3)+1,data(i,k):data(i,k+2)) = 1;

  endfor

end





end_var = 0;

while end_var == 0
sand_indx = [1 500];
next = 0;
while next == 0

  if isnan(chamber(sand_indx(1)+1,sand_indx(2)))
    sand_indx(1) = sand_indx(1)+1;
  elseif isnan(chamber(sand_indx(1)+1,sand_indx(2)-1))
     sand_indx(1) = sand_indx(1)+1;
     sand_indx(2) = sand_indx(2)-1;
  elseif isnan(chamber(sand_indx(1)+1,sand_indx(2)+1))
     sand_indx(1) = sand_indx(1)+1;
     sand_indx(2) = sand_indx(2)+1;
  elseif chamber(sand_indx(1)+1,sand_indx(2)) == 99
     end_var = 1;
     break
  else
     chamber(sand_indx(1),sand_indx(2)) = 2;
     next = 1;
##     break
  end
end
end


answer1 = sum(sum(chamber == 2));











