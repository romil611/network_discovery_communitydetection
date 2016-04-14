function [ list_com, q, theta, temp] = community_detection2( theta, A, num_com, threshold, iter_max)

%UNTITLED Summary of this function goes here
%Detailed explanation goes here
iter = 0;
diff = inf;
q = zeros([size(A,1),size(A,1),num_com]);
while iter < iter_max && diff > threshold
    iter = iter +1;
    temp = theta*theta';
    for k = 1:num_com
        a = theta(:,k);
        b = repmat(a,[1,size(A,1)]);
        size(b)
        q(:,:,k) = bsxfun(@times,b,a)./temp;
    end

    for k = 1:num_com    
        temp2 = A.*q(:,:,k);
        theta(:,k) = sum(temp2,2)/sqrt(sum(sum(A.*q(:,:,k))));
    end
end
[~,list_com] =  max(theta,[],2);
