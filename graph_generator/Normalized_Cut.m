function [ min_score ] = Normalized_Cut(Network, S, community, Nc_S, num_comm, i)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    score = 0;
    min_score = inf;
    for j = 1:num_comm
        for k = 1:num_comm
            if j~=k                         
                temp = Network(:,1) == i;   % add to S 
                temp = Network(temp,:);
                temp = [S;temp];
                score = score + (Cut(temp, community, k)/Assoc(temp, community, k));
            else
                temp = community;           % add to community as its a part of the community
                temp(i,1:2) = [i,j];
                score = score + (Cut(S, temp, j)/Assoc(S, temp, j));
            end
        end
        if score < min_score 
            min_score = score;
        end
    end


end

