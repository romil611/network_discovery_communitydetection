%Algorithm Net discover

clc;
clear;
load ('ire_data_10000.mat');
tic;

mu = 0.05;
budget = 1;
cur_cost = 0;
local_count = 0;
global_count = 0;
num_com = 28; %no. of communities
threshold = 0.5;
num_nodes = max(actual_com(:,1));
num_Nt = floor(num_nodes*.15); % randomly picked
nodes_per_com = 10;

Nt = zeros(num_com*nodes_per_com,1);
for i = 1:num_com
t = actual_com(:,2) == i;
t = actual_com(t,1);
Nt((i-1)*nodes_per_com+1:(i)*nodes_per_com) = t(1:nodes_per_com);
end
% Nt = randi(num_nodes,[num_Nt,1]);
S = ismember(network(:,1),Nt);
S = network(S,:);
orig_num_edge = size(S,1); 
q = randi(size(Nt,1),size(Nt,1),num_com);
theta = randi([1,28],size(actual_com,1),num_com);

community(1:size(actual_com,1),1:2) = -1;
B = ismember(S(:,2),Nt);
B = S(B,:);
A = zeros(size(Nt,1)); %adjacency matrix

for i = 1:size(Nt,1)
a = B(:,1) == Nt(i);
A(i,:) = ismember(Nt,B(a,2));
end
temp = 1:num_nodes;
[c,~,~] = SpectralClustering(A, num_com,3);
community(Nt,:) = [temp(Nt)',c];
for i = 1:size(actual_com,1)
    cost.(strcat('a',int2str(actual_com(i,1)))) = 1; % for now cost is same for every node
end

Nc_S = setdiff(network(S(:,1),2),S(:,1));
qqqqqqq = 1
while cur_cost < budget 
   i = Choose_Node(S, community, network, Nc_S, num_com, cost, budget, cur_cost, mu);
   cur_cost = 1;
%    new_node = Nc_S(i);
%    new_net = network(:,1) == new_node;
%    new_net = network(new_net,:);
%    S = [S;new_net];
%    cur_num_edge = size(S,1);
%    cur_cost = cost.(strcat('a',int2str(i))) + cur_cost; 
%    Nc_S = setdiff(network(S(:,1),2),S(:,1)); %discover locality 
%    %update community
%    qqqqqqq = 2
%    
%   % if (cur_num_edge - orig_num_edge)/ orig_num_edge >= 0.1 %global update
%        global_count = global_count + 1;
%        orig_num_edge = cur_num_edge;
%        [list_com, q, theta] = community_detection(theta, A, num_com, threshold);
%        
       
%    else
%        local_count = local_count + 1;
%        local = S(:,1) == new_node;
%        [list_com, q, theta] = local_community_detection(theta, q, A, num_com, threshold, local);
%        
%    end
         
end
toc;
