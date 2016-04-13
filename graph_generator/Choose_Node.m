
function [ the_chosen_one] = Choose_Node(S, community, Network, Nc_S, num_com, cost, budget, cur_cost, mu)
%Decides the node to be added in S
%S is the network that has been queried (black nodes), 
%community - assigned communities for the nodes, 
%network - complete actual network,
%Nc_S - Nc - S
%num_com - number of communities (generated by synthetic dataset)
%cost - cost of indv node
%budget - overall budget
%cur_cost - current cost of node
%
score = zeros(size(Nc_S,1),1);
    for i =  1:size(Nc_S,1)
        if cur_cost + cost.(strcat('a',int2str(Nc_S(i)))) <= budget
            score(i) =  Normalized_Cut_1(Network, S, community, Nc_S, num_com, i);
            score(i) = score(i)*(cost.(strcat('a',int2str(Nc_S(i))))^mu); % adjust score
        end
    end
    
    [~,the_chosen_one] = min(score);
    
end

