function [ Aci ] = Ac(S, community, i)
%a(Cc k, S) is the fraction of edges with
%at least one of the end node lie in communities Ck
%c on the induced subgraph of Gc by S.
%S = induced graph, community = community map, i = the target community
    a = community(:,2) == i;
    a = community(a,1);
    b = ismember(S(:,2),a);
    c = ismember(S(:,1),a);
    e = Ec(S, community, i);
    Aci = (sum(b) + sum(c) - e)^2;
end