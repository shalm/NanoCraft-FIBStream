function [xh,yh] = str_polygon_50sides( FID,grid_spacing_pixel, dia_pixel )
%UNTITLED3 Summary of this function goes here
%%input
pixel_offset=200;
%% calculation 
L = linspace(0,2*pi,50);
xv = dia_pixel/2*cos(L)'+dia_pixel/2;  %[nm] x corordinates of points on circle
yv = dia_pixel/2*sin(L)'+dia_pixel/2+pixel_offset;   % [nm] y corordinates of points on circle
dotmax=round(dia_pixel/grid_spacing_pixel)*grid_spacing_pixel;  % [nm] adjust the diameter, and find the max coordinate  
dotmin=-dia_pixel/2 ;   %min coordinate 

xspace = dotmin: grid_spacing_pixel: dotmax; 
yspace = dotmin: grid_spacing_pixel: dotmax;
nx = length(xspace);
ny = length(yspace);

[X,Y] = meshgrid(xspace, yspace);
X=reshape(X,1,nx*ny);
Y=reshape(Y,1,nx*ny)+pixel_offset+dia_pixel/2;

[in,on] = inpolygon(X,Y,xv,yv); 

xh=X(in);
yh=Y(in);

%% randomizing the order
rand_index = randperm(length(xh));
xh = xh(rand_index);
yh = yh(rand_index);

% plot(xv,yv) % polygon
% axis equal
% 
% hold on
% plot(X(in),Y(in),'ro') % points inside
% hold off
end

