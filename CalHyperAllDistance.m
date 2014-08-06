function dMtx = CalHyperAllDistance(rho,theta)
n =length(rho);dMtx = zeros(n);
for i = 1:n
    for j = i:n
        if i~=j
            dTheta = (theta(i)-theta(j));
            dMtx(i,j) = acosh(cosh(rho(i))*cosh(rho(j))-...
                sinh(rho(i))*sinh(rho(j))*cos(dTheta));
            dMtx(j,i) = dMtx(i,j);
        end
    end
end