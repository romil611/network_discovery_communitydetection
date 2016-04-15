% Algorithm Net discover

clc;
clear;
load ('ire_data_1000.mat');
tic;

mu = 0.05;
budget = 1;
cur_cost = 0;
local_count = 0;
global_count = 0;
threshold = 0.5;
num_nodes = max(actual_com(:,1));
num_Nt = floor(num_nodes*.5); % randomly picked
nodes_per_com = 10;
iter_max = 10;
com_track = zeros([num_nodes,num_com]);

Nt = zeros(num_com*nodes_per_com,1);
% for i = 1:num_com
%     t = actual_com(:,2) == i;
%     t = actual_com(t,1);
%     Nt((i-1)*nodes_per_com+1:(i)*nodes_per_com) = t(1:nodes_per_com);
% end
Nt = randi(num_nodes,[num_Nt,1]);
Nc = Nt;

S = ismember(network(:,1),Nt);
S = network(S,:);
orig_num_edge = size(S,1);
q = rand([size(Nt,1),size(Nt,1),num_com]);
theta = randi([1,num_com],size(Nt,1),num_com);

community(1:size(actual_com,1),1:2) = -1;
B = ismember(S(:,2),Nt);
B = S(B,:);
A = zeros(size(Nt,1)); %adjacency matrix

for i = 1:size(Nt,1)
    a = B(:,1) == Nt(i);  % ith nodes positions found
    A(i,:) = ismember(Nt,B(a,2)); % checking where its connected nodes lie
end
temp = 1:num_nodes;
[c,~,~] = SpectralClustering(A, num_com,3);
theta(1:size(A,1),1:num_com) = (10-1)*rand(size(A,1),num_com);
for i = 1:size(A,1)
    theta(i,c(i)) = 100;
end
community(Nt,:) = [temp(Nt)',c];
for i = 1:size(actual_com,1)
    cost.(strcat('a',int2str(actual_com(i,1)))) = 1; % for now cost is same for every node
end

Nc_S = setdiff(S(:,2),S(:,1));
fprintf('%d\n',cur_cost);
while cur_cost < budget
    %     i = Choose_Node(S, community, network, Nc_S, num_com, cost, budget, cur_cost, mu);
    fprintf('%d\n',cur_cost);
    i =1;
    new_node = Nc_S(i);
    new_net = network(:,1) == new_node;
    new_net = network(new_net,:);
    
    Stemp = [S;new_net];
    S = Stemp;
    
    cur_num_edge = size(S,1);
    cur_cost = cost.(strcat('a',int2str(i))) + cur_cost;
    Nc_S = setdiff(S(:,2),S(:,1)); %discover locality
    
    Btemp = ismember(new_net(:,2),Nt);
    Btemp = new_net(Btemp,:);
    Btemp2 = [B;Btemp];
    B = Btemp2;
    
    Nc = [Nc;new_node]; %needed only for community_detection
    a = B(:,1) == new_node;
    Atemp = zeros(size(Nc,1));
    Atemp(1:end-1,1:end-1) = A;
    Atemp(end,:) = ismember(Nc,B(a,2));
    Atemp(1:end-1,end) = Atemp(end,1:end-1)';
    A = Atemp;
    
    
    %            update community
    qqq=2
    if (cur_num_edge - orig_num_edge)/ orig_num_edge >= 0.1 %global update
        global_count = global_count + 1;
        [c,~,~] = SpectralClustering(A, num_com,3);
        theta(1:size(A,1),1:num_com) = (10-1)*rand(size(A,1),num_com);
        for i = 1:size(A,1)
            theta(i,c(i)) = 100;
        end
        orig_num_edge = cur_num_edge;
        [list_com, q, theta,temp] = community_detection(theta, A, num_com, threshold, iter_max);
        community(Nc,:) = [Nc,list_com];
        com_track(Nc,list_com) = com_track(Nc,list_com) +1;
    else
        temp = zeros([size(Nc,1),num_com]);
        temp(1:end-1,:) = theta;
        temp(end,:) = (10-1)*rand([num_com,1]);
        theta = temp;
        temp = rand([size(Nc,1),size(Nc,1),num_com]);
        temp(1:end-1,1:end-1,:) = q;
        q = temp;
        local_count = local_count + 1;
        local = S(:,1) == new_node;
        local = S(local,2);
        local = ismember(Nc,local);
        qqq
        [list_com, q, theta] = local_community_detection(theta, q, A, num_com, threshold, local, iter_max);
        community(local,:) = [Nc(local),list_com(local)];
        com_track(Nc(local),list_com) = com_track(Nc(local),list_com) + 1;
    end
end
shifts = sum(com_track,2);
fast_shifting_nodes = find(shifts >= 1.5*mean(shifts));
low_shifting_nodes = find(shifts <= 0.5*mean(shifts));
    
    
toc;
