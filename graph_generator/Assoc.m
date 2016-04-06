function [ Associ ] = Assoc(S, community, i)
%The notation assoc(Cc i, S) denotes the
%total degrees of nodes in Cc i within the subgraph of Gc induced by S. 
%S = induced graph, community = community map, i = the target community
    a = community(:,2) == i;
    a = community(a,1);
    b = ismember(S(:,1),a);
    Associ = sum(b);
end