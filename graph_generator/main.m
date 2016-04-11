%Algorithm Net discover

clc;
clear;
load ('ire_data_1000.mat');
tic;

num_nodes = max(actual_com(:,1));
num_Nt = floor(num_nodes*.15); % randomly picked
Nt = randi(num_nodes,[num_Nt,1]);
S = ismember(network(:,1),Nt);
S = network(S,:);
mu = 0.05;
community(1:size(actual_com,1),1:2) = -1; 
%community(Nt,:) = actual_com(Nt,:);    %for now only
for i = 1:size(actual_com,1)
    cost.(strcat('a',int2str(actual_com(i,1)))) = 1; % for now cost is same for every node
end
%budget = num_nodes;
budget = 1;
cur_cost = 0;
Nc_S = setdiff(network(S(:,1),2),S(:,1));
while cur_cost < budget 
   i =  Choose_Node(S, community, network, Nc_S, num_com, cost, budget, cur_cost, mu);
   new_node = Nc_S(i);
   new_net = network(:,1) == new_node;
   new_net = network(new_net,:);
   S = [S;new_net];
   cur_cost = cost.(strcat('a',int2str(i))) + cur_cost; 
   %Nc_S = setdiff(network(S(:,1),2),S(:,1)); %discover locality 
   %update community
   
end
toc;
% todo remove for loops in
%       line 11 of this file
%       3 nested for loops
%       24 line
%       25 line
%       evaluation of the result