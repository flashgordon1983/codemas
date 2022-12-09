

%specify the path
todays_path = 'C:\Git_hub_Repositories\codemas\09_Dez\';

% specify the input file
filename = 'input.txt';

%open the file
fid = fopen([todays_path filename]);

%put input in temporary variable
data = textscan(fid, '%s %d', 'Delimiter', ' ');

H_indx = zeros(11452,2);

a = 1;
i = 1;
k = 1;
while a == 1

%move the head around
if strcmp (data{1,1}(i) , "L")
    for j = 1:data{1,2}(i)
        H_indx(k+1,2) = H_indx(k,2) - 1;
        H_indx(k+1,1) = H_indx(k,1);
        k = k+1;
    end
    i = i +1;
elseif strcmp(data{1,1}(i) , "R")
    for j = 1:data{1,2}(i)
    H_indx(k+1,2) = H_indx(k,2) + 1;
    H_indx(k+1,1) = H_indx(k,1);
    k = k+1;
    end
    i = i +1;
elseif strcmp(data{1,1}(i) , "U")
    for j = 1:data{1,2}(i)
    H_indx(k+1,1) = H_indx(k,1) + 1;
    H_indx(k+1,2) = H_indx(k,2);
    k = k+1;
    end
    i = i +1;
elseif strcmp(data{1,1}(i) , "D")
    for j = 1:data{1,2}(i)
    H_indx(k+1,1) = H_indx(k,1) - 1;
    H_indx(k+1,2) = H_indx(k,2);
    k = k+1;
    end
    i = i +1;
end

if i == 2001
   break
end

end


%move the tail

T_indx = zeros(size(H_indx,1),2);

for i = 1:size(H_indx,1)

diff_indx = T_indx(i,:)- H_indx(i,:);
if max(abs(diff_indx))<=1 %no movement
   T_indx(i,:) = T_indx(i,:);
else %movement
 T_indx(i,:) = T_indx(i,:) + diff_indx.*((abs(diff_indx)==max(abs(diff_indx))))/(-2) + ...
                               diff_indx.*((abs(diff_indx)==min(abs(diff_indx))))*(-1);
end
T_indx(i+1,:)=T_indx(i,:);
end

field = zeros(1000,1000);

for i = 1:11452
   field((500+T_indx(i,1)),(500+T_indx(i,2))) = 1;

end
answer1 = sum(sum(field));


%%part two
master_H_indx = H_indx;
T_indx = T_indx(1:end-1,:);

%basically I just loop over the method above and added an extra movement for when
%segment before moved diagonally, as that was not possible before
for k = 1:9
if k > 1
    H_indx = T_indx;
end

for i = 1:size(H_indx,1)

diff_indx = T_indx(i,:)- H_indx(i,:);

if max(abs(diff_indx))<=1    %no movement neccessary
   T_indx(i,:) = T_indx(i,:);
elseif abs(diff_indx) == [2 2] %diagonal movement after a diagonal segment before moved

  T_indx(i,:) = H_indx(i,:) + (diff_indx./2);
else %any other movement
  T_indx(i,:) = T_indx(i,:) + diff_indx.*((abs(diff_indx)==max(abs(diff_indx))))/(-2) + ...
                              diff_indx.*((abs(diff_indx)==min(abs(diff_indx))))*(-1);
end
T_indx(i+1,:)=T_indx(i,:);
end

T_indx = T_indx(1:end-1,:);
master_T_indx(:,:,k) = T_indx;

end

field = zeros(1000,1000);

for i = 1:11452
   field((500+master_T_indx(i,1,9)),(500+master_T_indx(i,2,9))) = 1;

end

answer2 = sum(sum(field));

