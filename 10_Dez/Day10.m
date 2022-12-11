

%specify the path
todays_path = 'C:\Git_hub_Repositories\codemas\10_Dez\';

% specify the input file
filename = 'input.txt';

%open the file
fid = fopen([todays_path filename]);

ops = 1;
x = 1;
data(1,1:2) = 1
while fid ~= -1
if fid == -1
  break
end

temp = fgetl(fid);


if strcmp(temp, "noop")

  data(ops,1) = ops;
  data(ops,2) = x;
  x = data(ops,2);

  ops = ops + 1;
else
  addx = textscan(temp, "%*s %d", "Delimiter", " ");
  data(ops:ops+1,1) = [ops ops+1];
  data(ops:ops+1,2) = x;

  ops = ops +2
  x = x + addx{1};
end

end



data(:,3) = data(:,1).*data(:,2);

i = [20 60 100 140 180 220];

answer1 = sum(data(i,3));

screen = repmat(0:39,1,6);

data(:,4) = screen;


for ops = 1:240

 if  abs(data(ops,4) - data(ops,2)) <=1
   data(ops,5) = 1;
 else
   data(ops,5) = 0;
 end

end




screen = reshape(data(:,5),40,6)';
colormap (jet (21));

image(screen.*10+1)



