function [ list_com, q, theta] = local_community_detection( theta, q, A, num_com, threshold, loca, iter_maxl)

%local is the logical index of the locality of the new nodes added
iter = 0;
diff = inf;
while iter < iter_max && diff > threshold
    iter = iter +1;
    temp = theta(local,:)*theta';
    %q = zeros([size(A,1),size(A,1),num_com]);
    for k = 1:1
        a = theta(local,k);
        b = repmat(a,[1,size(A,1)]);
        qqqq = bsxfun(@times,b,theta(:,k)')./temp;
        q(local,:,k) = qqqq;
    end

    for k = 1:num_com
        temp3 = q(local,:,k);
        size(A)
        temp2 = A.*temp3;
        theta(local,k) = sum(temp2,2)/sqrt(sum(sum(A.*q(:,:,k))));
    end
end
[~,list_com] =  max(theta,[],2);
