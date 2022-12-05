
%%%This is a comment to let Simon know that I highly recommend protein
%%%pudding for any situation....


%specify the path
todays_path = 'C:\GitHub_Repos\codemas\05_Dez\';

% specify the input file
filename = 'input.txt';

%open the file
fid = fopen([todays_path filename]);
%fclose(fid);


for i = 1:8
stack_unformatted(i,:) = fgetl(fid);
end

for i = 1:2
   fgetl(fid) ;
end
i = 1;
temp = 1;
while temp ~= -1
   temp = fgetl(fid) ;
   if temp == -1
    break 
   end
   moves_unformatted = textscan(temp, '%s %d %s %d %s %d', 'Delimiter', [' ']);
   moves(i,1) = moves_unformatted{1,2};
   moves(i,2) = moves_unformatted{1,4};
   moves(i,3) = moves_unformatted{1,6};
   i = i+1;
end

fclose(fid);

stack_unformatted = stack_unformatted';

for i = 0:8
    
   stack{i+1,:} = strtrim(flip(stack_unformatted(i+2+i*3,:)));
    
end


for k = 1: size(moves,1)
    
    gives = stack{moves(k,2),1};
    gets = stack{moves(k,3),1};
    gets(end+1:end+moves(k,1)) = gives(end-(moves(k,1)-1):end); 
    %USED FOR ANSWER1%flip(gives(end-(moves(k,1)-1):end));
    gives = gives(1:end-moves(k,1));
    stack{moves(k,2),1} = gives;
    stack{moves(k,3),1} = gets;  
    clear gives gets
    
end

for k = 1:size(stack,1)

    answer2(k) = stack{k,1}(end);
    
end


