

%specify the path
todays_path = 'C:\GitHub_Repos\codemas\09_Dez\';

% specify the input file
filename = 'input.txt';

%open the file
fid = fopen([todays_path filename]);

%put input in temporary variable
data = textscan(fid, '%s %d', 'Delimiter', ' ');

%H_indx = zeros(11452,2);
sum(data{1,2})
a = 1;
i = 1;
k = 1;
while a == 1

%move the head
if data{1,1}(i) == "L"
    for j = 1:data{1,2}(i)
        H_indx(k+1,2) = H_indx(k,2) - 1;
        H_indx(k+1,1) = H_indx(k,1);
        k = k+1;
    end
    i = i +1;
elseif data{1,1}(i) == "R"
    for j = 1:data{1,2}(i)
    H_indx(k+1,2) = H_indx(k,2) + 1;
    H_indx(k+1,1) = H_indx(k,1);
    k = k+1;
    end
    i = i +1;
elseif data{1,1}(i) == "U"
    for j = 1:data{1,2}(i)
    H_indx(k+1,1) = H_indx(k,1) + 1;
    H_indx(k+1,2) = H_indx(k,2);
    k = k+1;
    end
    i = i +1;
elseif data{1,1}(i) == "D"
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

%T_indx = zeros(size(H_indx,1),2);

for i = 1:size(H_indx,1)
 
diff_indx = T_indx(i,:)- H_indx(i,:);
if max(abs(diff_indx))<=1
   T_indx(i,:) = T_indx(i,:);
% else
%   T_indx(i,:) = T_indx(i,:) + diff_indx.*((abs(diff_indx)==max(abs(diff_indx))))/(-2) + ...
%                                 diff_indx.*((abs(diff_indx)==min(abs(diff_indx))))*(-1);
elseif diff_indx(1) == -2
    T_indx(i,:) = H_indx(i,:)+[-1 0];
elseif diff_indx(1) == 2
    T_indx(i,:) = H_indx(i,:)+[1 0];
elseif diff_indx(2) == -2
    T_indx(i,:) = H_indx(i,:)+[0 -1];
elseif diff_indx(2) == 2
    T_indx(i,:) = H_indx(i,:)+[0 1];
end
T_indx(i+1,:)=T_indx(i,:);
end

field = zeros(1000,1000);

for i = 1:11452
   field((500+T_indx(i,1)),(500+T_indx(i,2))) = 1; 
    
end

%H_indx-T_indx(1:11448,:);


answer = sum(sum(field));

%     figure
%     hold
% 
%     mesh(field)
% 
%     plot(H_indx(:,1),H_indx(:,2));
% 
%     plot(T_indx(:,1),T_indx(:,2));
% 
%     for i = 2:11448
%     plot(H_indx(1:i,1),H_indx(1:i,2));
% 
%     plot(T_indx(1:i,1),T_indx(1:i,2));
%     pause(1)
%     end

%%part two
master_H_indx = H_indx;
T_indx = T_indx(1:end-1,:);
for k = 1:9
if k > 1
    H_indx = T_indx;
end
   % T_indx = zeros(size(H_indx,1),2);

for i = 1:size(H_indx,1)
 
diff_indx = T_indx(i,:)- H_indx(i,:);
if max(abs(diff_indx))<=1
   T_indx(i,:) = T_indx(i,:);
% else
%   T_indx(i,:) = T_indx(i,:) + diff_indx.*((abs(diff_indx)==max(abs(diff_indx))))/(-2) + ...
%                                 diff_indx.*((abs(diff_indx)==min(abs(diff_indx))))*(-1);
elseif diff_indx(1) == -2
    T_indx(i,:) = H_indx(i,:)+[-1 0];
elseif diff_indx(1) == 2
    T_indx(i,:) = H_indx(i,:)+[1 0];
elseif diff_indx(2) == -2
    T_indx(i,:) = H_indx(i,:)+[0 -1];
elseif diff_indx(2) == 2
    T_indx(i,:) = H_indx(i,:)+[0 1];
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

