function [ Aci ] = Cut(S, community, i)
%Find the cut value for the given ith community
%S = induced graph, community = community map, i = the target community
    a = community(:,2) == i;
    a = community(a,1);
    b = ismember(S(:,2),a);
    c = ismember(S(:,1),a);
    e = Ec(S, community, i);
    Aci = (sum(b) + sum(c) - 2*e)^2;
end