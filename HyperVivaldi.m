function position = HyperVivaldi(self_node, nb_node, hop_dst, measured_dst, step)
%HYPERVIVALDI calculates the position of the node accoording to the spring system.

% input:
% self_node, the node that should move.
% nb_node, the node that push the self_node.
% measured_distance.
% step: moving step.

% output:
% position: new position of the self_node.

% convert to polar coordinates.
self_coord = self_node.position;
nb_coord = nb_node.position;

self_rho = norm(self_coord); 
self_theta = CalculateAngle(self_coord);

nb_rho = norm(nb_coord); 
nb_theta = CalculateAngle(nb_coord);

% Calculate the current hyper distance between the two points.
diff_theta = self_theta - nb_theta;
cosh_dst = cosh(self_rho)*cosh(nb_rho) - ...
    sinh(self_rho)*sinh(nb_rho)*cos(diff_theta);
hyperdst =  acosh(cosh_dst);

% Difference between real and current distance.
diffdst = measured_dst - hyperdst;

% Adjust the coordinates accoording to the Vivaldi algorithm.
if hyperdst <= step || self_rho == 0
    
    unit_rand = rand(2,1);
    unit_rand = unit_rand/norm(unit_rand);
    rand_dir =  2 * step * unit_rand;
    position = self_coord + rand_dir;
    
elseif (self_node.degree < nb_node.degree) && ... 
       (self_rho <= nb_rho)
   
    unit_rand = rand(2,1);
    unit_rand = unit_rand/norm(unit_rand);
    rand_dir =  2 * step * unit_rand;
    position = nb_coord + rand_dir; % neighbor coordinate.    

elseif hop_dst == 1 && self_node.degree <= 2
    
    rand_adju_theta = 4*rand(1)*pi/180;
    position(1) = self_rho * cos(nb_theta+rand_adju_theta);
    position(2) = self_rho * sin(nb_theta+rand_adju_theta);
    
else
     
    polar_phi = self_theta;
    
    d_r = (sinh(self_rho)*cosh(nb_rho) -...
           cosh(self_rho)*sinh(nb_rho)*cos(diff_theta))/sqrt(cosh_dst^2-1);
    d_t = (sinh(self_rho)*sinh(nb_rho)*sin(diff_theta))/sqrt(cosh_dst^2-1);
    
    mx = d_r * cos(polar_phi) - ( 1/self_rho )*d_t*sin(polar_phi);
    my = d_r * sin(polar_phi) + ( 1/self_rho )*d_t*cos(polar_phi);
    
    position(1) = self_coord(1) + step * (1/hyperdst)*diffdst*mx;
    position(2) = self_coord(2) + step * (1/hyperdst)*diffdst*my;
    
    %  newcoord(1) = self_coord(1) + step *diffdst*mx;
    %  newcoord(2) = self_coord(2) + step *diffdst*my;
    
end

return

