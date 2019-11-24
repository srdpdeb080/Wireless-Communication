%Wireless Communication Assignment #3
%Question #6
mu = 10;

b = 8;
sz = [50000 1];

x = laplacian_noise(mu,b,sz);
hist(x,100)