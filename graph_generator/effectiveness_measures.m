%function [ list_com ] = effectiveness_measure( theta, num_com,actual_com)
clear;
%actual_comm=
load('ire_data_100.mat');
theta=randi([1,28],30,10);
n_nodes=size(theta,1);
labels=zeros(n_nodes,2);
for iter=1:n_nodes
    labels(iter,1)=iter;
    labels(iter,2)=max(theta(iter,:));
end
num_com=28;
E=zeros(num_com,1);
F=zeros(num_com,1);
numerator_purity=0.0;
numerator_entropy=0.0;
for i=1:num_com
   a=(labels(:,2)==i);
   predicted=labels(a,1);
   temp=zeros(num_com,1);
   for j=1:size(predicted)
       actual_label=actual_com(j,2);
       temp(actual_label)=temp(actual_label)+1;
       
   end
   total=sum(temp);
   sum_sq=0.0;
   for j=1:size(predicted)
       temp(j)=temp(j)/total;
       sum_sq=sum_sq+(temp(j)*temp(j));
   end
   E(i)=max(temp);
   F(i)=1-sum_sq;
   %u=size(predicted)
  % E(i)*size(predicted)
   numerator_purity=numerator_purity+(E(i)*size(predicted,1));
   numerator_entropy=numerator_entropy+(F(i)*size(predicted,1));
end
%numerator
purity=numerator_purity/n_nodes
entropy=numerator_entropy/n_nodes

%end