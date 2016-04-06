function [ min_score ] = Normalized_Cut(Network, S, community, Nc_S, num_comm, i)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    score = 0;
    min_score = inf;
    for j = 1:num_comm
        for k = 1:num_comm
            if j~=k
                temp = Network(:,1) == i;
                temp = Network(temp,:);
                temp = [S;temp];
                score = score + (cut(temp, community, k)/Assoc(temp, community, k));
            else
                temp = [community;i,j];
                score = score + (cut(S, temp, j)/Assoc(S, temp, j));
            end
        end
        if score < min_score 
            min_score = score;
        end
    end


end

