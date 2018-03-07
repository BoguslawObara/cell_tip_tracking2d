%% clear
clc; clear all; close all;

%% path
addpath('./lib');
addpath('../local_threshold2d/lib');
addpath('../local_threshold3d/lib');

%% load image
im = imread3d('./im/cell.tif');

%% normalize
im = double(im); im = (im - min(im(:))) / (max(im(:)) - min(im(:)));

%% segmentation
n = 20; c = -1; s = 5;
imth = false(size(im));
for i=1:size(im,3)
    imth(:,:,i) = cell_segmentation2d(im(:,:,i),n,c,s);
end

%% filter
s1 = 5; s2 = 1;
imthf = false(size(imth));
for i=1:size(imth,3)
    imthf(:,:,i) = cell_segmentation_filtering2d(imth(:,:,i),s1,s2);
end

%% tip segmentation and tracking
% [y,x] = ginput(1);
% x = round(x); y = round(y);

x = 60; y = 284; d = 30; r = [];

imthti = [];
tip = struct([]);
imtht = false(size(imth));
for i=1:size(im,3)
    
    [imthti,r] = cell_tip_segmentation2d(imthf(:,:,i),imthti,x,y,d,r);
    imtht(:,:,i) = imthti;
    
    dc = 2*round(r);
    [center,radius,c,cm,cr,cl,center2] = cell_tip_search2d(imthf(:,:,i),imthti,x,y,dc,1);
    x = center(1); y = center(2);
    x = round(x); y = round(y);

    tip(i).center = center;
    tip(i).radius = radius;
    tip(i).c = c;
    tip(i).cm = cm;
    tip(i).cr = cr;
    tip(i).cl = cl;
    tip(i).center2 = center2;

end

%% tip plot
figure;
for i=1:size(im,3)
    cell_tip_segmentation_plot2d(imthf(:,:,i)+imtht(:,:,i),...
        tip(i).center,tip(i).radius,tip(i).c,...
        tip(i).cm,tip(i).cr,tip(i).cl,tip(i).center2);
    pause(0.1);
end