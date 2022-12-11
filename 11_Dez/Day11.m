

close all
clear all

%specify the path
todays_path = 'C:\Git_hub_Repositories\codemas\11_Dez\';

% specify the input file
filename = 'Input.txt';

%open the file
fid = fopen([todays_path filename]);
i = 1;

while 1

##j =  1;


for monk = 1:7
  temp = fgetl(fid);

  if strncmpi(temp, "Monkey",6)
   temp_data = textscan(temp,"%*s %d", "Delimiter"," ");
   data.monkeys(i) = temp_data{1};

   elseif strncmpi(temp, "  Start",7)
   item_indx = regexp(temp,'\d*');
   for j = 1:size(item_indx,2)
    data.items(i,j) = str2num(temp(item_indx(j):item_indx(j)+1));
   end
   elseif strncmpi(temp, "  Operation",9)
    op1_indx = regexp(temp,'[+*]');
    data.operation1(i) = temp(op1_indx);
      if size(regexp(temp,'old'),2) == 2
        data.operation2(i) = -99;
      else
        temp_data = textscan(temp,"%*s %*s %*s %*s %*s %d", "Delimiter"," ");
        data.operation2(i) = temp_data{1};
      end
   elseif strncmpi(temp, "  Test",6)
     temp_data = textscan(temp,"%*s %*s %*s %d", "Delimiter"," ");
     data.test(i) = temp_data{1};
   elseif strncmpi(temp, "    If t",8)
     temp_data = textscan(temp,"%*s %*s %*s %*s %*s %d", "Delimiter"," ");
     data.true(i) = temp_data{1};
   elseif strncmpi(temp, "    If f",8)
     temp_data = textscan(temp,"%*s %*s %*s %*s %*s %d", "Delimiter"," ");
     data.false(i) = temp_data{1};
   else
   end

end

i = i +1;

if temp == -1
  break
end


end

data.operation2 = cast(data.operation2,"double");


data.items = [data.items zeros(size(data.monkeys,2),92)];

data.items(data.items==0) = NaN;
data.items = uint64(data.items);
data.test = uint64(data.test);
monkey_num = 1
item_num = 1
monkey_business = zeros(8,1);

##%part1
##for rounds = 1:20
##  for monkey_num = 1:size(data.monkeys,2)
##    for item_num = 1: sum(data.items(monkey_num,:)>0)
##
##
##      if strcmp(data.operation1(monkey_num),'+') && data.operation2(monkey_num) ~= -99
##          temp_item = data.items(monkey_num,item_num)+data.operation2(monkey_num);
##      elseif strcmp(data.operation1(monkey_num),'*') && data.operation2(monkey_num) ~= -99
##          temp_item = data.items(monkey_num,item_num)*data.operation2(monkey_num);
##      elseif data.operation2(monkey_num) == -99
##          temp_item = data.items(monkey_num,item_num)^2;
##      end
##      temp_item = floor(cast(temp_item,"double")/3);
##
##      if mod(temp_item,data.test(monkey_num)) == 0
##        data.items(data.true(monkey_num)+1,sum(data.items(data.true(monkey_num)+1,:)>0)+1) ...
##        = temp_item;
##      else
##        data.items(data.false(monkey_num)+1,sum(data.items(data.false(monkey_num)+1,:)>0)+1) ...
##        = temp_item;
##      end
##      data.items(monkey_num,item_num) = 0;
##      monkey_business(monkey_num) = monkey_business(monkey_num)+1;
##    end
##  end
##  a = 1 +2 ;
##end
##
##monkey_business = sort(monkey_business,'descend');
##
##answer1= (monkey_business(1)*monkey_business(2));


%part2

%multiplier = 10;

%data.items = data.items/multiplier;

modifier = uint64(data.test(1)*data.test(2)*data.test(3)*data.test(4) *...
            data.test(5)*data.test(6)*data.test(7) * data.test(8));

for rounds = 1:10000
  for monkey_num = 1:size(data.monkeys,2)
    for item_num = 1: sum(~isnan(data.items(monkey_num,:)))


      if strcmp(data.operation1(monkey_num),'+') && data.operation2(monkey_num) ~= -99
          temp_item = data.items(monkey_num,item_num)+(data.operation2(monkey_num));
      elseif strcmp(data.operation1(monkey_num),'*') && data.operation2(monkey_num) ~= -99
          temp_item = mod(data.items(monkey_num,item_num)*data.operation2(monkey_num),modifier);
      elseif data.operation2(monkey_num) == -99
          %temp_item = double(mod(sym(data.items(monkey_num,item_num))^2,modifier));
          temp_item = (mod(uint64(data.items(monkey_num,item_num))^2,uint64(modifier)));
      end
      %temp_item = floor(cast(temp_item,"double")/3);
      temp_item = mod(temp_item,modifier);

      if mod(temp_item,(data.test(monkey_num))) == 0
        data.items(data.true(monkey_num)+1,sum(~isnan(data.items(data.true(monkey_num)+1,:)))+1) ...
        = temp_item;
      else
        data.items(data.false(monkey_num)+1,sum(~isnan(data.items(data.false(monkey_num)+1,:)))+1) ...
        = temp_item;
      end
      data.items(monkey_num,item_num) = NaN;
      monkey_business(monkey_num) = monkey_business(monkey_num)+1;
    end
  end
%multiplier = multiplier*multiplier;

end

monkey_business = sort(monkey_business,'descend');

answer2= (monkey_business(1)*monkey_business(2));














