%Wireless Communication Assignment #3
%Question #6

function x = laplacian_noise(mu,b,sz)

if nargin < 1 % Equal to exponential distribution scaled by 1/2
    mu = 0;
end
if nargin < 2
    b = 1;
end
if nargin < 3
    sz = 1;
end

u = rand(sz) - 0.5;
x = mu - b*sign(u) .* log(1-2*abs(u));

end

