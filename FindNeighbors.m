function node_struct = FindNeighbors(in_node_struct,hop_mat,nb_method,n_neighbors)
% FINDNeighbors find the specified neighbors of the nodes.

% 1. 1-hop neighbors; 2. 2---hop neighbors.
% 3. random neighbors;

% 2011-5-27 18:33:58
% Kechao

% Number of nodes:N
N = length(in_node_struct); 
% To find the nodes.
node_seq = 1:N;
% Recover the nodes' id information in the input struct.
node_struct = in_node_struct;

% if nb_method == 1

for node_i = 1:N
    node_struct(node_i).neighbors_1hop = node_seq(hop_mat(node_i,:) == 1);
end

if nb_method == 2
    
    for node_i = 1:N
        neighbors_1 = node_seq(hop_mat(node_i,:) == 1);
        
        if length(neighbors_1) < n_neighbors
            extra_num = n_neighbors - length(neighbors_1);
            neighbors_gt_1 = node_seq(hop_mat(node_i,:) > 1);
            extra_nbs = randsample(neighbors_gt_1,extra_num);
            node_struct(node_i).neighbors = [neighbors_1,extra_nbs];
            
        elseif length(neighbors_1) > n_neighbors
            node_struct(node_i).neighbors = randsample(neighbors_1,n_neighbors);
        end
    end
    
elseif nb_method == 3
    
    for node_i = 1:N
        neighbors_3 = node_seq(hop_mat(node_i,:) >=1 );
        node_struct(node_i).neighbors = randsample(neighbors_3,n_neighbors);
    end
       
end

return