function out_node_struct = InitialPosition(in_node_struct,init_size)
%INITIALPOSITION initiallizes the positions of the nodes in the 2D disk.

% input: 
% N: number of nodes.
% degree_vector: degree of the nodes in a ROW vector.
% init_size: size of the initial disk.

% output:
% position_mat: the position matrix in Euclidean form (size = 2xN).

% purpose:
% distribute the nodes according to the degree, the smaller the degree, the
% closer to the edge of the disk.

% 2011-5-26 21:25:24
% Kechao
% Revised: 2011-5-30 9:54:10
% Kechao

% Verification of the input.
% if length(hop_mat) ~= length(in_node_struct)
%     error('myApp:argChk','Wrong input,how many number of nodes?')
% end

out_node_struct = in_node_struct;
% Generate the degree vector.(Horizontal cat)
degree_vector = [in_node_struct.degree];
% Assign the Polar coordinates.
rand_radius = 1./(degree_vector+1) * init_size;
rand_theta = 2*pi*rand(1,N);

for node_i = 1:length(in_node_struct)
    for node_j = in_node_struct(node_i).neighbors_1hop
        if degree_vector(node_i) < degree_vector(node_j)...
                && degree_vector(node_i) <= 2
            
            rand_theta(node_i) = rand_theta(node_j) + 4*rand(1)*pi/180;
            
            % Transform Polar to Euclidean.
            x = rand_radius(node_i).*cos(rand_theta(node_i));
            y = rand_radius(node_i).*sin(rand_theta(node_i));
            % Output the Euclidean coordinates.
            out_node_struct(node_i).position = [x;y];
            
        end
    end
end

return



