function [ list_com ] = community_detection( theta, A, num_com)

%UNTITLED Summary of this function goes here
%Detailed explanation goes here

temp = theta*theta';
q = zeros([size(A,1),size(A,1),num_com]);
for k = 1:num_com
    a = theta(:,k);
    b = repmat(a,[1,size(A,1)]);
    q(:,:,k) = bsxfun(@times,b,a)./temp;
end

for k = 1:num_com    
    temp2 = A.*q(:,:,k);
    theta(:,k) = sum(temp2,2)/sqrt(sum(sum(A.*q(:,:,k))));
end

[~,list_com] =  max(theta,[],2);
