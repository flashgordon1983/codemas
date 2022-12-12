
clear all

close all


%specify the path
todays_path = 'C:\Git_hub_Repositories\codemas\12_Dez\';

% specify the input file
filename = 'Input.txt';

%open the file
fid = fopen([todays_path filename]);

k = 1;

while 1
  temp2 = fgetl(fid);
  temp{k,1} = temp2;
  k = k +1;
  if temp2 == -1
    break
  end
end


%put input in temporary variable
%temp = textscan(fid, '%s') %, 'Delimiter', '/n');

data = temp;


compare_string = 'SabcdefghijklmnopqrstuvwxyzE';

##i = 1;
##j = 1;

for j = 1:size(data,1)-1 %need this for real input
  for i = 1:size(data{1},2)


     temp_data(j,i) = strfind(compare_string, data{j}(1,i));


  end

end
data = temp_data;

data_nodes = 1:size(data(:),1);

data_nodes = reshape(data_nodes,size(data,2),size(data,1))';

E = data_nodes(find(data(:)==max(data(:))));
S = data_nodes(find(data(:)==min(data(:))));


data(:,end+1) = 999;
data(end+1,:) = 999;




G = cell(max(data_nodes(:)),1);

for i = 1:size(data,2)-1
  for j = 1:size(data,1)-1
      temp_neighbour = G{data_nodes(j,i),1};
      if abs(data(j,i) - data(j,i+1)) <= 1
        temp_neighbour = [temp_neighbour data_nodes(j,i+1)];
      else
        temp_neighbour = [];
      end
      if abs(data(j,i) - data(j+1,i)) <= 1
         temp_neighbour = [temp_neighbour data_nodes(j+1,i)];
      end
      G{data_nodes(j,i),1} = temp_neighbour;
      clear temp_neighbour;

  end
end

Nodes1_single = [];
Nodes2_single = [];

for i = 1:size(G,1)

 Nodes1_single = [Nodes1_single repmat(i,size(G{i},1,2))];
 Nodes2_single = [Nodes2_single G{i}];


end


data = data(:,[end 1:end-1]) ;

data = data([end 1:end-1],:) ;

data_nodes(:, end+1) = 999;
data_nodes( end+1,:) = 999;

data_nodes = data_nodes(:,[end 1:end-1]);
data_nodes = data_nodes([end 1:end-1],:) ;


for i = flip(2:size(data,2))
  for j = flip(2:size(data,1))
      temp_neighbour = G{data_nodes(j,i),1};
      if abs(data(j,i) - data(j,i-1)) <= 1
        temp_neighbour = [temp_neighbour data_nodes(j,i-1)];
      else
        temp_neighbour = temp_neighbour;
      end
      if abs(data(j,i) - data(j-1,i)) <= 1
         temp_neighbour = [temp_neighbour data_nodes(j-1,i)];
      end
      G{data_nodes(j,i),1} = temp_neighbour;
      clear temp_neighbour;
  end
end

cd C:\Toolboxes\aeolianine-octave-networks-toolbox-e70f79e



answer1 = dijkstra(adjL2adj(G),1,E);


Nodes1 = [];
Nodes2 = [];

for i = 1:size(G,1)

 Nodes1 = [Nodes1 repmat(i,size(G{i},1,2))];
 Nodes2 = [Nodes2 G{i}];


end



