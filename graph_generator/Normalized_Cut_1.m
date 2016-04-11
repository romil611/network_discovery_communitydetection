function [ min_score ] = Normalized_Cut_1(Network, S, community, Nc_S, num_comm, i)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
scoreA = zeros(size(num_comm,1),1);
score = zeros(size(num_comm,1),1);
min_score = inf;
for k = 1:num_comm
    temp = Network(:,1) == i;   % add to S
    temp = Network(temp,:);
    temp = [S;temp];
    if Assoc(temp, community, k) > 0
        scoreA(k) = (Cut(temp, community, k)/Assoc(temp, community, k));
    else
        scoreA(k) = 0;
    end
end

for j = 1:num_comm
    temp = community;           % add to community as its a part of the community
    temp(i,1:2) = [i,j];
    if Assoc(S, temp, j) > 0
        score(j) = (Cut(S, temp, j)/Assoc(S, temp, j)) + sum(scoreA([1:j-1 j+1:end]));
    else
        score(j) = sum(scoreA([1:j-1 j+1:end]));
    end
end

min_score = min(score);
end


