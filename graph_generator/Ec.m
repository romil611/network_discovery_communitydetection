function [ Eci ] = Ec(S, community, i)
%e(Cc k, S) is the fraction of edges for which both end
%points are in the same community Cc k on the induced subgraph of Gc by S.
%S = induced graph, community = community map, i = the target community

    a = community(:,2) == i;
    a = community(a,1);
    b = ismember(S(:,1),a);
    b = S(b,:);
    Eci = find ( community(b(:,1),2) == community(b(:,2),2) );
    Eci = size(Eci,1);
end

