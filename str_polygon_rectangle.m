function [ xh,yh ] = str_polygon_rectangle( FID,grid_spacing_pixel,w_pixel,l_pixel )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%%input
pixel_offset=200;
%% calculation 

xv = [pixel_offset pixel_offset+w_pixel pixel_offset+w_pixel pixel_offset pixel_offset ];
yv = [pixel_offset pixel_offset pixel_offset+l_pixel pixel_offset+l_pixel pixel_offset ];

w_point=round(w_pixel/grid_spacing_pixel)*grid_spacing_pixel+pixel_offset; 
l_point=round(l_pixel/grid_spacing_pixel)*grid_spacing_pixel+pixel_offset;


wspace = pixel_offset: grid_spacing_pixel: w_point;
lspace = pixel_offset: grid_spacing_pixel: l_point;
nx = length(wspace);
ny = length(lspace);

[X,Y] = meshgrid(wspace, lspace);
X=reshape(X,1,nx*ny);
Y=reshape(Y,1,nx*ny);

[in,on] = inpolygon(X,Y,xv,yv); 

xh=X(in);
yh=Y(in);
% 
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

