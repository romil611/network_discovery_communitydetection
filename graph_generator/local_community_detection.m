function [ list_com, q, theta] = local_community_detection( theta, q, A, num_com, threshold, local)

%local is the logical index of the locality of the new nodes added
iter = 0;
while iter < threshold
    iter = iter +1;
    temp = theta(local,:)*theta';
    %q = zeros([size(A,1),size(A,1),num_com]);
    for k = 1:num_com
        a = theta(local,k);
        b = repmat(a,[1,size(A,1)]);
        sum(local)
        size(local)
        size(b)
      %  tt = bsxfun(@times,b,theta(:,k))./temp;
     %   size(tt)
     
%         q(local,:,k) = ;
    end

    for k = 1:num_com    
        temp2 = A.*q(local,:,k);
        theta(local,k) = sum(temp2,2)/sqrt(sum(sum(A.*q(:,:,k))));
    end
end
[~,list_com] =  max(theta,[],2);
