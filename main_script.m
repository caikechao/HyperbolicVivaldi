% Main script of the vivaldi algorithm on a hyperbolic disk.

% clear the environment and load data.
clear all;close all;
load cnet_370.mat

% some information of the network.
N = length(distMat);
degree_r_vec = sum(connectedNet,1);
short_hop = graphallshortestpaths(sparse(distMat));

% control variables.
init_size = 20;
step = 0.001;
final_polar_coord = zeros(2,N);
iter = 0;itimes = 500;
embed_err = zeros(1,itimes);

% initial the position.
position_mat = InitialPosition(N,degree_r_vec,init_size);

% initial the node struct.
node(1:N) = struct('id',0,'degree',0,'neighbors',[],'position',...
    zeros(2,1));

for node_i = 1:N
    node(node_i).id = node_i;
    node(node_i).degree = degree_r_vec(node_i);
    node(node_i).position = position_mat(:,node_i);
end

node = FindNeighbors(node,short_hop,2,10);

% hyperbolic vivaldi algorithm.

while iter < itimes
    for node_i = 1:N
        for node_j = node(node_i).neighbors
            node(node_i).position = HyperVivaldi(node(node_i),node(node_j),...
                short_hop(node_i,node_j),distMat(node_i,node_j),step);
        end
    end
    iter = iter + 1;
    final_pos = [node.position];
    figure(1),gplot(connectedNet,[final_pos(1,:)',final_pos(2,:)','-*']),axis square;
    
    % Calculate the errors.
    for iresult = 1:N
        final_polar_coord(1,iresult) = norm(final_pos(:,iresult));
        final_polar_coord(2,iresult) = CalculateAngle(final_pos(:,iresult));
    end
    result_dst = CalHyperAllDistance(final_polar_coord(1,:),final_polar_coord(2,:));
    embed_err(iter) = norm((result_dst-distMat), 2);
    
end

 

%function position_mat = InitialPosition(N,degree_vector,init_size)
%function node_struct = FindNeighbors(in_node_struct,hop_mat,nb_method,n_neighbors)
%position = HyperVivaldi(self_node, nb_node, hop_dst, measured_dst, step)