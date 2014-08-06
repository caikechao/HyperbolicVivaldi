function angle_rad = CalculateAngle(vec)
% CALANGLE calculate the angle of a vector in radian.
% INPUT:
% vec is a 2-dimensional vector.
% OUTPUT:
% anglerad returns the angle in radian.
% Reference
% http://en.wikipedia.org/wiki/Polar_coordinate_system

% 2010-11-16 9:37:28
% Version 1.0 Cai kechao @HUST
% Revised:2011-5-26 10:23:26

% NOTICE: Considered MATLAB is an acurrate tool relatively. Here 0 can be
% really present 0, maybe 0 can be regarded as an interval [-1e-6,1e-6].

% vec(1) = x, vec(2) = y
if vec(1) > 0
    angle_rad = atan(vec(2)/vec(1));
elseif vec(1) < 0 && vec(2) >= 0
    angle_rad = atan(vec(2)/vec(1)) + pi;
elseif vec(1) < 0 && vec(2) < 0
    angle_rad = atan(vec(2)/vec(1)) - pi;
elseif vec(1) == 0 && vec(2) > 0
    angle_rad = pi/2;
elseif vec(1) == 0 && vec(2) < 0
    angle_rad = -pi/2;
elseif vec(1) == 0 && vec(2) == 0
    angle_rad = 0;
end